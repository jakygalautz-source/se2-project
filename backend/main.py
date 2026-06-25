# FastAPI entry point (to be implemented)

from fastapi import FastAPI, Depends
import uvicorn


#-------------------------------------------
# Import API routers
#-------------------------------------------
from routers.medication import router as medication_router
from routers.reminder_times import router as reminder_times_router
from routers.settings import router as settings_router
from routers.auth import router as auth_router

from sqlalchemy.orm import Session
from sqlalchemy import text

from database import get_db



#-------------------------------------------
# FastAPI appication instance
#-------------------------------------------
app = FastAPI()

#-------------------------------------------
# Register routers from EP
#-------------------------------------------
app.include_router(medication_router)
app.include_router(reminder_times_router)
app.include_router(settings_router)
app.include_router(auth_router)


#-------------------------------------------
#test-endpoint 
#-------------------------------------------
@app.get("/")
def root():
    return{"message": "Backend läuft"}

# -------------------------------------------
# Database test endpoint
# -------------------------------------------
@app.get("/db-test")
def db_test(db: Session = Depends(get_db)):
    result = db.execute(text("SELECT 1")).scalar()
    return {"database_connection": result}

#-------------------------------------------
# Start the development server
#-------------------------------------------
if __name__ == "__main__":
    uvicorn.run("main:app", reload=True)