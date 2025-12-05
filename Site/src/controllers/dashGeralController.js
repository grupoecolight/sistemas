var dashGeralModel = require("../models/dashGeralModel");

function puxarAmbienteEMedia(req, res) {
    var idEmpresa = req.body.idEmpresaServer;

    if (idEmpresa == undefined) {
        res.status(400).send("Seu idEmpresa está undefined!");
    } else {

        dashGeralModel.puxarAmbienteEMedia(idEmpresa)
            .then(
                function (resultadoAutenticar) {
                    console.log(`\nResultados encontrados: ${resultadoAutenticar.length}`);
                    console.log(`Resultados: ${JSON.stringify(resultadoAutenticar)}`); // transforma JSON em String

                    if (resultadoAutenticar.length >= 1) {
                        console.log(resultadoAutenticar);
                        
                        var arrayAmbiente = []
                        var arrayTagSensores = []
                        var arrayIntensidade = []
                        var arraydtRegistros = []
                        for (var i = 0; i < resultadoAutenticar.length; i++) {
                            arrayAmbiente.push(resultadoAutenticar[i].nome)
                            arrayTagSensores.push(resultadoAutenticar[i].tagSensor)
                            arrayIntensidade.push(resultadoAutenticar[i].intensidadeLuz)
                            arraydtRegistros.push(resultadoAutenticar[i].dtRegistro)
                        }
                        

                        res.json({
                            ambiente: arrayAmbiente,
                            tagSensor: arrayTagSensores,
                            intensidadeLuz: arrayIntensidade,
                            dtRegistros: arraydtRegistros
                        });
                    } else if (resultadoAutenticar.length == 0) {
                        res.status(403).send("Nenhum registro encontrado");
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

module.exports = {
    puxarAmbienteEMedia
}