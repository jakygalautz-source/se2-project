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
4. In der MedicationListPage werden Medikamente über das MedicationListModel geladen
5. Das MedicationListModel verwendet MedicationApi.getMedications()
6. Falls das Backend nicht erreichbar ist, werden Fake-Daten geladen
7. Beim Öffnen der ReminderTimePage werden bestehende Erinnerungszeiten zuerst über die ReminderTimeApi aus dem Backend geladen
8. Die geladenen Zeiten werden im ReminderTimeModel gespeichert
9. In der ReminderTimePage können die vier globalen Erinnerungszeiten bearbeitet werden
10. Beim Speichern werden die Zeiten mit toJson() vorbereitet und über die ReminderTimeApi an das Backend gesendet


---

## API-Kommunikation

### Endpoint
POST /medications

### Beispiel-JSON

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

### Weitere Endpoints
GET /reminder-times  
POST /reminder-times

### Beispiel-JSON für Erinnerungszeiten

```json
{
  "morning": "08:00",
  "noon": "12:00",
  "evening": "17:00",
  "night": "21:00"
}
```
### Verwendung
GET /reminder-times lädt die aktuell gespeicherten globalen Erinnerungszeiten
POST /reminder-times speichert geänderte Erinnerungszeiten

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
- Medikamente können per Tap zur Bearbeitung in die MedicationPage öffnen
- unterstützt Portrait- und Landscape-Layout
- verwendet im Landscape-Modus eine zeilenbasierte Darstellung mit zwei Karten nebeneinander

### MedicationPage
- UI für die Eingabe und Bearbeitung von Medikamente
- wird für neue und bestehende Medikamente verwendet
- enthält Save-Logik
- lädt nach dem Speichern die Medikamentenliste neu und navigiert zurück zur Übersicht
- unterstützt Portrait- und Landscape-Layout

### MedicationFormModel
- hält den bearbeitbaren Formularzustand
- speichert Eingaben temporär im Frontend
- validiert Daten
- erstellt JSON mit toJson() für Backend-Kommunikation
- wird für Add- UND Edit-Flow verwendet werden

### MedicationListModel
- verwaltet den Zustand der Medikamentenliste
- lädt Medikamente über API
- verwendet Fake-Daten als Fallback, wenn das Backend noch nicht erreichbar ist

### MedicationApi
- zuständig für HTTP-Requests
- sendet Daten an das Backend
- lädt Medikamentendaten aus dem Backend

### ReminderTimePage
- UI für die Bearbeitung der vier globalen Erinnerungszeiten
- zeigt Morgens, Mittags, Abends und Nachts als bearbeitbare Zeit-Slots
- verwendet einen TimePicker zur Auswahl der Uhrzeit
- speichert Änderungen über SaveButton
- unterstützt Portrait- und Landscape-Layout

### ReminderTimeModel
- verwaltet die vier globalen Erinnerungszeiten im Frontend
- speichert Zeiten als TimeOfDay pro DayPart
- stellt getTime() und setTime() bereit
- erzeugt mit toJson() das JSON für die Backend-Kommunikation
- kann geladene Backend-Daten mit loadFromJson() übernehmen

### ReminderTimeApi
- zuständig für HTTP-Requests rund um Erinnerungszeiten
- lädt gespeicherte Zeiten mit GET /reminder-times
- speichert geänderte Zeiten mit POST /reminder-times

---

## Navigation

- Die Navigation erfolgt über benannte Routen und direkte Navigation per Navigator
- Von der HomePage aus kann zur MedicationPage, MedicationListPage, ReminderTimePage und zu weiteren Bereichen navigiert werden
- Beim Öffnen der ReminderTimePage werden die gespeicherten Zeiten zuerst aus dem Backend geladen und danach die Seite geöffnet
- Beim Speichern in der ReminderTimePage wird zur vorherigen Seite zurück navigiert
- Beim Speichern in der MedicationPage wird die Medikamentenliste aktualisiert und danach zurück zur MedicationListPage navigiert

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
