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
