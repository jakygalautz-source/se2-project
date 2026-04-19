from fastapi import APIRouter, HTTPException
from schemas import Medication

router = APIRouter()

#-------------------------------------------
# database needed - List for testing
#-------------------------------------------

# List instead of DATABASE
medications = []
# variable for testing ID
next_id = 1

#-------------------------------------------
# POST - MEDICATIONS
#-------------------------------------------

@router.post("/medications", status_code=201)
async def create_medication(medication: Medication):
    global next_id ## TO BE CHANGED

    medication_data = medication.model_dump() ## TO BE CHANGED
    medication_data["id"] = next_id ## TO BE CHANGED

    medications.append(medication_data)
    next_id += 1
    
    return medication_data

#-------------------------------------------
# GET - MEDICATIONS
#-------------------------------------------

@router.get("/medications")
async def get_medications():
    return medications

#-------------------------------------------
# DELETE - MEDICATIONS
#-------------------------------------------

@router.delete("/medications/{id}")
async def delete_medications(id: int):
    for index, medication in enumerate(medications):
        if medication["id"] == id:
            medications.pop(index)
            return {"message": "Medication deleted"}
    
    raise HTTPException(status_code=404, detail="Medication not found")
