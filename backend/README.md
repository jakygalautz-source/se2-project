# FastAPI backend for Pill Pilot

## Frontend sends JSON in this format:

### POST /medications
Used to create or save a medication.

Example json:
```json
{
  "name": "Ibuprofen",
  "intakes": [
    {
      "dayPart": "morning",
      "amount": 1.0,
      "reminder": true
    }
  ]
}
```

## Expected:
- Endpoint to receive and store medication data
- Response: 200 or 201

### GET /medications
Used to return all medications for the frontend list page.

Expected response:
```json
[
  {
    "id": 1,
    "name": "Ibuprofen",
    "intakes": [
      {
        "dayPart": "morning",
        "amount": 1.0,
        "reminder": true
      }
    ]
  }
]
```
## Notes
Each medication should include a unique id
The id is used in the frontend for editing and deleting medications

### DELETE /medications/{id}

Used to delete a specific medication by its ID.

Expected:
- Removes the medication from storage
- Response: 200 or 204


## Reminder Times (additional endpoints)
### GET /reminder-times

Used to retrieve the currently stored global reminder times.

Expected response:
```json
{
  "morning": "08:00",
  "noon": "12:00",
  "evening": "17:00",
  "night": "21:00"
}
```

### POST /reminder-times

Used to save/update the global reminder times.

```json
{
  "morning": "08:00",
  "noon": "12:00",
  "evening": "17:00",
  "night": "21:00"
}
```

## Notes
- Reminder times are global (not per medication)
- Time format is always HH:mm (24-hour format)
- Used by the frontend to load and store reminder settings

Settings
GET /settings

Used to load the current profile settings for the frontend settings page.

Expected response:
```json
{
  "username": "Saskia",
  "email": "saskia@example.com"
}
```
### POST /settings

Used to save or update the profile settings.

Example JSON:
```json
{
  "username": "Saskia",
  "email": "saskia@example.com",
  "password": "newpassword123"
}
```
## Notes
- password may be empty if the user only changes username or email
- The frontend does not load an existing password back into the form
- Response: 200 or 201

### Next Intake Logic

No separate endpoint is required at the moment.

The frontend calculates the next intake locally based on:
- all medications from GET /medications
- global reminder times from GET /reminder-times

The frontend then determines:

- the next upcoming day part
- the remaining minutes until intake
- which medications are due at that time
- whether at least one of them has reminder enabled

--------------------------------------
## HOW TO
--------------------------------------

-Start main.py 
-Open Terminal
-type:
python main.py

-Open:
http://127.0.0.1:8000
response: {"message":"Backend läuft"}

## EP-Checkpoint
http://127.0.0.1:8000/docs









uvicorn main:app --reload
