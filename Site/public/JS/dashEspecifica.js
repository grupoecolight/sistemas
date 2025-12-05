var listaGeralAmbientes = []

// arrays
var arrayNomeAmbientes_empresa = []
var qtdAmbientes_empresa = 0
var arrayQtdSensores_empresa = []
var arrayNome_ultimoReg = []
var arrayQtdSensores_ultimoReg = []
var arrayIntensidade_ultimoReg = []
var arrayDtRegistro_ultimoReg = []
var arrayAmbiente_historico = []
var arrayTagSensor_historico = []
var arrayIntensidade_historico = []
var arrayDtRegistro_historico = []

// variáveis globais
var grafico_1 = 0
var grafico_2 = 0

functionPuxarAsFunctionsIniciais()

function functionPuxarAsFunctionsIniciais() {
    functionPuxarQtdAmbientes()
    functionPuxarNomeAmbienteEQtdSensor()
    functionRegistrosEHora()
    functionUltimosDezRegistros()
    console.log('testando')

    // Transformar sessionStorage / String em Array
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
    arrayDtRegistro_ultimoReg = functionTransformarDatas(arrayDtRegistro_ultimoReg)
    console.log(arrayDtRegistro_ultimoReg)
    
    arrayAmbiente_historico = functionTransformarSessionEmArray(sessionStorage.AMBIENTE_HISTORICO)
    console.log(arrayAmbiente_historico)
    arrayTagSensor_historico = functionTransformarSessionEmArray(sessionStorage.TAGSENSOR_HISTORICO)
    console.log(arrayTagSensor_historico)
    arrayIntensidade_historico = functionTransformarSessionEmArray(sessionStorage.INTENSIDADE_HISTORICO)
    console.log(arrayIntensidade_historico)
    arrayDtRegistro_historico = functionTransformarSessionEmArray(sessionStorage.DTREGISTROS_HISTORICO)
    arrayDtRegistro_historico = functionTransformarDatas(arrayDtRegistro_historico)
    console.log(arrayDtRegistro_historico)

    functionOrganizarTudo()

    functionMatrizParaTelaAmbientes()
}

function functionPuxarQtdAmbientes() {
    // pegar a Empresa do sessionStorage
    var idEmpresaVar = sessionStorage.IDEMPRESA_USUARIO

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
    var idEmpresaVar = sessionStorage.IDEMPRESA_USUARIO

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
    var idEmpresaVar = sessionStorage.IDEMPRESA_USUARIO

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

function functionUltimosDezRegistros() {
    // pegar a Empresa do sessionStorage
    var idEmpresaVar = sessionStorage.IDEMPRESA_USUARIO

    if (idEmpresaVar == '') {
        alert('Seu idEmpresa está vazio.')
    }

    fetch('/dashEspecifica/ultimosDezRegistros', {
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
                    sessionStorage.AMBIENTE_HISTORICO = json.ambiente
                    sessionStorage.TAGSENSOR_HISTORICO = json.tagSensor
                    sessionStorage.INTENSIDADE_HISTORICO = json.intensidadeLuz
                    sessionStorage.DTREGISTROS_HISTORICO = json.dtRegistros
                })
            } else {
                alert('Deu erro (resposta não veio ok) - Últimos 10 registros.')
            }
        }).catch(function (erro) {
            console.log(erro)
        })
    return false
}

function functionTransformarDatas(arrayFunction) {
    var arrayTemp = []
    for (var i = 0; i < arrayFunction.length; i++) {
        arrayTemp.push(arrayFunction[i].slice(0, 10) + ' ' + arrayFunction[i].slice(11, 19))
    }

    return arrayTemp
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
            listaGeralAmbientes.push([arrayNomeAmbientes_empresa[i], [], [], [], [], [ [], [], [] ]])
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
        listaGeralAmbientes[i][6] = media
    }

    // adicionar o histórico de tags
    for (var i = 0; i < arrayTagSensor_historico.length; i++) {
        for (var j = 0; j < listaGeralAmbientes.length; j++) {
            if (listaGeralAmbientes[j][0] == arrayAmbiente_historico[i]) {
                listaGeralAmbientes[j][5][0].push(arrayTagSensor_historico[i])
                listaGeralAmbientes[j][5][1].push(arrayIntensidade_historico[i])
                listaGeralAmbientes[j][5][2].push(arrayDtRegistro_historico[i])
            }
        }
    }

    console.log(listaGeralAmbientes)
}

