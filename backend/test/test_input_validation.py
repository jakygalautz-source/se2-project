from fastapi.testclient import TestClient
from main import app

client = TestClient(app)


def test_register_rejects_invalid_email():
    response = client.post(
        "/register",
        json={
            "username": "Testuser",
            "email": "ungueltige-email",
            "password": "123456"
        }
    )

    assert response.status_code == 422


def test_register_rejects_missing_username():
    response = client.post(
        "/register",
        json={
            "email": "test@example.com",
            "password": "123456"
        }
    )

    assert response.status_code == 422


def test_register_rejects_missing_password():
    response = client.post(
        "/register",
        json={
            "username": "Testuser",
            "email": "test@example.com"
        }
    )

    assert response.status_code == 422


def test_login_rejects_invalid_email():
    response = client.post(
        "/login",
        json={
            "email": "keine-email",
            "password": "123456"
        }
    )

    assert response.status_code == 422