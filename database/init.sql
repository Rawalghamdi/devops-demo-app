-- this runs automatically when the postgres container starts for the first time
-- it creates our table and inserts one row

CREATE TABLE IF NOT EXISTS messages (
  id      SERIAL PRIMARY KEY,
  content TEXT NOT NULL
);

-- insert one test message
-- this is what the backend will read and return to the frontend
INSERT INTO messages (content)
VALUES ('Hello from PostgreSQL! This message travelled through the full DevOps stack. Pipeline is fully automated now.')
ON CONFLICT DO NOTHING;
