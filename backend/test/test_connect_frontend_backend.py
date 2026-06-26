from fastapi.testclient import TestClient
from main import app

client = TestClient(app)


def test_get_root_returns_200_and_json():
    response = client.get("/")

    assert response.status_code == 200
    assert response.headers["content-type"].startswith("application/json")
    assert isinstance(response.json(), dict)
    assert "message" in response.json()


def test_response_is_json():
    response = client.get("/")

    assert response.status_code == 200
    assert response.headers["content-type"].startswith("application/json")


def test_backend_accept_request():
    response = client.get(
        "/",
        headers={"Origin": "http://localhost:3000"},
    )
    assert response.status_code == 200
    assert response.headers["Content-type"].startswith("application/json")
    assert "message" in response.json()