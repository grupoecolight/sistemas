var express = require("express");
var router = express.Router();

var dashEspecificaController = require("../controllers/dashEspecificaController");

//Recebendo os dados do html e direcionando para a função cadastrar de dashEspecificaController.js
router.post("/puxarQtdAmbientes", function (req, res) {
    dashEspecificaController.puxarQtdAmbientes(req, res);
});

router.post("/puxarNomeAmbienteEQtdSensor", function (req, res) {
    dashEspecificaController.puxarNomeAmbienteEQtdSensor(req, res);
});

router.post("/RegistrosEHora", function (req, res) {
    dashEspecificaController.RegistrosEHora(req, res);
});

router.post("/ultimosDezRegistros", function (req, res) {
    dashEspecificaController.ultimosDezRegistros(req, res);
});

module.exports = router;