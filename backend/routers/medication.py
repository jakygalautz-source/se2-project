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
# POST - MEDICATION
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
# GET - MEDICATION
#-------------------------------------------

@router.get("/medications")
async def get_medications():
    return medications

#-------------------------------------------
# DELETE - MEDICATION
#-------------------------------------------

@router.delete("/medications/{id}")
async def delete_medications(id: int):
    for index, medication in enumerate(medications):
        if medication["id"] == id:
            medications.pop(index)
            return {"message": "Medication deleted"}
    
    raise HTTPException(status_code=404, detail="Medication not found")

#-------------------------------------------
# UPDATE - MEDICATION
#-------------------------------------------

@router.put("/medications/{id}")
async def update_medications(id: int, updated_medication: Medication):
    for index, medication in enumerate(medications):
        if medication["id"] == id:
            medication_data = updated_medication.model_dump()
            medication_data["id"] = id
            medications[index] = medication_data
            return medication_data
    
    raise HTTPException(status_code=404, detail="Medication not found")
