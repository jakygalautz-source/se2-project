Dokumentation main.py

Die Datei main.py ist der Einstiegspunkt des FastAPI-Backends.
Hier wird die FastAPI-Anwendung erstellt, die Router eingebunden und der Server gestartet.

Aufbau
FastAPI wird importiert, um die Backend-Anwendung zu erstellen.
uvicorn wird importiert, um den Server lokal zu starten.
Die Router aus routers/medication.py und routers/reminder_times.py werden eingebunden.
Der Test-Endpunkt / gibt eine einfache Antwort zurück, um zu prüfen, ob das Backend läuft.
Mit uvicorn.run("main:app", reload=True) wird der Server gestartet.
Aufgabe von main.py

main.py dient nur als zentrale Startdatei.
Die eigentliche Logik für Medikamente und Reminder-Zeiten liegt in den Router-Dateien, damit der Code übersichtlich bleibt.

