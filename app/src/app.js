const express = require('express');

const reservasRoutes = require('./routes/reservasRoutes');

const app = express();

app.use(express.json());

app.get('/health', (req, res) => {
  res.status(200).json({ status: 'ok' });
});

app.use('/api', reservasRoutes);

module.exports = app;