// como está ficando a Matriz gigante
// listaGeralAmbientes = [ 
    // [nomeAmbiente, [indicesAparece], [tagsSensores], [intensidade], [horário], média, [ [tagSensorHistorico], [intensidadeHistorico], [dtRegistroHistorico] ] ], 
    // [nomeAmbiente, [indicesAparece], [tagsSensores], [intensidade], [horário], média, [ [tagSensorHistorico], [intensidadeHistorico], [dtRegistroHistorico] ] ], 
    // [nomeAmbiente, [indicesAparece], [tagsSensores], [intensidade], [horário], média, [ [tagSensorHistorico], [intensidadeHistorico], [dtRegistroHistorico] ] ] 
// ]

function functionMatrizParaTelaAmbientes() {
    var containerFiltros = document.getElementById('idContainerFiltros')
    var containerFiltrosAmbientes = document.getElementById('idContainerAmbientes')

    var listaAuxiliarAmbientes = []
    var listaAuxiliarAmbientesGeral = []
    var listaAuxiliarIndices = []

    // Criação dos Filtros de Ambiente
    for (var i = 0; i < listaGeralAmbientes.length; i++ ) {
        if (listaGeralAmbientes[i][1].length == 0) {
            stop
        } else {
            listaAuxiliarAmbientes.push(document.createElement('span'))
            listaAuxiliarAmbientesGeral.push(document.createElement('span'))
            listaAuxiliarIndices.push(i)
        }
    }
    for (let i = 0; i < listaAuxiliarAmbientes.length; i++) {
        listaAuxiliarAmbientesGeral[i].innerHTML = '<img src="./Assets/lampada_mensagem_tela_geral_dashboard.png" alt="" class="lamp-icon">'
        listaAuxiliarAmbientesGeral[i].classList.add('env-card')
        listaAuxiliarAmbientesGeral[i].innerHTML += `${listaGeralAmbientes[listaAuxiliarIndices[i]][0]}`
        
        listaAuxiliarAmbientes[i].textContent = `${listaGeralAmbientes[listaAuxiliarIndices[i]][0]}`

        // DASHGERAL
        if (listaGeralAmbientes[listaAuxiliarIndices[i]][6] > 600) {
            listaAuxiliarAmbientesGeral[i].classList.add('status-muito-acima')
        } else if (listaGeralAmbientes[listaAuxiliarIndices[i]][6] > 550) {
            listaAuxiliarAmbientesGeral[i].classList.add('status-acima')
        } else if (listaGeralAmbientes[listaAuxiliarIndices[i]][6] < 400) {
            listaAuxiliarAmbientesGeral[i].classList.add('status-muito-abaixo')
        } else if (listaGeralAmbientes[listaAuxiliarIndices[i]][6] < 450) {
            listaAuxiliarAmbientesGeral[i].classList.add('status-abaixo')
        } else {
            listaAuxiliarAmbientesGeral[i].classList.add('status-ideal')
        }
        
        if (listaGeralAmbientes[listaAuxiliarIndices[i]][6] > 600) {
            listaAuxiliarAmbientes[i].innerHTML += '<img src="./Assets/filtro_alertaElevado.png" alt="">'
            listaAuxiliarAmbientes[i].classList.add('filtro_ambienteMuitoAcima')
            listaAuxiliarAmbientes[i].addEventListener('click', () => {
                // listaGeralAmbientes[listaAuxiliarIndices[i]]
                // slaDoido
                console.log('')
                functionMatrizParaTelaKpisGrafico(listaGeralAmbientes[listaAuxiliarIndices[i]])
                console.log(listaGeralAmbientes[listaAuxiliarIndices[i]])
            })
        } else if (listaGeralAmbientes[listaAuxiliarIndices[i]][6] < 400) {
            console.log(listaGeralAmbientes[listaAuxiliarIndices[i]])
            listaAuxiliarAmbientes[i].innerHTML += '<img src="./Assets/filtro_alertaInferior.png" alt="">'
            listaAuxiliarAmbientes[i].classList.add('filtro_ambienteMuitoAbaixo')
            listaAuxiliarAmbientes[i].addEventListener('click', () => {
                // slaDoido
                functionMatrizParaTelaKpisGrafico(listaGeralAmbientes[listaAuxiliarIndices[i]])
            })
        } else {
            listaAuxiliarAmbientes[i].innerHTML += '<img src="./Assets/filtro_check.png" alt="">'
            listaAuxiliarAmbientes[i].classList.add('filtro_ambienteOk')
            listaAuxiliarAmbientes[i].addEventListener('click', () => {
                // slaDoido
                functionMatrizParaTelaKpisGrafico(listaGeralAmbientes[listaAuxiliarIndices[i]])
            })
        }
        
        listaAuxiliarAmbientesGeral[i].addEventListener('click', () => {
            // slaDoido
            functionMatrizParaTelaKpisGrafico(listaGeralAmbientes[listaAuxiliarIndices[i]])
        })
    }
    for (let i = 0; i < listaAuxiliarAmbientes.length; i++ ) {
        containerFiltros.appendChild(listaAuxiliarAmbientes[i])
    }
    for (let i = 0; i < listaAuxiliarAmbientesGeral.length; i++ ) {
        containerFiltrosAmbientes.appendChild(listaAuxiliarAmbientesGeral[i])
    }

    // DashGeral
    var GeralMonitorados = document.getElementById('idGeralMonitorados')
    GeralMonitorados.textContent = listaAuxiliarAmbientesGeral.length

    var GeralAlertas = document.getElementById('idGeralAlertas')

    var alertas = 0
    for (var i = 0; i < listaAuxiliarAmbientesGeral.length; i++) {
        if (listaAuxiliarAmbientesGeral[i][6] > 600 || listaAuxiliarAmbientesGeral[i][6] < 400) {
            alertas ++
        }
    }
    
    GeralAlertas.textContent = alertas
}

