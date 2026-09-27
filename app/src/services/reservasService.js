const reservasRepository = require('../repositories/reservasRepository');

const criarReserva = async (dados) => {
  const { nome_cliente, data_reserva, numero_pessoas } = dados;

  if (!nome_cliente || !data_reserva || !numero_pessoas) {
    throw new Error('Os campos nome_cliente, data_reserva e numero_pessoas são obrigatórios.');
  }

  return reservasRepository.criarReserva(dados);
};

const listarReservas = async () => {
  return reservasRepository.listarReservas();
};

const buscarReservaPorId = async (id) => {
  return reservasRepository.buscarReservaPorId(id);
};

const atualizarReserva = async (id, dados) => {
  const { nome_cliente, data_reserva, numero_pessoas } = dados;

  if (!nome_cliente || !data_reserva || !numero_pessoas) {
    throw new Error('Os campos nome_cliente, data_reserva e numero_pessoas são obrigatórios.');
  }

  return reservasRepository.atualizarReserva(id, dados);
};

const excluirReserva = async (id) => {
  return reservasRepository.excluirReserva(id);
};

module.exports = {
  criarReserva,
  listarReservas,
  buscarReservaPorId,
  atualizarReserva,
  excluirReserva,
};
