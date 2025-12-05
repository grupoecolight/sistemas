var express = require("express");
var router = express.Router();

var dashGeralController = require("../controllers/dashGeralController");

//Recebendo os dados do html e direcionando para a função cadastrar de dashGeralController.js
router.post("/puxarAmbienteEMedia", function (req, res) {
    dashGeralController.puxarAmbienteEMedia(req, res);
});

module.exports = router;