function functionMatrizParaTelaKpisGrafico(arrayTotal) {
    if (idTelaEspecifica.style.display == 'none') {
        idTelaEspecifica.style.display = 'block'
        idTelaGeral.style.display = 'none'
    } 

    // Variáveis dos títulos das KPIs
    var titlePagina = document.getElementById('idTitlePagina')
    var TitleKpiAlertas = document.getElementById('idTitleKpiAlertas')
    var TitleKpiMedia = document.getElementById('idTitleKpiMedia')
    // var TitleKpiIdeal = document.getElementById('idTitleKpiIdeal')
    // var TitleKpiAcima = document.getElementById('idTitleKpiAcima')
    // var TitleKpiAbaixo = document.getElementById('idTitleKpiAbaixo')
    
    // Variáveis dos conteúdos das KPIs
    var qtdAlertas = document.getElementById('idQtdAlertas')
    var mediaSensores = document.getElementById('idMediaSensores')
    var pico = document.getElementById('idPico')
    var minimo = document.getElementById('idMinimo')
    var ideal = document.getElementById('idIdeal')
    var elevado = document.getElementById('idElevado')
    var inferior = document.getElementById('idInferior')

    // Criação dos Filtros de Sensores

    var containerFiltrosSensores = document.getElementById('idContainerFiltrosSensores')
    
    var listaAuxiliarSensores = []
    for (let i = 0; i < arrayTotal[1].length; i++ ) {
        listaAuxiliarSensores.push(document.createElement('span'))
        listaAuxiliarSensores[i].textContent = `${arrayTotal[2][i]}`

        if (arrayTotal[3][i] > 600) {
            listaAuxiliarSensores[i].classList.add('filtro_sensorMuitoAcima')
        } else if (arrayTotal[3][i] < 400) {
            listaAuxiliarSensores[i].classList.add('filtro_sensorMuitoAbaixo')
        } else {
            listaAuxiliarSensores[i].classList.add('filtro_sensorOk')
        }
        
        listaAuxiliarSensores[i].addEventListener('click', () => {
            // listaGeralAmbientes[listaAuxiliarIndices[i]]
            // slaDoido
            functionAttGrafico2(arrayTotal, arrayTotal[2][i])
        })
    }
    containerFiltrosSensores.innerHTML = '<span class="tittleFiltro">Sensores</span>'
    for (let i = 0; i < listaAuxiliarSensores.length; i++ ) {
        containerFiltrosSensores.appendChild(listaAuxiliarSensores[i])
    }

    
    var alertas = 0
    var max = 0
    var min = 5000
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

    // Títulos
    titlePagina.textContent = `Dashboard - ${arrayTotal[0]}`
    TitleKpiAlertas.textContent = `Quantidade de alertas no Ambiente ${arrayTotal[0]}:`
    TitleKpiMedia.textContent = `Média dos sensores do Ambiente ${arrayTotal[0]}:`
    // TitleKpiIdeal.textContent = `Dashboard - ${arrayTotal[0]}`
    // TitleKpiAcima.textContent = `Dashboard - ${arrayTotal[0]}`
    // TitleKpiAbaixo.textContent = `Dashboard - ${arrayTotal[0]}`

    // Conteúdos
    qtdAlertas.textContent = alertas
    mediaSensores.textContent = `${arrayTotal[6]} lux`
    pico.textContent = `Pico: ${max} lux`
    minimo.textContent = `Mínimo: ${min} lux`
    ideal.textContent = arrayTotal[2].length - alertas
    elevado.textContent = alertasAcima
    inferior.textContent = alertasInferior

    var arrayGraficos = functionCriarGraficos(arrayTotal)

    grafico_1 = arrayGraficos[0]
    grafico_2 = arrayGraficos[1]
}




