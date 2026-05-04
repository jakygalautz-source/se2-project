from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from sqlalchemy import text

from database import get_db
from schemas import ReminderTimes

#-------------------------------------------
# initialize router for reminder EP
#-------------------------------------------
router = APIRouter()

#-------------------------------------------
# WITHOUT DATABASE SETTINGS -> In-memory storage for global reminder times
#-------------------------------------------
#reminder_times = {
#    "morning": "08:00",
#    "noon": "12:00",
#    "evening": "17:00",
#    "night": "21:00"
#}

# -------------------------------------------
# GET - REMINDER TIMES
# Returns the currently stored reminder times
# -------------------------------------------
@router.get("/reminder-times")
def get_reminder_times(
    db: Session = Depends(get_db)
):
    try:
        # Get the first reminder time entry from the database
        reminder_times = db.execute(
            text("""
                SELECT 
                    to_char(morning, 'HH24:MI') AS morning,
                    to_char(noon, 'HH24:MI') AS noon,
                    to_char(evening, 'HH24:MI') AS evening,
                    to_char(night, 'HH24:MI') AS night
                FROM reminder_times
                ORDER BY id
                LIMIT 1
            """)
        ).fetchone()

        # If no reminder times exist yet, return default values
        if reminder_times is None:
            return {
                "morning": "08:00",
                "noon": "12:00",
                "evening": "17:00",
                "night": "21:00"
            }

        # Return reminder times in frontend format
        return {
            "morning": reminder_times[0],
            "noon": reminder_times[1],
            "evening": reminder_times[2],
            "night": reminder_times[3]
        }

    except Exception as error:
        raise HTTPException(
            status_code=500,
            detail=f"Could not load reminder times: {str(error)}"
        )


# -------------------------------------------
# POST - REMINDER TIMES
# Saves or updates the global reminder times
# -------------------------------------------
@router.post("/reminder-times")
def save_reminder_times(
    times: ReminderTimes,
    db: Session = Depends(get_db)
):
    try:
        # Check if reminder times already exist
        existing_times = db.execute(
            text("""
                SELECT id
                FROM reminder_times
                ORDER BY id
                LIMIT 1
            """)
        ).fetchone()

        # If no entry exists, create one
        if existing_times is None:
            db.execute(
                text("""
                    INSERT INTO reminder_times 
                    (morning, noon, evening, night)
                    VALUES (
                        CAST(:morning AS TIME),
                        CAST(:noon AS TIME),
                        CAST(:evening AS TIME),
                        CAST(:night AS TIME)
                    )
                """),
                {
                    "morning": times.morning,
                    "noon": times.noon,
                    "evening": times.evening,
                    "night": times.night
                }
            )

        # If an entry exists, update it
        else:
            reminder_times_id = existing_times[0]

            db.execute(
                text("""
                    UPDATE reminder_times
                    SET morning = CAST(:morning AS TIME),
                        noon = CAST(:noon AS TIME),
                        evening = CAST(:evening AS TIME),
                        night = CAST(:night AS TIME),
                        updated_at = CURRENT_TIMESTAMP
                    WHERE id = :id
                """),
                {
                    "id": reminder_times_id,
                    "morning": times.morning,
                    "noon": times.noon,
                    "evening": times.evening,
                    "night": times.night
                }
            )

        # Save database changes
        db.commit()

        # Return saved reminder times
        return {
            "morning": times.morning,
            "noon": times.noon,
            "evening": times.evening,
            "night": times.night
        }

    except Exception as error:
        db.rollback()

        raise HTTPException(
            status_code=500,
            detail=f"Could not save reminder times: {str(error)}"
        )
