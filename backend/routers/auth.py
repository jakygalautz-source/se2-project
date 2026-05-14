from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from sqlalchemy import text
import bcrypt

from database import get_db
from schemas import UserRegister, UserLogin, UserResponse


router = APIRouter()


def hash_password(password: str) -> str:
    password_bytes = password.encode("utf-8")
    hashed_password = bcrypt.hashpw(password_bytes, bcrypt.gensalt())
    return hashed_password.decode("utf-8")


def verify_password(password: str, password_hash: str) -> bool:
    password_bytes = password.encode("utf-8")
    password_hash_bytes = password_hash.encode("utf-8")
    return bcrypt.checkpw(password_bytes, password_hash_bytes)


@router.post("/register", status_code=201)
def register(
    user: UserRegister,
    db: Session = Depends(get_db)
):
    try:
        if user.username.strip() == "":
            raise HTTPException(status_code=400, detail="Username is required")

        if user.password.strip() == "":
            raise HTTPException(status_code=400, detail="Password is required")

        if len(user.password) < 6:
            raise HTTPException(
                status_code=400,
                detail="Password must have at least 6 characters"
            )

        existing_user = db.execute(
            text("""
                SELECT id
                FROM users
                WHERE email = :email
            """),
            {
                "email": user.email
            }
        ).fetchone()

        if existing_user is not None:
            raise HTTPException(
                status_code=409,
                detail="Email already exists"
            )

        password_hash = hash_password(user.password)

        db.execute(
            text("""
                INSERT INTO users (username, email, password_hash)
                VALUES (:username, :email, :password_hash)
            """),
            {
                "username": user.username,
                "email": user.email,
                "password_hash": password_hash
            }
        )

        db.commit()

        return {
            "message": "User created"
        }

    except HTTPException:
        raise

    except Exception as error:
        db.rollback()
        raise HTTPException(
            status_code=500,
            detail=f"Could not create user: {str(error)}"
        )


@router.post("/login", response_model=UserResponse)
def login(
    login_data: UserLogin,
    db: Session = Depends(get_db)
):
    try:
        user = db.execute(
            text("""
                SELECT id, username, email, password_hash
                FROM users
                WHERE email = :email
            """),
            {
                "email": login_data.email
            }
        ).fetchone()

        if user is None:
            raise HTTPException(
                status_code=401,
                detail="Login failed"
            )

        user_id = user[0]
        username = user[1]
        email = user[2]
        password_hash = user[3]

        if not verify_password(login_data.password, password_hash):
            raise HTTPException(
                status_code=401,
                detail="Login failed"
            )

        return {
            "id": user_id,
            "username": username,
            "email": email
        }

    except HTTPException:
        raise

    except Exception as error:
        raise HTTPException(
            status_code=500,
            detail=f"Could not login user: {str(error)}"
        )