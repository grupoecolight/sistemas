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
        SELECT a.nome, COUNT(DISTINCT r.fkSensor) AS quantidadeSensores FROM ambiente a LEFT JOIN regSensor r ON a.idAmbiente = r.fkAmbiente WHERE a.fkEmpresa = '${idEmpresa}' GROUP BY a.nome;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function RegistrosEHora(idEmpresa) {
    var instrucaoSql = `
        SELECT reg.idRegSensor, reg.fkAmbiente, reg.fkSensor, ambiente.nome, Sensor.tagSensor, reg.intensidadeLuz, MAX(reg.dtHora) AS dtRegistro 
            FROM regSensor AS reg
            JOIN Sensor ON idSensor = fkSensor 
            JOIN ambiente ON idAmbiente = fkAmbiente 
                WHERE ambiente.fkEmpresa = '${idEmpresa}' AND reg.dtHora = (SELECT MAX(reg2.dtHora) FROM regSensor AS reg2 WHERE reg.fkSensor = reg2.fkSensor) 
                    GROUP BY reg.intensidadeLuz, reg.fkSensor, reg.idRegSensor, fkAmbiente;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function RegistrosEHora(idEmpresa) {
    var instrucaoSql = `
        SELECT fkSensor, intensidadeLuz, dtHora 
            FROM regSensor
            JOIN Sensor ON idSensor = fkSensor 
            JOIN ambiente ON idAmbiente = fkAmbiente 
                WHERE dtHora < '2025-12-03 23:20:00' AND dtHora > '2025-12-03 18:20:00' AND fkEmpresa = '${idEmpresa}';
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    puxarQtdAmbientes,
    puxarNomeAmbienteEQtdSensor,
    RegistrosEHora
};