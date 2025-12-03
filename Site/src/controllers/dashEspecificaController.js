var dashEspecificaModel = require("../models/dashEspecificaModel");

function puxarQtdAmbientes(req, res) {
    var idEmpresa = req.body.idEmpresaServer;

    if (idEmpresa == undefined) {
        res.status(400).send("Seu idEmpresa está undefined!");
    } else {

        dashEspecificaModel.puxarQtdAmbientes(idEmpresa)
            .then(
                function (resultadoAutenticar) {
                    console.log(`\nResultados encontrados: ${resultadoAutenticar.length}`);
                    console.log(`Resultados: ${JSON.stringify(resultadoAutenticar)}`); // transforma JSON em String

                    if (resultadoAutenticar.length == 1) {
                        console.log(resultadoAutenticar);

                        res.json({
                            quantidadeAmbientes: resultadoAutenticar[0].quantidadeAmbientes
                        });
                    } else if (resultadoAutenticar.length == 0) {
                        res.status(403).send("Dados não encontrados");
                    } else {
                        res.status(403).send("Mais de um dado encontrado!");
                    }
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }

}

function puxarNomeAmbienteEQtdSensor(req, res) {
    var idEmpresa = req.body.idEmpresaServer;

    if (idEmpresa == undefined) {
        res.status(400).send("Seu idEmpresa está undefined!");
    } else {

        dashEspecificaModel.puxarNomeAmbienteEQtdSensor(idEmpresa)
            .then(
                function (resultadoAutenticar) {
                    console.log(`\nResultados encontrados: ${resultadoAutenticar.length}`);
                    console.log(`Resultados: ${JSON.stringify(resultadoAutenticar)}`); // transforma JSON em String

                    if (resultadoAutenticar.length >= 1) {
                        console.log(resultadoAutenticar);

                        var arrayNome = []
                        var arrayQtdSensores = []
                        for (var i = 0; i < resultadoAutenticar.length; i++) {
                            arrayNome.push(resultadoAutenticar[i].nome)
                            arrayQtdSensores.push(resultadoAutenticar[i].quantidadeSensores)
                        }
                        

                        res.json({
                            nome: arrayNome,
                            quantidadeSensores: arrayQtdSensores
                        });
                    } else if (resultadoAutenticar.length == 0) {
                        res.status(403).send("Nenhum ambiente encontrado!");
                    } else {
                        res.status(403).send("Erro impossible");
                    }
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }

}

function RegistrosEHora(req, res) {
    var idEmpresa = req.body.idEmpresaServer;

    if (idEmpresa == undefined) {
        res.status(400).send("Seu idEmpresa está undefined!");
    } else {

        dashEspecificaModel.RegistrosEHora(idEmpresa)
            .then(
                function (resultadoAutenticar) {
                    console.log(`\nResultados encontrados: ${resultadoAutenticar.length}`);
                    console.log(`Resultados: ${JSON.stringify(resultadoAutenticar)}`); // transforma JSON em String

                    if (resultadoAutenticar.length >= 1) {
                        console.log(resultadoAutenticar);

                        var arrayNome = []
                        var arrayQtdSensores = []
                        for (var i = 0; i < resultadoAutenticar.length; i++) {
                            arrayNome.push(resultadoAutenticar[i].nome)
                            arrayQtdSensores.push(resultadoAutenticar[i].quantidadeSensores)
                        }
                        

                        res.json({
                            nome: arrayNome,
                            quantidadeSensores: arrayQtdSensores
                        });
                    } else if (resultadoAutenticar.length == 0) {
                        res.status(403).send("Nenhum ambiente encontrado!");
                    } else {
                        res.status(403).send("Erro impossible");
                    }
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }

}


module.exports = {
    puxarQtdAmbientes,
    puxarNomeAmbienteEQtdSensor,
    RegistrosEHora
}