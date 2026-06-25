from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_get_meds_return_200():
    response = client.get("/medications")

    assert response.status_code == 200, response.text
    assert isinstance(response.json(), list)