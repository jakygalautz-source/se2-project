from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from sqlalchemy import text

from database import get_db
from schemas import SettingsResponse, SettingsUpdate

#-------------------------------------------
# initialize router for reminder EP
#-------------------------------------------
router = APIRouter()


# -------------------------------------------
# GET - SETTINGS
# Returns the current user settings
# -------------------------------------------
@router.get("/settings", response_model=SettingsResponse)
def get_settings(
    db: Session = Depends(get_db)
):
    # Temporary fixed user ID until login/authentication exists
    user_id = 1

    try:
        # Get user settings from database
        user = db.execute(
            text("""
                SELECT username, email
                FROM users
                WHERE id = :user_id
            """),
            {
                "user_id": user_id
            }
        ).fetchone()

        # If no user was found, return 404
        if user is None:
            raise HTTPException(
                status_code=404,
                detail="User not found"
            )

        # Return data in frontend format
        return {
            "username": user[0],
            "email": user[1]
        }

    except HTTPException:
        raise

    except Exception as error:
        raise HTTPException(
            status_code=500,
            detail=f"Could not load settings: {str(error)}"
        )


# -------------------------------------------
# POST - SETTINGS
# Saves or updates the current user settings
# -------------------------------------------
@router.post("/settings")
def save_settings(
    settings: SettingsUpdate,
    db: Session = Depends(get_db)
):
    # Temporary fixed user ID until login/authentication exists
    user_id = 1

    try:
        # Check if user exists
        user = db.execute(
            text("""
                SELECT id
                FROM users
                WHERE id = :user_id
            """),
            {
                "user_id": user_id
            }
        ).fetchone()

        if user is None:
            raise HTTPException(
                status_code=404,
                detail="User not found"
            )

        # If password is empty or None, only update username and email
        if settings.password is None or settings.password == "":
            db.execute(
                text("""
                    UPDATE users
                    SET username = :username,
                        email = :email,
                        updated_at = CURRENT_TIMESTAMP
                    WHERE id = :user_id
                """),
                {
                    "user_id": user_id,
                    "username": settings.username,
                    "email": settings.email
                }
            )

        # If password is provided, also update password_hash
        else:
            db.execute(
                text("""
                    UPDATE users
                    SET username = :username,
                        email = :email,
                        password_hash = :password_hash,
                        updated_at = CURRENT_TIMESTAMP
                    WHERE id = :user_id
                """),
                {
                    "user_id": user_id,
                    "username": settings.username,
                    "email": settings.email,
                    "password_hash": settings.password
                }
            )

        # Save database changes
        db.commit()

        return {
            "message": "Settings saved"
        }

    except HTTPException:
        raise

    except Exception as error:
        db.rollback()

        raise HTTPException(
            status_code=500,
            detail=f"Could not save settings: {str(error)}"
        )