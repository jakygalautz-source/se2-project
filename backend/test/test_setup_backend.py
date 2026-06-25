from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_root_endpoint_returns_200():
    response = client.get("/")

    assert response.status_code == 200
    assert "message" in response.json()


def test_server_app_can_be_created():
    assert app is not None