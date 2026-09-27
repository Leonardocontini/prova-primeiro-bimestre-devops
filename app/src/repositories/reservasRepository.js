const pool = require('../config/db');

const criarReserva = async (dados) => {
  const { nome_cliente, data_reserva, numero_pessoas, observacoes } = dados;

  const result = await pool.query(
    `INSERT INTO reservas (nome_cliente, data_reserva, numero_pessoas, observacoes)
     VALUES ($1, $2, $3, $4)
     RETURNING *`,
    [nome_cliente, data_reserva, numero_pessoas, observacoes]
  );

  return result.rows[0];
};

const listarReservas = async () => {
  const result = await pool.query(
    'SELECT * FROM reservas ORDER BY data_reserva ASC'
  );

  return result.rows;
};

const buscarReservaPorId = async (id) => {
  const result = await pool.query(
    'SELECT * FROM reservas WHERE id = $1',
    [id]
  );

  return result.rows[0] || null;
};

const atualizarReserva = async (id, dados) => {
  const { nome_cliente, data_reserva, numero_pessoas, observacoes } = dados;

  const result = await pool.query(
    `UPDATE reservas
     SET nome_cliente = $1, data_reserva = $2, numero_pessoas = $3, observacoes = $4
     WHERE id = $5
     RETURNING *`,
    [nome_cliente, data_reserva, numero_pessoas, observacoes, id]
  );

  return result.rows[0] || null;
};

const excluirReserva = async (id) => {
  const result = await pool.query(
    'DELETE FROM reservas WHERE id = $1 RETURNING *',
    [id]
  );

  return result.rows[0] || null;
};

module.exports = {
  criarReserva,
  listarReservas,
  buscarReservaPorId,
  atualizarReserva,
  excluirReserva,
};
