from pydantic import BaseModel
from typing import List


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

class ReminderTimes(BaseModel):
    morning: str
    noon: str
    evening: str
    night: str