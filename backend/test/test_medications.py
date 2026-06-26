from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_put_meds_return_200():
    create_respone = client.post("/medications", json={
        "name" : "Ibuprofen",
        "intakes" : [
            {
                "dayPart": "morning",
                "amount" : 1.0,
                "reminder": True
            }
        ]
    })

    assert create_respone.status_code == 201, create_respone.text

    medication_id = create_respone.json()["id"]

    update_response = client.put(f"/medications/{medication_id}", json ={
        "name": "Paracetamol",
        "intakes": [
            {
                "dayPart": "evening",
                "amount": 2.0,
                "reminder": False
            }
        ]
    })

    assert update_response.status_code == 200, update_response.text

    data = update_response.json()
    assert data["id"] == medication_id
    assert data["name"] == "Paracetamol"
    assert data["intakes"][0]["dayPart"] == "evening"
    assert data["intakes"][0]["amount"] == 2.0
    assert data["intakes"][0]["reminder"] is False