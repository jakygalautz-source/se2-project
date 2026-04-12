# FastAPI entry point (to be implemented)

from fastapi import FastAPI
from pydantic import BaseModel
from typing import List
import uvicorn

app = FastAPI()

#-------------------------------------------
#first test-endpoint
#-------------------------------------------

@app.get("/")
def root():
    return{"message": "Backend läuft"}

#-------------------------------------------
#classes
#-------------------------------------------

class Intake(BaseModel):
    dayPart: str
    amount: float
    reminder: bool

class Medication(BaseModel):
    name: str
    intakes: List[Intake]

#-------------------------------------------
# database needed - List for testing
#-------------------------------------------

medications = []

#-------------------------------------------
# POST - EP
#-------------------------------------------

@app.post("/medications", status_code=201)
async def create_medication(medication: Medication):
    medications.append(medication.model_dump())
    return medication

#-------------------------------------------
# GET - EP
#-------------------------------------------

@app.get("/medications")
async def get_medications():
    return medications

if __name__ == "__main__":
    uvicorn.run("main:app", reload=True)