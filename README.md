# Pill Pilot – Frontend (Flutter)

## Überblick

Das Frontend ist eine Flutter-App zur Verwaltung von Medikamenten.
Die App ermöglicht das Erfassen von Medikamenten inklusive Einnahmezeiten und Reminder-Funktion.

Die Architektur ist modular aufgebaut und trennt UI, Logik und API-Kommunikation.

---

## Architektur

Die Anwendung folgt einer klaren Trennung von UI, Logik und Datenzugriff.
- UI (pages, widgets): Darstellung und Benutzerinteraktion
- Models (Provider): Zustand und Geschäftslogik im Frontend
- API (api/): Kommunikation mit dem Backend über HTTP

Daten werden im Frontend verarbeitet (z. B. Next-Intake-Berechnung) und über definierte JSON-Strukturen mit dem Backend ausgetauscht. Die Architektur ist modular aufgebaut und ermöglicht eine einfache Erweiterung sowie eine klare Verantwortlichkeit der einzelnen Komponenten.

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

### ## Technologie-Stack

- Flutter (Frontend)
- Provider (State Management)
- FastAPI (Backend)
- HTTP (REST API) für die Kommunikation zwischen Frontend und Backend

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
7. Beim Start der App wird die AppEntryPage geladen
8. Die AppEntryPage lädt initiale Daten aus dem Backend (z. B. Erinnerungszeiten)
9. Die geladenen Zeiten werden im ReminderTimeModel gespeichert
10. Alle relevanten UI-Komponenten (z. B. IntakeSlotCard) greifen auf das ReminderTimeModel zu
11. Änderungen an Erinnerungszeiten werden über notifyListeners() sofort in der UI aktualisiert
12. In der ReminderTimePage können die vier globalen Erinnerungszeiten bearbeitet werden
13. Beim Speichern werden die Zeiten mit toJson() vorbereitet und über die ReminderTimeApi an das Backend gesendet


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
GET /medications  
DELETE /medications/{id}  

GET /reminder-times  
POST /reminder-times

GET /settings  
POST /settings

### Hinweis zu IDs
- Jedes Medikament wird über eine eindeutige `id` identifiziert
- Die `id` wird vom Backend bereitgestellt
- Sie wird im Frontend für Bearbeiten und Löschen verwendet

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


### Settings (Profileinstellungen)

### Beispiel-JSON
```json
{
  "username": "Saskia",
  "email": "saskia@example.com",
  "password": "newpassword123"
}
```
### Verwendung
GET /settings lädt aktuelle Profildaten
POST /settings speichert Änderungen

### Hinweise
Passwort kann leer sein, wenn nur Benutzername oder E-Mail geändert werden
Das Passwort wird im Frontend nicht wieder geladen
Validierung erfolgt im Frontend (Pflichtfelder, Passwortbestätigung)

---

## Wichtige Komponenten

### AppEntryPage
- zentrale Einstiegskomponente der App
- wird beim Start der App geladen (anstelle der HomePage)
- lädt initiale Daten aus dem Backend (z. B. Erinnerungszeiten)
- speichert diese im entsprechenden Model (z. B. ReminderTimeModel)
- zeigt während des Ladevorgangs einen Ladeindikator
- dient als Vorbereitung für zukünftige Erweiterungen wie Login/Authentifizierung

### HomePage
- Startseite der App
- Einstiegspunkt für die wichtigsten Funktionen
- zeigt die nächste geplante Einnahme basierend auf Medikamenten und Erinnerungszeiten
- berechnet Zeitpunkt, verbleibende Zeit und betroffene Medikamente im Frontend
- zeigt optional den Reminder-Status (aktive Erinnerung vorhanden)
- führt zu MedicationPage, MedicationListPage, Zeiten ändern und Einstellungen
- unterstützt Portrait- und Landscape-Layout

