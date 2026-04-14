from fastapi import APIRouter
from schemas import ReminderTimes

#-------------------------------------------
# initialize router for reminder EP
#-------------------------------------------
router = APIRouter()

#-------------------------------------------
# In-memory storage for global reminder times
#-------------------------------------------
reminder_times = {
    "morning": "08:00",
    "noon": "12:00",
    "evening": "17:00",
    "night": "21:00"
}

#-------------------------------------------
# GET - REMINDER-TIMES
#-------------------------------------------
@router.get("/reminder-times")
async def get_reminder_times():
    return reminder_times

#-------------------------------------------
# POST - REMINDER-TIMES
#-------------------------------------------
@router.post("/reminder-times")
async def save_reminder_times(times: ReminderTimes):
    global reminder_times
    reminder_times = times.model_dump()
    return reminder_times