function functionAttGrafico2(arrayTotal, nameTagSensor) {
    var arrayIndicesSensores = []

    for (let i = 0; i < arrayTotal[5][0].length; i++) {
        if (arrayTotal[5][0][i] == nameTagSensor) {
            arrayIndicesSensores.push(i)
        }
    }

    var arrayTagsSensoresDez = []
    var arrayIntensidadeSensoresDez = []
    var arrayDtRegistroSensoresDez = []
    for (let i = 0; i < arrayIndicesSensores.length; i++) {
        arrayTagsSensoresDez.push(arrayTotal[5][0][arrayIndicesSensores[i]])
        arrayIntensidadeSensoresDez.push(arrayTotal[5][1][arrayIndicesSensores[i]])
        arrayDtRegistroSensoresDez.push(arrayTotal[5][2][arrayIndicesSensores[i]])
    }
    console.log(arrayDtRegistroSensoresDez)
    var arrayHoraRegistro = []
    for (let i = 0; i < arrayDtRegistroSensoresDez.length; i++) {
        arrayHoraRegistro.push(arrayDtRegistroSensoresDez[i].slice(11, 16))
    }
    // console.log("arrayTotal:", arrayTotal)
    // console.log("arrayTotal[5]:", arrayTotal[5])


    // console.log("HISTÓRICO:", {
    //     tags: arrayTotal[5][0],
    //     intensidade: arrayTotal[5][1],
    //     datas: arrayTotal[5][2]
    // })

    
    let dia = arrayDtRegistroSensoresDez[0].slice(0, 10)
    
    // criação das cores
    var cor = []
    for (let i = 0; i < arrayIntensidadeSensoresDez.length; i++) {
        if (arrayIntensidadeSensoresDez[i] > 600) {
            cor.push('#FFD535')
        } else if (arrayIntensidadeSensoresDez[i] < 400) {
            cor.push('#e45b5b')
        } else {
            cor.push('#637CEF')
        }    
    }
    
    if (grafico_2) {
        grafico_2.data.labels = arrayHoraRegistro
        grafico_2.data.datasets[0].label = dia
        grafico_2.data.datasets[0].data = arrayIntensidadeSensoresDez
        grafico_2.options.plugins.title.text = `Histórico de Registros do Sensor ${nameTagSensor}`
        grafico_2.data.datasets[0].backgroundColor = cor
        grafico_2.data.datasets[0].color = cor
        grafico_2.data.datasets[0].borderColor = cor
        grafico_2.update()
    }
}

