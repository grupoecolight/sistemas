var listaGeralAmbientes = []

// arrays
var arrayNomeAmbientes_empresa = []
var qtdAmbientes_empresa = 0
var arrayQtdSensores_empresa = []
var arrayNome_ultimoReg = []
var arrayQtdSensores_ultimoReg = []
var arrayIntensidade_ultimoReg = []
var arrayDtRegistro_ultimoReg = []

functionPuxarAsFunctionsIniciais()

function functionPuxarAsFunctionsIniciais() {
    functionPuxarQtdAmbientes()
    functionPuxarNomeAmbienteEQtdSensor()
    functionRegistrosEHora()
    console.log('testando')
    arrayNomeAmbientes_empresa = functionTransformarSessionEmArray(sessionStorage.NOMEAMBIENTES_EMPRESA)
    console.log(arrayNomeAmbientes_empresa)
    qtdAmbientes_empresa = sessionStorage.QTDAMBIENTES_EMPRESA
    console.log(qtdAmbientes_empresa)
    arrayQtdSensores_empresa = functionTransformarSessionEmArray(sessionStorage.QTDSENSORES_EMPRESA)
    console.log(arrayQtdSensores_empresa)
    arrayNome_ultimoReg = functionTransformarSessionEmArray(sessionStorage.NOME_ULTIMOREG)
    console.log(arrayNome_ultimoReg)
    arrayQtdSensores_ultimoReg = functionTransformarSessionEmArray(sessionStorage.QTDSENSORES_ULTIMOREG)
    console.log(arrayQtdSensores_ultimoReg)
    arrayIntensidade_ultimoReg = functionTransformarSessionEmArray(sessionStorage.INTENSIDADE_ULTIMOREG)
    console.log(arrayIntensidade_ultimoReg)
    arrayDtRegistro_ultimoReg = functionTransformarSessionEmArray(sessionStorage.DTREGISTROS_ULTIMOREG)
    console.log(arrayDtRegistro_ultimoReg)

    functionOrganizarTudo()

    functionMatrizParaTelaAmbientes()
}

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
                    sessionStorage.NOME_ULTIMOREG = json.nome
                    sessionStorage.QTDSENSORES_ULTIMOREG = json.quantidadeSensores
                    sessionStorage.INTENSIDADE_ULTIMOREG = json.intensidade
                    sessionStorage.DTREGISTROS_ULTIMOREG = json.dtRegistros
                })
            } else {
                alert('Deu erro (resposta não veio ok) - Registro e hora do Sensor.')
            }
        }).catch(function (erro) {
            console.log(erro)
        })
    return false
}

function functionTransformarSessionEmArray(stringSessionStorage) {
    var newArray = []
    var auxiliar = ''
    for (var i = 0; i <= stringSessionStorage.length; i++) {
        if (i == stringSessionStorage.length) {
            newArray.push(auxiliar)
        } else if (stringSessionStorage[i] != ',') {
            auxiliar += stringSessionStorage[i]
        } else {
            newArray.push(auxiliar)
            auxiliar = ''
        }
    }

    return newArray
}

function functionOrganizarTudo() {
    var ambienteExiste = false
    for (var i = 0; i < arrayNomeAmbientes_empresa.length; i++) {
        ambienteExiste = false
        // for para verificar se o ambiente já existe
        for (var j = 0; j < listaGeralAmbientes.length; j++) {
            if (listaGeralAmbientes[j][0] == arrayNomeAmbientes_empresa[i]) {
                ambienteExiste = true
            }
        }
        // caso não exista, adiciona um novo array com o ambiente
        if (!ambienteExiste) {
            listaGeralAmbientes.push([arrayNomeAmbientes_empresa[i], [], [], [], []])
        }
        
        // verificar e adicionar os indices do mesmo ambiente
        for (var j = 0; j < arrayNome_ultimoReg.length; j++) {
            if (listaGeralAmbientes[i][0] == arrayNome_ultimoReg[j]) {
                listaGeralAmbientes[i][1].push(j)
            }
        }
        
        // adicionar as tags na Matriz
        for (var j = 0; j < arrayQtdSensores_ultimoReg.length; j++) {
            if (listaGeralAmbientes[i][0] == arrayNome_ultimoReg[j]) {
                listaGeralAmbientes[i][2].push(arrayQtdSensores_ultimoReg[j])
            }
        }
        
        // adicionar as Intensidades na Matriz
        for (var j = 0; j < arrayIntensidade_ultimoReg.length; j++) {
            if (listaGeralAmbientes[i][0] == arrayNome_ultimoReg[j]) {
                listaGeralAmbientes[i][3].push(arrayIntensidade_ultimoReg[j])
            }
        }
        
        // adicionar os horários na Matriz
        for (var j = 0; j < arrayDtRegistro_ultimoReg.length; j++) {
            if (listaGeralAmbientes[i][0] == arrayNome_ultimoReg[j]) {
                listaGeralAmbientes[i][4].push(arrayDtRegistro_ultimoReg[j])
            }
        }
        
        // adicionar a média de cada ambiente
        var media = 0
        var soma = 0
        var quant = 0
        for (var j = 0; j < listaGeralAmbientes[i][3].length; j++) {
            soma += Number(listaGeralAmbientes[i][3][j])
            quant ++
        }
        media = (soma / quant).toFixed(0)
        listaGeralAmbientes[i][5] = media
    }
    console.log(listaGeralAmbientes)
}

