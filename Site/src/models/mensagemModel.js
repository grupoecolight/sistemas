var database = require('../database/config')

function cadastrarMsg(nomeEmpresa, email, nomeRepresentante, tellContato, mensagem) {
    var instrucaoSql = `
        INSERT INTO mensagem (nomeEmpresa, emailEmpresa, nomeRepresentante, contatoTel, mensagem) VALUES
        ('${nomeEmpresa}', '${email}', '${nomeRepresentante}', '${tellContato}', '${mensagem}');
    `

    console.log('Execultando a instrução SQL: \n' + instrucaoSql)
    return database.executar(instrucaoSql)
}

module.exports = {
    cadastrarMsg
}