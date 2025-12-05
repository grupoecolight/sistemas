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

async function ultimosDezRegistros(idEmpresa) {
    console.log('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa')

    var instrucaoSql = `
        SELECT dtHora FROM regSensor
            JOIN Sensor ON idSensor = fkSensor 
            JOIN ambiente ON idAmbiente = fkAmbiente 
                WHERE fkEmpresa = '${idEmpresa}' ORDER BY dtHora DESC LIMIT 1;
    `
    
    var result = await database.executar(instrucaoSql)
    
    console.log(result)
    
    var resultDate = new Date(result[0].dtHora)
    var antesHorasDate = new Date(resultDate)
    antesHorasDate.setHours(resultDate.getHours() - 1)
    antesHorasDate.setMinutes(resultDate.getMinutes() - 40)

    console.log(resultDate)
    console.log(antesHorasDate)

    var formatedResultDate = functionFormatarData(resultDate)
    var formatedAntesHorasDate = functionFormatarData(antesHorasDate)
    

    var instrucaoSql = `
        SELECT ambiente.nome as ambiente, tagSensor, intensidadeLuz, dtHora 
            FROM regSensor
            JOIN Sensor ON idSensor = fkSensor 
            JOIN ambiente ON idAmbiente = fkAmbiente 
                WHERE dtHora > '${formatedAntesHorasDate}' AND dtHora <= '${formatedResultDate}' AND fkEmpresa = '${idEmpresa}'; 
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function functionFormatarData(date) {
    var ano = date.getFullYear()
    var mes = String(date.getMonth() + 1).padStart(2, '0')
    var dia = String(date.getDate()).padStart(2, '0')

    var hora = String(date.getHours()).padStart(2, '0')
    var min = String(date.getMinutes()).padStart(2, '0')
    var seg = String(date.getSeconds()).padStart(2, '0')

    return `${ano}-${mes}-${dia} ${hora}:${min}:${seg}`
}

module.exports = {
    puxarQtdAmbientes,
    puxarNomeAmbienteEQtdSensor,
    RegistrosEHora,
    ultimosDezRegistros
};