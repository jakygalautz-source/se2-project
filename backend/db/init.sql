DROP TABLE IF EXISTS reminder_times CASCADE;
DROP TABLE IF EXISTS medication_intakes CASCADE;
DROP TABLE IF EXISTS medications CASCADE;
DROP TABLE IF EXISTS users CASCADE;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE medications (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_medications_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE
);

CREATE TABLE medication_intakes (
    id SERIAL PRIMARY KEY,
    medication_id INTEGER NOT NULL,
    day_part VARCHAR(20) NOT NULL,
    amount NUMERIC(5,2) NOT NULL,
    reminder BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_medication_intakes_medication
        FOREIGN KEY (medication_id)
        REFERENCES medications(id)
        ON DELETE CASCADE,

    CONSTRAINT chk_day_part
        CHECK (day_part IN ('morning', 'noon', 'evening', 'night')),

    CONSTRAINT chk_amount
        CHECK (amount > 0)
);

CREATE TABLE reminder_times (
    id SERIAL PRIMARY KEY,
    morning TIME NOT NULL,
    noon TIME NOT NULL,
    evening TIME NOT NULL,
    night TIME NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Insert test data

INSERT INTO users (id, username, email, password_hash)
VALUES (1, 'Saskia', 'saskia@example.com', 'hashed_password')
ON CONFLICT (id) DO NOTHING;

INSERT INTO reminder_times (id, morning, noon, evening, night)
VALUES (1, '08:00', '12:00', '17:00', '21:00')
ON CONFLICT (id) DO NOTHING;

INSERT INTO medications (id, user_id, name)
VALUES (1, 1, 'Ibuprofen')
ON CONFLICT (id) DO NOTHING;

INSERT INTO medication_intakes (id, medication_id, day_part, amount, reminder)
VALUES (1, 1, 'morning', 1.0, TRUE)
ON CONFLICT (id) DO NOTHING;