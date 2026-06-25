from datetime import datetime

from fastapi.testclient import TestClient
from main import app

client = TestClient(app)


def create_test_medication():
    response = client.post(
        "/medications",
        json={
            "name": "Test Medikament",
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
    return response.json()["id"]


def test_confirm_intake_returns_201_with_timestamp():
    medication_id = create_test_medication()

    response = client.post(
        "/intake-history",
        json={
            "user_id": 1,
            "medication_id": medication_id
        }
    )

    assert response.status_code == 201, response.text

    data = response.json()

    assert "id" in data
    assert data["user_id"] == 1
    assert data["medication_id"] == medication_id
    assert "confirmed_at" in data

    datetime.fromisoformat(data["confirmed_at"])