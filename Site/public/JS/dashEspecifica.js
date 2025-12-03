functionPuxarQtdAmbientes()
functionPuxarNomeAmbienteEQtdSensor()

function functionPuxarQtdAmbientes() {
    // pegar a Empresa do sessionStorage
    var idEmpresaVar = 1

    if (idEmpresaVar == '') {
        alert('Seu idEmpresa está vazio.')
    }

    fetch('/dashEspecifica/puxarQtdAmbientes', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            idEmpresaServer: idEmpresaVar
        })
    })
        .then(function (resposta) {
            if(resposta.ok) {
                resposta.json().then(json => {
                    sessionStorage.QTDAMBIENTES_EMPRESA = json.quantidadeAmbientes
                })
            } else {
                alert('Deu erro (resposta não veio ok) - Qtd ambientes.')
            }
        }).catch(function (erro) {
            console.log(erro)
        })
    return false
}

function functionPuxarNomeAmbienteEQtdSensor() {
    // pegar a Empresa do sessionStorage
    var idEmpresaVar = 1

    if (idEmpresaVar == '') {
        alert('Seu idEmpresa está vazio.')
    }

    fetch('/dashEspecifica/puxarNomeAmbienteEQtdSensor', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            idEmpresaServer: idEmpresaVar
        })
    })
        .then(function (resposta) {
            if (resposta.ok) {
                resposta.json().then(json => {
                    sessionStorage.NOMEAMBIENTES_EMPRESA = json.nome
                    sessionStorage.QTDSENSORES_EMPRESA = json.quantidadeSensores
                })
            } else {
                alert('Deu erro (resposta não veio ok) - Nome ambiente e qtd Sensores.')
            }
        }).catch(function (erro) {
            console.log(erro)
        })
    return false
}

function functionRegistrosEHora() {
    // pegar a Empresa do sessionStorage
    var idEmpresaVar = 1

    if (idEmpresaVar == '') {
        alert('Seu idEmpresa está vazio.')
    }

    fetch('/dashEspecifica/RegistrosEHora', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            idEmpresaServer: idEmpresaVar
        })
    })
        .then(function (resposta) {
            if (resposta.ok) {
                resposta.json().then(json => {
                    // sessionStorage.NOMEAMBIENTES_EMPRESA = json.nome
                    // sessionStorage.QTDSENSORES_EMPRESA = json.quantidadeSensores
                })
            } else {
                alert('Deu erro (resposta não veio ok) - Registro e hora do Sensor.')
            }
        }).catch(function (erro) {
            console.log(erro)
        })
    return false
}