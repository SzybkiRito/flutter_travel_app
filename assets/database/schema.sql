CREATE TABLE IF NOT EXISTS travels (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    user_email VARCHAR(255) NOT NULL,
    destination VARCHAR(255) NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    data JSON
);

