const express = require('express');

const reservasController = require('../controllers/reservasController');

const router = express.Router();

router.post('/reservas', reservasController.criarReserva);

router.get('/reservas', reservasController.listarReservas);

router.get('/reservas/:id', reservasController.buscarReservaPorId);

router.put('/reservas/:id', reservasController.atualizarReserva);

router.delete('/reservas/:id', reservasController.excluirReserva);

module.exports = router;