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

class UserRegister(BaseModel):
    username: str
    email: EmailStr
    password: str

class UserLogin(BaseModel):
    email: EmailStr
    password: str

class UserResponse(BaseModel):
    id: int
    username: str
    email: EmailStr

class LoginResponse(BaseModel):
    id: int
    username: str
    email: EmailStr
    access_token: str
    token_type: str