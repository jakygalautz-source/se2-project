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

### POST /reminder-times

Used to save/update the global reminder times.

Example JSON
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