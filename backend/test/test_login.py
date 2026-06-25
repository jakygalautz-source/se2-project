from uuid import uuid4
from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_login_returns_200_with_correct_password():
    email = f"login-{uuid4()}@example.com"
    password = "123456"

    register_response = client.post("/register", json={
        "username": "LoginUser",
        "email": email,
        "password": password
    })

    assert register_response.status_code == 201, register_response.text

    login_response = client.post("/login", json={
        "email": email,
        "password": password
    })

    assert login_response.status_code == 200, login_response.text

    data = login_response.json()
    assert data["email"] == email
    assert data["username"] == "LoginUser"
    assert "id" in data


def test_login_returns_401_with_wrong_password():
    email = f"wrong-password-{uuid4()}@example.com"

    register_response = client.post("/register", json={
        "username": "LoginUser",
        "email": email,
        "password": "123456"
    })

    assert register_response.status_code == 201, register_response.text

    login_response = client.post("/login", json={
        "email": email,
        "password": "wrongpassword"
    })

    assert login_response.status_code == 401, login_response.text