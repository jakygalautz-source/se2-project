from fastapi.testclient import TestClient
from sqlalchemy import text

from main import app
from database import SessionLocal

client = TestClient(app)


def test_create_medication_returns_201():
    response = client.post(
        "/medications",
        json={
            "name": "Ibuprofen",
            "intakes": [
                {
                    "dayPart": "morning",
                    "amount": 1.0,
                    "reminder": True
                }
            ]
        }
    )

    assert response.status_code == 201, response.text

    data = response.json()

    assert "id" in data
    assert data["name"] == "Ibuprofen"
    assert data["intakes"][0]["dayPart"] == "morning"
    assert data["intakes"][0]["amount"] == 1.0
    assert data["intakes"][0]["reminder"] is True


def test_create_medication_without_name_is_rejected():
    response = client.post(
        "/medications",
        json={
            "intakes": [
                {
                    "dayPart": "morning",
                    "amount": 1.0,
                    "reminder": True
                }
            ]
        }
    )

    assert response.status_code in [400, 422]


def test_create_medication_is_saved_with_user_id():
    response = client.post(
        "/medications",
        json={
            "name": "Paracetamol",
            "intakes": [
                {
                    "dayPart": "evening",
                    "amount": 0.5,
                    "reminder": False
                }
            ]
        }
    )

    assert response.status_code == 201, response.text

    medication_id = response.json()["id"]

    db = SessionLocal()

    try:
        saved_medication = db.execute(
            text("""
                SELECT user_id
                FROM medications
                WHERE id = :id
            """),
            {
                "id": medication_id
            }
        ).fetchone()

        assert saved_medication is not None
        assert saved_medication[0] == 1

    finally:
        db.close()