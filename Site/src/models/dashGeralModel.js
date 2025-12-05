var database = require("../database/config")

function puxarAmbienteEMedia(idEmpresa) {
    var instrucaoSql = `
        SELECT ambiente.nome, Sensor.tagSensor, reg.intensidadeLuz, MAX(reg.dtHora) AS dtRegistro
            FROM regSensor AS reg 
            JOIN Sensor ON idSensor = fkSensor
            JOIN ambiente ON idAmbiente = fkAmbiente
                WHERE ambiente.fkEmpresa = '${idEmpresa}'
                    AND reg.dtHora = (SELECT MAX(reg2.dtHora) 
                        FROM regSensor AS reg2
                            WHERE reg.fkSensor = reg2.fkSensor)
                GROUP BY reg.intensidadeLuz , reg.fkSensor , reg.idRegSensor , fkAmbiente;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    puxarAmbienteEMedia
};