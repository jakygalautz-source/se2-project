from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from sqlalchemy import text
from database import get_db
from schemas import Medication

# -------------------------------------------
# Create router for medication endpoints
# -------------------------------------------

router = APIRouter()

#-------------------------------------------
# database needed - List for testing
#-------------------------------------------

# List instead of DATABASE
#medications = []
# variable for testing ID
#next_id = 1

# -------------------------------------------
# POST - MEDICATION
# Creates a new medication and saves it in the database
# -------------------------------------------

@router.post("/medications", status_code=201)
async def create_medication(
    medication: Medication, 
    db: Session = Depends(get_db)
    ):
    
    # Temporary fixed user ID until login/authentication exists
    user_id = 1

    try:
        # Insert medication into the medications table
        # RETURNING id gives back the new generated ID
        new_medication = db.execute(
            text("""
                INSERT INTO medications (user_id, name)
                VALUES (:user_id, :name)
                RETURNING id
            """),
            {
                "user_id": user_id,
                "name": medication.name
            }
        ).fetchone()

        # Save the new medication ID
        medication_id = new_medication[0]

        # Insert all intake entries for this medication
        for intake in medication.intakes:
            db.execute(
                text("""
                    INSERT INTO medication_intakes
                    (medication_id, day_part, amount, reminder)
                    VALUES (:medication_id, :day_part, :amount, :reminder)
                """),
                {
                    "medication_id": medication_id,
                    "day_part": intake.dayPart,
                    "amount": intake.amount,
                    "reminder": intake.reminder
                }
            )

        # Save all database changes
        db.commit()

        # Return medication in the same format as the frontend expects
        return {
            "id": medication_id,
            "name": medication.name,
            "intakes": [
                {
                    "dayPart": intake.dayPart,
                    "amount": intake.amount,
                    "reminder": intake.reminder
                }
                for intake in medication.intakes
            ]
        }

    except Exception as error:
        # Undo database changes if something goes wrong
        db.rollback()

        raise HTTPException(
            status_code=500,
            detail=f"Could not create medication: {str(error)}"
        )


# -------------------------------------------
# GET - MEDICATION
# Returns all medications from the database
# -------------------------------------------
@router.get("/medications")
def get_medications(
    db: Session = Depends(get_db)
):
    # Temporary fixed user ID until login/authentication exists
    user_id = 1

    # Get all medications for this user
    medications = db.execute(
        text("""
            SELECT id, name
            FROM medications
            WHERE user_id = :user_id
            ORDER BY id
        """),
        {
            "user_id": user_id
        }
    ).fetchall()

    result = []

    # For each medication, get the related intake entries
    for medication in medications:
        medication_id = medication[0]

        intakes = db.execute(
            text("""
                SELECT day_part, amount, reminder
                FROM medication_intakes
                WHERE medication_id = :medication_id
                ORDER BY id
            """),
            {
                "medication_id": medication_id
            }
        ).fetchall()

        # Build response in frontend format
        result.append({
            "id": medication[0],
            "name": medication[1],
            "intakes": [
                {
                    "dayPart": intake[0],
                    "amount": float(intake[1]),
                    "reminder": intake[2]
                }
                for intake in intakes
            ]
        })

    return result


# -------------------------------------------
# DELETE - MEDICATION
# Deletes one medication by ID
# -------------------------------------------
@router.delete("/medications/{id}")
def delete_medication(
    id: int,
    db: Session = Depends(get_db)
):
    try:
        # Delete medication from database
        # Related intakes are deleted automatically because of ON DELETE CASCADE
        result = db.execute(
            text("""
                DELETE FROM medications
                WHERE id = :id
            """),
            {
                "id": id
            }
        )

        # Save database changes
        db.commit()

        # If no row was deleted, the medication does not exist
        if result.rowcount == 0:
            raise HTTPException(
                status_code=404,
                detail="Medication not found"
            )

        return {
            "message": "Medication deleted"
        }

    except HTTPException:
        raise

    except Exception as error:
        db.rollback()

        raise HTTPException(
            status_code=500,
            detail=f"Could not delete medication: {str(error)}"
        )


# -------------------------------------------
# PUT - MEDICATION
# Updates one medication by ID
# -------------------------------------------
@router.put("/medications/{id}")
def update_medication(
    id: int,
    updated_medication: Medication,
    db: Session = Depends(get_db)
):
    try:
        # Check if medication exists
        existing_medication = db.execute(
            text("""
                SELECT id
                FROM medications
                WHERE id = :id
            """),
            {
                "id": id
            }
        ).fetchone()

        if existing_medication is None:
            raise HTTPException(
                status_code=404,
                detail="Medication not found"
            )

        # Update medication name
        db.execute(
            text("""
                UPDATE medications
                SET name = :name,
                    updated_at = CURRENT_TIMESTAMP
                WHERE id = :id
            """),
            {
                "id": id,
                "name": updated_medication.name
            }
        )

        # Delete old intake entries
        db.execute(
            text("""
                DELETE FROM medication_intakes
                WHERE medication_id = :id
            """),
            {
                "id": id
            }
        )

        # Insert new intake entries
        for intake in updated_medication.intakes:
            db.execute(
                text("""
                    INSERT INTO medication_intakes
                    (medication_id, day_part, amount, reminder)
                    VALUES (:medication_id, :day_part, :amount, :reminder)
                """),
                {
                    "medication_id": id,
                    "day_part": intake.dayPart,
                    "amount": intake.amount,
                    "reminder": intake.reminder
                }
            )

        # Save database changes
        db.commit()

        # Return updated medication in frontend format
        return {
            "id": id,
            "name": updated_medication.name,
            "intakes": [
                {
                    "dayPart": intake.dayPart,
                    "amount": intake.amount,
                    "reminder": intake.reminder
                }
                for intake in updated_medication.intakes
            ]
        }

    except HTTPException:
        raise

    except Exception as error:
        db.rollback()

        raise HTTPException(
            status_code=500,
            detail=f"Could not update medication: {str(error)}"
        )