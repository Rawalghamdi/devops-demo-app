// simple express server with one endpoint
// connects to postgres and reads a message from the database

const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');

const app = express();
const PORT = process.env.PORT || 3000;

// allow requests from the frontend
// in a real app you'd restrict this to specific origins
app.use(cors());
app.use(express.json());

// postgres connection — uses environment variables so we don't hardcode credentials
const pool = new Pool({
  host:     process.env.DB_HOST     || 'localhost',
  port:     parseInt(process.env.DB_PORT || '5432'),
  database: process.env.DB_NAME     || 'demodb',
  user:     process.env.DB_USER     || 'demouser',
  password: process.env.DB_PASSWORD || 'demopassword',
});

// health check — useful for kubernetes liveness probes
app.get('/health', (req, res) => {
  res.json({ status: 'ok' });
});

// main endpoint — reads message from the database
app.get('/api/message', async (req, res) => {
  try {
    const result = await pool.query('SELECT content FROM messages LIMIT 1');

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'No message found in database' });
    }

    res.json({ message: result.rows[0].content });

  } catch (err) {
    console.error('Database error:', err.message);
    res.status(500).json({ error: 'Could not connect to database' });
  }
});

app.listen(PORT, () => {
  console.log(`Backend running on port ${PORT}`);
});
