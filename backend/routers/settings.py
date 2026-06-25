from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from sqlalchemy import text
import bcrypt

from database import get_db
from schemas import SettingsResponse, SettingsUpdate
from routers.auth import get_current_user_id

#-------------------------------------------
# initialize router for reminder EP
#-------------------------------------------
router = APIRouter()

def hash_password(password: str) -> str:
    password_bytes = password.encode("utf-8")
    hashed_password = bcrypt.hashpw(password_bytes, bcrypt.gensalt())
    return hashed_password.decode("utf-8")


# -------------------------------------------
# GET - SETTINGS
# Returns the current user settings
# -------------------------------------------
@router.get("/settings", response_model=SettingsResponse)
def get_settings(
    db: Session = Depends(get_db),
    user_id: int = Depends(get_current_user_id)
):


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
    db: Session = Depends(get_db),
    user_id: int = Depends(get_current_user_id)
):

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
                    "password_hash": hash_password(settings.password)
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