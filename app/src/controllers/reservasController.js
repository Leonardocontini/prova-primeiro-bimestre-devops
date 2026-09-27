const reservasService = require('../services/reservasService');

const criarReserva = async (req, res) => {
  try {
    const reserva = await reservasService.criarReserva(req.body);

    return res.status(201).json(reserva);
  } catch (error) {
    return res.status(400).json({
      erro: error.message
    });
  }
};

const listarReservas = async (req, res) => {
  try {
    const reservas = await reservasService.listarReservas();

    return res.status(200).json(reservas);
  } catch (error) {
    return res.status(500).json({
      erro: error.message
    });
  }
};

const buscarReservaPorId = async (req, res) => {
  try {
    const reserva = await reservasService.buscarReservaPorId(req.params.id);

    if (!reserva) {
      return res.status(404).json({
        erro: 'Reserva não encontrada'
      });
    }

    return res.status(200).json(reserva);
  } catch (error) {
    return res.status(500).json({
      erro: error.message
    });
  }
};

const atualizarReserva = async (req, res) => {
  try {
    const reserva = await reservasService.atualizarReserva(
      req.params.id,
      req.body
    );

    if (!reserva) {
      return res.status(404).json({
        erro: 'Reserva não encontrada'
      });
    }

    return res.status(200).json(reserva);
  } catch (error) {
    return res.status(400).json({
      erro: error.message
    });
  }
};

const excluirReserva = async (req, res) => {
  try {
    const reserva = await reservasService.excluirReserva(req.params.id);

    if (!reserva) {
      return res.status(404).json({
        erro: 'Reserva não encontrada'
      });
    }

    return res.status(204).send();
  } catch (error) {
    return res.status(500).json({
      erro: error.message
    });
  }
};

module.exports = {
  criarReserva,
  listarReservas,
  buscarReservaPorId,
  atualizarReserva,
  excluirReserva
};