function functionCriarGraficos(arrayTotal) {
    const ctx = document.getElementById('myChart');
    const ctx2 = document.getElementById('myChart2');

    var cor = ''
    if (arrayTotal[6] > 600) {
        cor = '#FFD535'
    } else if (arrayTotal[6] < 400) {
        cor = '#e45b5b'
    } else {
        cor = '#637CEF'
    }

    var hora = arrayTotal[4][0].slice(11, 19)

    if (grafico_1) {
        grafico_1.data.labels = arrayTotal[2]
        grafico_1.data.datasets[0].label = `Horário: ${hora}`
        grafico_1.data.datasets[0].data = arrayTotal[3]
        grafico_1.options.plugins.title.text = `Últimos Registros do Ambiente ${arrayTotal[0]}`
        grafico_1.data.datasets[0].backgroundColor = cor
        grafico_1.data.datasets[0].color = cor
        grafico_1.data.datasets[0].borderColor = cor
        grafico_1.update()
    } else {
        var grafico1 = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: arrayTotal[2],
            datasets: [{
                // label: '18:00:00 PM',
                label: `Horário: ${hora}`,
                data: arrayTotal[3],
                borderWidth: 5,
                backgroundColor: cor,
                color: cor,
                borderColor: cor,
                barPercentage: 0.4
            }]
        },
        options: {
            plugins: {
                title: {
                    display: true,
                    text: `Últimos Registros do Ambiente ${arrayTotal[0]}`,
                    font: {
                        size: 30
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    min: 0,
                    max: 1000,
                    title: {
                        display: true,
                        // text: '(%)'
                    },
                    ticks: {
                        stepSize: 50
                    }
                }
            }
        }
        })
    }
    

    var grafico2 = new Chart(ctx2, {
    type: 'line',
    data: {
        labels: ['08:00', '08:30', '09:00', '09:30', '10:00', '10:30', '11:00', '11:30', '12:00', '12:30'],
        datasets: [{
        label: '13/10/2025',
        data: [21, 22, 25, 24, 28, 36, 39, 44, 45, 47],
        borderWidth: 5,
        backgroundColor: '#FFD535',
        color: '#FFD535',
        borderColor: '#FFD535',
        tension: 0.3
        }]
    },
    options: {
        plugins: {
            title: {
                display: true,
                text: 'Histórico de Registros do Sensor 000-XXX',
                font: {
                    size: 30
                }
            }
        },
        scales: {
            y: {
                beginAtZero: true,
                min: 0,
                max: 1000,
                title: {
                    display: true,
                    // text: '(%)'
                },
                ticks: {
                    stepSize: 50
                }
            }
        }
    }
    })

    return [grafico1, grafico2]
}

function visaoGeral() {
    if (idTelaGeral.style.display == 'none') {
        idTelaGeral.style.display = 'block'
        idTelaEspecifica.style.display = 'none'
        idTitlePagina.textContent = 'Dashboard Geral'
    } 
}