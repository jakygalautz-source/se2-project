README_FOR_MAIN.md

Dokumentation main.py

Die Datei main.py ist der Einstiegspunkt des FastAPI-Backends.
In dieser Datei wird die FastAPI-Anwendung erstellt, die einzelnen Router werden eingebunden und der lokale Entwicklungsserver kann gestartet werden.

Aufbau der Datei

Zuerst werden FastAPI und uvicorn importiert. FastAPI wird verwendet, um die Backend-Anwendung zu erstellen. Uvicorn dient dazu, den Server lokal zu starten.

Danach werden die Router aus den einzelnen Dateien eingebunden:
- routers/medication.py für die Medication-Endpoints
- routers/reminder_times.py für die Reminder-Times-Endpoints
- routers/settings.py für die Settings-Endpoints

Mit app = FastAPI() wird die FastAPI-Anwendung erstellt.

Anschließend werden die Router mit app.include_router(...) registriert. Dadurch sind die Endpoints aus den Router-Dateien in der Anwendung verfügbar.

Endpoints in main.py

Der Endpoint GET / gibt eine einfache Testantwort zurück. Damit kann überprüft werden, ob das Backend grundsätzlich läuft.

Der Endpoint GET /db-test prüft die Verbindung zur PostgreSQL-Datenbank. Dafür wird ein einfacher SQL-Befehl SELECT 1 ausgeführt. Wenn die Verbindung funktioniert, gibt der Endpoint {"database_connection": 1} zurück.

Aufgabe von main.py

main.py dient als zentrale Startdatei des Backends. Die eigentliche Logik der Anwendung befindet sich nicht direkt in main.py, sondern in den Router-Dateien. Dadurch bleibt der Code übersichtlich und besser wartbar.

Server starten

Das Backend kann mit folgendem Befehl gestartet werden:

uvicorn main:app --reload

Danach ist die Anwendung unter http://127.0.0.1:8000 erreichbar.

Die automatische API-Dokumentation kann unter http://127.0.0.1:8000/docs geöffnet werden.