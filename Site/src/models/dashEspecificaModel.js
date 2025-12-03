var database = require("../database/config")

function puxarQtdAmbientes(idEmpresa) {
    var instrucaoSql = `
        SELECT COUNT(fkEmpresa) AS quantidadeAmbientes FROM ambiente WHERE fkEmpresa = '${idEmpresa}';
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function puxarNomeAmbienteEQtdSensor(idEmpresa) {
    var instrucaoSql = `
        SELECT nome, COUNT(fkAmbiente) AS quantidadeSensores FROM ambiente LEFT JOIN Sensor ON fkAmbiente = idAmbiente WHERE fkEmpresa = '${idEmpresa}' GROUP BY nome;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    puxarQtdAmbientes,
    puxarNomeAmbienteEQtdSensor
};