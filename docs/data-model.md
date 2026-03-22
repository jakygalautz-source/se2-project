# Data Model

## Overview

The system is based on four main entities: User, Medication, IntakeSchedule, and IntakeHistory.

A user can manage multiple medications.  
Each medication can have multiple planned intake times.  
Confirmed intakes are stored in a history.

---

## Tables

### User

| Attribute       | Type      | Description              |
|----------------|----------|--------------------------|
| id             | Integer  | Primary key              |
| email          | String   | User email               |
| password_hash  | String   | Hashed password          |
| created_at     | DateTime | Creation timestamp       |

---

### Medication

| Attribute       | Type      | Description                     |
|----------------|----------|---------------------------------|
| id             | Integer  | Primary key                     |
| user_id        | Integer  | Foreign key to User             |
| name           | String   | Medication name                 |
| dosage         | String   | Dosage information              |
| notes          | String   | Optional notes                  |
| is_active      | Boolean  | Active/inactive flag            |
| created_at     | DateTime | Creation timestamp              |

---

### IntakeSchedule

| Attribute       | Type      | Description                     |
|----------------|----------|---------------------------------|
| id             | Integer  | Primary key                     |
| medication_id  | Integer  | Foreign key to Medication       |
| time_of_day    | Time     | Planned intake time             |
| frequency_type | String   | e.g. daily                      |

---

### IntakeHistory

| Attribute        | Type      | Description                     |
|-----------------|----------|---------------------------------|
| id              | Integer  | Primary key                     |
| medication_id   | Integer  | Foreign key to Medication       |
| scheduled_time  | DateTime | Planned intake time             |
| taken_at        | DateTime | Actual intake time              |
| status          | String   | taken / skipped                 |

---

## Relationships

- One User has many Medications  
- One Medication has many IntakeSchedules  
- One Medication has many IntakeHistory entries  

---

## Notes

This data model represents an initial version and can be extended and refined during future sprints.
