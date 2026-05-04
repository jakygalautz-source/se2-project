# Routers

This folder contains the API routers of the FastAPI backend.

Each router file groups endpoints for one specific part of the application.  
The routers are registered in `main.py` using `app.include_router(...)`.

## Files

| File | Purpose |
|---|---|
| `medication.py` | Handles medication endpoints |
| `reminder_times.py` | Handles global reminder time endpoints |
| `settings.py` | Handles user settings endpoints |

## medication.py

This router provides endpoints for creating, reading, updating and deleting medications.

### Endpoints

| Method | Endpoint | Description |
|---|---|---|
| GET | `/medications` | Returns all medications |
| POST | `/medications` | Creates a new medication |
| PUT | `/medications/{id}` | Updates a medication |
| DELETE | `/medications/{id}` | Deletes a medication |

Medication data is received from the frontend in JSON format.

Example:

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