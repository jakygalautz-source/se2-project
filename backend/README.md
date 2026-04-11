FastAPI backend for Pill Pilot

Frontend sends JSON in this format:

POST /medications

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

Expected:
- Endpoint to receive and store medication data
- Later: GET /medications to return list