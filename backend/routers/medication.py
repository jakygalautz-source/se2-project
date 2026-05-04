from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from sqlalchemy import text
from database import get_db
from schemas import Medication

router = APIRouter()

#-------------------------------------------
# database needed - List for testing
#-------------------------------------------

# List instead of DATABASE
#medications = []
# variable for testing ID
#next_id = 1

#-------------------------------------------
# POST - MEDICATION
#-------------------------------------------

@router.post("/medications", status_code=201)
async def create_medication(medication: Medication):
    global next_id ## TO BE CHANGED

    medication_data = medication.model_dump() ## TO BE CHANGED
    medication_data["id"] = next_id ## TO BE CHANGED

    medications.append(medication_data)
    next_id += 1
    
    return medication_data

#-------------------------------------------
# GET - MEDICATION
#-------------------------------------------

@router.get("/medications")
def get_medications(db: Session = Depends(get_db)):
    # Temporary fixed user ID until login exists
    user_id = 1

    # Get all medications for this user
    medications = db.execute(
        text("""
            SELECT id, name
            FROM medications
            WHERE user_id = :user_id
            ORDER BY id
        """),
        {"user_id": user_id}
    ).fetchall()

    result = []

    # For each medication, get the related intakes
    for medication in medications:
        medication_id = medication[0]

        intakes = db.execute(
            text("""
                SELECT day_part, amount, reminder
                FROM medication_intakes
                WHERE medication_id = :medication_id
                ORDER BY id
            """),
            {"medication_id": medication_id}
        ).fetchall()

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

#-------------------------------------------
# DELETE - MEDICATION
#-------------------------------------------

@router.delete("/medications/{id}")
async def delete_medications(id: int):
    for index, medication in enumerate(medications):
        if medication["id"] == id:
            medications.pop(index)
            return {"message": "Medication deleted"}
    
    raise HTTPException(status_code=404, detail="Medication not found")

#-------------------------------------------
# UPDATE - MEDICATION
#-------------------------------------------

@router.put("/medications/{id}")
async def update_medications(id: int, updated_medication: Medication):
    for index, medication in enumerate(medications):
        if medication["id"] == id:
            medication_data = updated_medication.model_dump()
            medication_data["id"] = id
            medications[index] = medication_data
            return medication_data
    
    raise HTTPException(status_code=404, detail="Medication not found")