// como está ficando a Matriz gigante
// listaGeralAmbientes = [ 
    // [nomeAmbiente, [indicesAparece], [tagsSensores], [intensidade], [horário], média ], 
    // [nomeAmbiente, [indicesAparece], [tagsSensores], [intensidade], [horário], média ], 
    // [nomeAmbiente, [indicesAparece], [tagsSensores], [intensidade], [horário], média ] 
// ]

function functionMatrizParaTelaAmbientes() {
    var containerFiltros = document.getElementById('idContainerFiltros')

    var listaAuxiliarAmbientes = []
    var listaAuxiliarIndices = []

    for (var i = 0; i < listaGeralAmbientes.length; i++ ) {
        if (listaGeralAmbientes[i][1].length == 0) {
            stop
        } else {
            listaAuxiliarAmbientes.push(document.createElement('span'))
            listaAuxiliarIndices.push(i)
        }
    }
    for (var i = 0; i < listaAuxiliarAmbientes.length; i++) {
        listaAuxiliarAmbientes[i].textContent = `${listaGeralAmbientes[listaAuxiliarIndices[i]][0]}`
        if (listaGeralAmbientes[i][5] > 600) {
            listaAuxiliarAmbientes[i].innerHTML += '<img src="./Assets/filtro_alertaElevado.png" alt=""></img>'
            listaAuxiliarAmbientes[i].classList.add('filtro_ambienteMuitoAcima')
            listaAuxiliarAmbientes[i].addEventListener('click', (event) => {
                // listaGeralAmbientes[listaAuxiliarIndices[i]]
                // slaDoido
                console.log('')
                functionMatrizParaTelaKpisGrafico(listaGeralAmbientes[listaAuxiliarIndices[i]])
                console.log(listaGeralAmbientes[listaAuxiliarIndices[i]])
            })
        } else if (listaGeralAmbientes[i][5] < 400) {
            listaAuxiliarAmbientes[i].innerHTML += '<img src="./Assets/filtro_alertaInferior.png" alt=""></img>'
            listaAuxiliarAmbientes[i].classList.add('filtro_ambienteMuitoAbaixo')
            listaAuxiliarAmbientes[i].addEventListener('click', (event) => {
                // slaDoido
                functionMatrizParaTelaKpisGrafico(listaGeralAmbientes[listaAuxiliarIndices[i]])
            })
        } else {
            listaAuxiliarAmbientes[i].innerHTML += '<img src="./Assets/filtro_check.png" alt=""></img>'
            listaAuxiliarAmbientes[i].classList.add('filtro_ambienteOk')
            listaAuxiliarAmbientes[i].addEventListener('click', (event) => {
                // slaDoido
                functionMatrizParaTelaKpisGrafico(listaGeralAmbientes[listaAuxiliarIndices[i]])
            })
        }
        
    }
    for (var i = 0; i < listaAuxiliarAmbientes.length; i++ ) {
        containerFiltros.appendChild(listaAuxiliarAmbientes[i])
    }
}

function functionMatrizParaTelaKpisGrafico(arrayTotal) {
    var qtdAlertas = document.getElementById('idQtdAlertas')
    var mediaSensores = document.getElementById('idMediaSensores')
    var pico = document.getElementById('idPico')
    var minimo = document.getElementById('idMinimo')
    var ideal = document.getElementById('idIdeal')
    var elevado = document.getElementById('idElevado')
    var inferior = document.getElementById('idInferior')

    var alertas = 0
    var max = 0
    var min = 0
    var alertasAcima = 0
    var alertasInferior = 0
    console.log(arrayTotal)
    for (var i = 0; i < arrayTotal[1].length; i++) {
        if (arrayTotal[3][i] < 400) {
            alertas++
            alertasInferior++
        } else if (arrayTotal[3][i] > 600) {
            alertas++
            alertasAcima++
        }
        if (arrayTotal[3][i] > max) {
            max = arrayTotal[3][i]
        }
        if (arrayTotal[3][i] < min) {
            min = arrayTotal[3][i]
        }
    }

    // qtdAlertas = alertas
    qtdAlertas.innerText = alertas
    mediaSensores.textContent = arrayTotal[5]
}