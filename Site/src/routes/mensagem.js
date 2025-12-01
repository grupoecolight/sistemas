var express = require("express");
var router = express.Router();

var mensagemController = require('../controllers/mensagemController')

router.post('/cadastrarMsg', function (req, res) {
    mensagemController.cadastrarMsg(req, res)
})

module.exports = router