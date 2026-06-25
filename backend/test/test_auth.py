from uuid import uuid4
from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_register_valid_body_returns_201():
    email = f"test-{uuid4()}@example.com"

    response = client.post("/register", json={
        "username": "Testuser",
        "email": email,
        "password": "123456"
    })

    assert response.status_code == 201, response.text
    assert response.json()["message"] == "User created"


def test_register_duplicate_email_returns_409():
    email = f"duplicate-{uuid4()}@example.com"

    body = {
        "username": "Testuser",
        "email": email,
        "password": "123456"
    }

    first_response = client.post("/register", json=body)
    second_response = client.post("/register", json=body)

    assert first_response.status_code == 201
    assert second_response.status_code == 409


def test_register_missing_field_returns_error():
    response = client.post("/register", json={
        "username": "Testuser",
        "password": "123456"
    })

    assert response.status_code in [400, 422]