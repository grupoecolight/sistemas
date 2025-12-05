var listaTodosAmbientes = []

var arrayAmbientesGeral = []
var arrayTagsSensoresGeral = []
var arrayIntensidadeGeral = []
var arrayDtRegistros = []

functionPuxarAsFunctionsIniciais()


function functionPuxarAsFunctionsIniciais() {
    functionPuxarAmbienteEMedia()
    console.log('test')
    arrayAmbientesGeral = functionTransformarSessionEmArray(sessionStorage.AMBIENTE_GERAL)
    console.log(arrayAmbientesGeral)
    arrayTagsSensoresGeral = functionTransformarSessionEmArray(sessionStorage.TAGSENSOR_GERAL)
    console.log(arrayTagsSensoresGeral)
    arrayIntensidadeGeral = functionTransformarSessionEmArray(sessionStorage.INTENSIDADELUZ_GERAL)
    console.log(arrayIntensidadeGeral)
    arrayDtRegistros = functionTransformarSessionEmArray(sessionStorage.DTREGISTROS_GERAL)
    arrayDtRegistros = functionTransformarDatas(arrayDtRegistros)
    console.log(arrayDtRegistros)

    functionOrganizarTudo()
}

function functionPuxarAmbienteEMedia() {
    var idEmpresaVar = sessionStorage.IDEMPRESA_USUARIO

    if (idEmpresaVar == '') {
        alert('Seu idEmpresa está vazio')
    }

    fetch('/dashGeral/puxarAmbienteEMedia', {
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
                    sessionStorage.AMBIENTE_GERAL = json.ambiente
                    sessionStorage.TAGSENSOR_GERAL = json.tagSensor
                    sessionStorage.INTENSIDADELUZ_GERAL = json.intensidadeLuz
                    sessionStorage.DTREGISTROS_GERAL = json.dtRegistros
                })
            } else {
                alert('Deu erro (resposta não veio ok) - sla...')
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

function functionTransformarDatas(arrayFunction) {
    var arrayTemp = []
    for (var i = 0; i < arrayFunction.length; i++) {
        arrayTemp.push(arrayFunction[i].slice(0, 10) + ' ' + arrayFunction[i].slice(11, 19))
    }

    return arrayTemp
}

function functionOrganizarTudo() {
    var ambienteExiste = false 
    for (var i = 0; i < arrayAmbientesGeral.length; i++) {
        ambienteExiste = false 
        // for para verificar se o ambiente já existe
        for (var j = 0; j < listaTodosAmbientes.length; j++) {
            if (listaTodosAmbientes[i][0] == arrayAmbientesGeral[j]) {
                ambienteExiste = true
            }
        }
        // caso não exista, adiciona um novo array com o ambiente
        if (!ambienteExiste) {
            listaTodosAmbientes.push([arrayAmbientesGeral[i], [], [], [], []])
        }

        console.log(listaTodosAmbientes)

        // verificar e adicionar os indices do mesmo ambiente
        for (var j = 0; j < arrayAmbientesGeral.length; j++) {
            if (listaTodosAmbientes[i][0] == arrayAmbientesGeral[j]) {
                listaTodosAmbientes[i][1].push(j)
            }
        }

        // adicionar as tags na Matriz
        for (var j = 0; j < arrayTagsSensoresGeral.length; j++) {
            if (listaTodosAmbientes[i][0] == arrayAmbientesGeral[j]) {
                listaTodosAmbientes[i][2].push(arrayTagsSensoresGeral[j])
            }
        }

        // adicionar as Intensidades na Matriz
        for (var j = 0; j < arrayIntensidadeGeral.length; j++) {
            if (listaTodosAmbientes[i][0] == arrayAmbientesGeral[j]) {
                listaTodosAmbientes[i][3].push(arrayIntensidadeGeral[j])
            }
        }

        // adicionar os horários na Matriz
        for (var j = 0; j < arrayDtRegistros.length; j++) {
            if (listaTodosAmbientes[i][0] == arrayAmbientesGeral[j]) {
                listaTodosAmbientes[i][4].push(arrayDtRegistros[j])
            }
        }

        // adicionar a média de cada ambiente
        var media = 0
        var soma = 0
        var quant = 0
        for (var j = 0; j < listaTodosAmbientes[i][3].length; j++) {
            soma += Number(listaTodosAmbientes[i][3][j])
            quant ++
        }
        media = (soma / quant).toFixed(0)
        listaTodosAmbientes[i][6] = media
    }

    console.log(listaTodosAmbientes)
}