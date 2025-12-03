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

function RegistrosEHora(idEmpresa) {
    var instrucaoSql = `
        SELECT reg.fkSensor, reg.intensidadeLuz, MAX(reg.dtHora) AS dtRegistro
            FROM regSensor AS reg
                JOIN Sensor ON idSensor = fkSensor 
                JOIN ambiente ON idAmbiente = fkAmbiente 
            WHERE ambiente.fkEmpresa = '${idEmpresa}' AND reg.dtHora = (SELECT MAX(reg2.dtHora) FROM regSensor AS reg2 WHERE reg.fkSensor = reg2.fkSensor) 
                GROUP BY reg.intensidadeLuz, reg.fkSensor
                ORDER BY Max(dtHora) DESC;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    puxarQtdAmbientes,
    puxarNomeAmbienteEQtdSensor,
    RegistrosEHora
};