### MedicationListPage
- zeigt vorhandene Medikamente in einer Liste
- lädt Daten aus dem Backend
- verwendet Fake-Daten als Fallback, wenn das Backend nicht erreichbar ist
- dient als Übersicht geladener Medikamente aus dem Backend
- Medikamente können per Tap zur Bearbeitung in die MedicationPage öffnen
- ermöglicht das Löschen von Medikamenten über einen DeleteButton
- unterstützt Portrait- und Landscape-Layout
- enthält einen Floating Action Button (FAB) zum Hinzufügen neuer Medikamente
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
- wird für Add- UND Edit-Flow verwendet

### Validierung
- Ein Medikament kann nur gespeichert werden, wenn:
  - ein Name eingegeben wurde
  - mindestens eine Einnahme vorhanden ist
- Zusätzlich wird geprüft, ob bereits ein Medikament mit dem gleichen Namen existiert
- Der Vergleich erfolgt unabhängig von Groß-/Kleinschreibung und Leerzeichen
- Duplikate werden verhindert (außer im Bearbeitungsmodus)

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
- die definierten Zeiten werden global in der App verwendet (z. B. Anzeige in IntakeSlotCard)

### ReminderTimeModel
- verwaltet die vier globalen Erinnerungszeiten im Frontend
- speichert Zeiten als TimeOfDay pro DayPart
- stellt getTime() und setTime() bereit
- erzeugt mit toJson() das JSON für die Backend-Kommunikation
- kann geladene Backend-Daten mit loadFromJson() übernehmen
- Änderungen an Zeiten werden über notifyListeners() automatisch in allen abhängigen UI-Komponenten aktualisiert

### ReminderTimeApi
- zuständig für HTTP-Requests rund um Erinnerungszeiten
- lädt gespeicherte Zeiten mit GET /reminder-times
- speichert geänderte Zeiten mit POST /reminder-times

### NextIntakeModel & NextIntakeHelper

berechnen die nächste geplante Einnahme basierend auf:
- allen Medikamenten (MedicationListModel)
- globalen Erinnerungszeiten (ReminderTimeModel)

bestimmen:
- nächsten Zeitpunkt
- verbleibende Minuten
- betroffene Medikamente
- ob ein Reminder aktiv ist
- werden von der NextIntakeCard zur Anzeige verwendet
- Logik läuft vollständig im Frontend (kein eigener Backend-Endpoint)

### SettingsPage
- UI-Grundgerüst für die Profileinstellungen
- enthält Felder für Benutzername, E-Mail-Adresse, neues Passwort und Passwortbestätigung
- verwendet bestehende UI-Komponenten wie MyCard, SaveButton und MySnackbar
- unterstützt Portrait- und Landscape-Layout
- verwendet SettingsModel zur Datenstruktur
- verwendet SettingsApi zur Kommunikation mit dem Backend
- enthält Validierungslogik (Pflichtfelder, Passwortbestätigung)
- speichert Daten über POST /settings
- zeigt Feedback über Snackbar bei Erfolg oder Fehler

---

## Navigation

- Die Navigation erfolgt über benannte Routen und Navigator
- Von der HomePage aus kann zur MedicationPage, MedicationListPage, ReminderTimePage und zu weiteren Bereichen navigiert werden
- Nach dem Speichern wird jeweils zur vorherigen Seite bzw. zur Übersicht zurück navigiert

---

## Besonderheiten

- Save-Flow verwendet API + Fallback
- State Management über Provider
- UI und Logik sind bewusst getrennt
- Einheitliches Snackbar-Handling über zentrale MySnackBar-Klasse
- sorgt für konsistentes UI-Feedback bei Aktionen wie Speichern, Fehlern oder Validierung
- SettingsPage wurde zunächst als UI-Scaffold umgesetzt, um Layout und Benutzerfluss vor der Backend-Anbindung festzulegen

---

## Ziel

- klare Trennung von UI, Logik und Backend
- einfache Erweiterbarkeit (z. B. GET /medications für die Liste)
- Vorbereitung auf vollständige Backend-Integration
