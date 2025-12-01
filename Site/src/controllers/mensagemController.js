var mensagemModel = require('../models/mensagemModel')

function cadastrarMsg(req, res) {
    var nomeEmpresa = req.body.nomeEmpresaServer
    var email = req.body.emailServer
    var nomeRepresentante = req.body.nomeRepresentanteServer
    var tellContato = req.body.tellContatoServer
    var mensagem = req.body.mensagemServer

    if (nomeEmpresa == undefined) {
        res.status(400).send("O nome da Empresa está undefined!");
    } else if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (nomeRepresentante == undefined) {
        res.status(400).send("O nome do Representante está undefined!");
    } else if (tellContato == undefined) {
        res.status(400).send("O telefone está undefined!");
    } else if (mensagem == undefined) {
        res.status(400).send("A mensagem está undefined!");
    } else {

        mensagemModel.cadastrarMsg(nomeEmpresa, email, nomeRepresentante, tellContato, mensagem)
            .then(
                function (resultado) {
                    res.json(resultado)
                }
            ).catch (
                function (erro) {
                    console.log(erro)
                    console.log('\nHouve um erro ao realizar o cadastro! Erro: ', erro.sqlMessage)
                    res.status(500).json(erro.sqlMessage)
                }
            )
    }
}

module.exports = {
    cadastrarMsg
}