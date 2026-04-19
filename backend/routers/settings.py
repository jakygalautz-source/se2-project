from fastapi import APIRouter
from schemas import SettingsResponse, SettingsUpdate

#-------------------------------------------
# initialize router for reminder EP
#-------------------------------------------
router = APIRouter()


settings_data = {
    "username": "Saskia",
    "email": "saskia@example.com"
}

@router.get("/settings", response_model=SettingsResponse)
async def get_settings():
    return settings_data

@router.post("/settings")
async def save_settings(settings: SettingsUpdate):
    global settings_data
    settings_data = {
        "username": settings.username,
        "email": settings.email
    }
    return {"message": "Settings saved"}