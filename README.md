# Pill Pilot – Frontend (Flutter)

## Überblick

Das Frontend ist eine Flutter-App zur Verwaltung von Medikamenten.
Die App ermöglicht das Erfassen von Medikamenten inklusive Einnahmezeiten und Reminder-Funktion.

Die Architektur ist modular aufgebaut und trennt UI, Logik und API-Kommunikation.

---

## Projektstruktur

lib/
├── api/       → Kommunikation mit Backend (HTTP)
├── models/    → Datenmodelle und State (Provider)
├── pages/     → Screens (z. B. MedicationPage)
├── widgets/   → Wiederverwendbare UI-Komponenten

backend/
└── FastAPI-Backend (separat im Repo)

---

## Datenfluss

1. User gibt Daten in der MedicationPage ein
2. Daten werden im MedicationFormModel gesammelt
3. Beim Speichern:
   - toJson() erzeugt JSON
   - MedicationApi.saveMedication() sendet Daten an das Backend

Fallback:
Wenn das Backend nicht erreichbar ist, wird stattdessen ein kurzer Fake-Delay verwendet.

---

## API-Kommunikation

### Endpoint
POST /medications

### Beispiel-JSON

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

### Base URL (Development)
http://10.0.2.2:8000

Hinweis:
10.0.2.2 wird im Android Emulator verwendet und verweist auf den lokalen Rechner.

---

## Wichtige Komponenten

### HomePage
- Startseite der App
- Einstiegspunkt für die wichtigsten Funktionen
- zeigt nächste Einnahme und Navigationskarten
- führt zu MedicationPage, MedicationListPage, Zeiten ändern und Einstellungen
- unterstützt Portrait- und Landscape-Layout

### MedicationListPage
- zeigt vorhandene Medikamente in einer Liste
- verwendet aktuell noch Fake-Daten
- dient später als Übersicht geladener Medikamente aus dem Backend
- Medikamente sollen per Tap zur Bearbeitung in die MedicationPage öffnen
- TODO Landscape-Layout

### MedicationPage
- UI für die Eingabe und Bearbeitung von Medikamente
- wird für neue und bestehende Medikamente verwendet
- enthält Save-Logik
- zeigt Feedback über Snackbar
- unterstützt Portrait- und Landscape-Layout

### MedicationFormModel
- hält den bearbeitbaren Formularzustand
- speichert Eingaben temporär im Frontend
- validiert Daten
- erstellt JSON mit toJson() für Backend-Kommunikation
- TODO kann später für Add- UND Edit-Flow verwendet werden

### MedicationApi
- zuständig für HTTP-Requests
- sendet Daten an das Backend

---

## Besonderheiten

- Save-Flow verwendet API + Fallback
- State Management über Provider
- UI und Logik sind bewusst getrennt

---

## Ziel

- klare Trennung von UI, Logik und Backend
- einfache Erweiterbarkeit (z. B. GET /medications für die Liste)
- Vorbereitung auf vollständige Backend-Integration
