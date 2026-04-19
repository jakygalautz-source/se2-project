# FastAPI entry point (to be implemented)

from fastapi import FastAPI
import uvicorn

#-------------------------------------------
# Import API routers
#-------------------------------------------
from routers.medication import router as medication_router
from routers.reminder_times import router as reminder_times_router


#-------------------------------------------
# FastAPI appication instance
#-------------------------------------------
app = FastAPI()

#-------------------------------------------
# Register routers from EP
#-------------------------------------------
app.include_router(medication_router)
app.include_router(reminder_times_router)


#-------------------------------------------
#test-endpoint 
#-------------------------------------------
@app.get("/")
def root():
    return{"message": "Backend läuft"}

#-------------------------------------------
# Start the development server
#-------------------------------------------
if __name__ == "__main__":
    uvicorn.run("main:app", reload=True)