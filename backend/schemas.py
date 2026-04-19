from pydantic import BaseModel, EmailStr
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

class SettingsResponse(BaseModel):
    username: str
    email: EmailStr

class SettingsUpdate(BaseModel):
    username: str
    email: EmailStr
    password: str | None = None #WARUM??