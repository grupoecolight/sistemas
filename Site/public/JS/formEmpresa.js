function buttonSubmitForm () {
    var mensagem = document.getElementById('textarea_mensagem').value;
    var nomeEmpresa = document.getElementById('input_nomeEmpresa').value;
    var email = document.getElementById('input_emailEmpresa').value;
    var divEmail = document.getElementById('div_mensagemEmail').value
    var nomeRepresentante = document.getElementById('input_nomeRepresentante').value;
    var tellContato = document.getElementById('input_telefoneContato').value;
    var cont = 0

    while (cont < mensagem.length) {
        cont++
    }

    if (nomeEmpresa == "" || email == "" || nomeRepresentante == "" || tellContato == "" || mensagem == ""){
        div_mensagemMensagem.innerHTML = `Preencha todos os campos para continuar`
        return
    } else if (cont > 500){
        div_mensagemMensagem.innerHTML = `Erro! A mensagem ultrapassou os 500 caracters`
        return
    } else if (email.length > 255) { // Não pode ter mais de 255 caracteres
        div_mensagemMensagem.innerHTML = ''
        div_mensagemEmail.innerHTML += `Não pode ter mais de 255 caracteres`
        return
    } else if (email.endsWith('.')) { // Não pode terminar com ponto
        div_mensagemMensagem.innerHTML = ''
        div_mensagemEmail.innerHTML += `Não pode terminar com ponto`
        return
    } else if (email.includes('@') == false) { // Tem que ter pelo menos 1 '@'
        div_mensagemMensagem.innerHTML = ''
        div_mensagemEmail.innerHTML += `Tem que ter pelo menos 1 '@'`
        return
    } else if (tellContato.length < 15) {
        div_mensagemMensagem.innerHTML = 'Preencha o Campo Telefone corretamente.'
        return
    } else {
        div_mensagemMensagem.innerHTML = ``
        alert(`Mensagem enviada`)
        input_nomeEmpresa.value = ''
        input_emailEmpresa.value = ''
        input_nomeRepresentante.value = ''
        input_telefoneContato.value = ''
        textarea_mensagem.value = ''
    }

    var nomeEmpresaVar = nomeEmpresa
    var emailVar = email
    var nomeRepresentanteVar = nomeRepresentante
    var tellContatoVar = tellContato
    var mensagemVar = mensagem

    if (
        nomeEmpresaVar == '' ||
        emailVar == '' ||
        nomeRepresentanteVar == '' ||
        tellContatoVar == '' ||
        mensagemVar == ''
    ) {
        div_mensagemMensagem.innerHTML = `Preencha todos os campos para continuar`
        return
    }

    fetch('/mensagem/cadastrarMsg', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            nomeEmpresaServer: nomeEmpresaVar,
            emailServer: emailVar,
            nomeRepresentanteServer: nomeRepresentanteVar,
            tellContatoServer: tellContatoVar,
            mensagemServer: mensagemVar
        })
    })
        .then(function (resposta) {
            if (resposta.ok) {
                alert('Mensagem enviada com sucesso.')
            } else {
                alert('Houve um erro ao tentar armazenar')
            }
        })
        .catch(function (resposta) {
            console.log(`ERRO: ${resposta}`)
        })
}

function valEmail() {
    var email = document.getElementById('input_emailEmpresa').value

    var tamanho = email.length - 1
    
    if (email.includes('@')) { // Não pode ter mais de 1 '@'
        email = email.replace('@', '*')
        if (email.includes('@')) {
            div_mensagemEmail.innerHTML = 'Apenas 1 "@" é permitido'
        } else {
            div_mensagemEmail.innerHTML = ''
        }    
    } else {
        div_mensagemEmail.innerHTML = ''
    }    

    if (email[0] == '.' || (email[tamanho] == '.' && email[(tamanho - 1)] == '.')) { // Não deixa começar com ponto e nem ter 2 pontos seguidos
        input_emailEmpresa.value = input_emailEmpresa.value.slice(0, -1)
    }
    
    if (email[tamanho] == ' ' || email[tamanho] == ',' || email[tamanho] == ':' || email[tamanho] == ';') { // Não pode usar 'espaço', 'vírgula', ':', ';'
        input_emailEmpresa.value = input_emailEmpresa.value.slice(0, -1)
    }
}

function valTel() {
    var tel = document.getElementById('input_telefoneContato').value
    var tamanho = tel.length - 1

    if (!isNaN(tel[tamanho]) && !(tel[tamanho] == ' ')) { // Deixa digitar apenas números
        if (tamanho == 2 && tel[0] != '(') { // Coloca os parenteses automatico a partir do terceiro número colocado
            input_telefoneContato.value = `(${tel[0]}${tel[1]}) ${input_telefoneContato.value.slice(2, (tamanho + 1))}`
        } else if (tamanho == 10) { // Coloca o traço automatico
            input_telefoneContato.value = input_telefoneContato.value.slice(0, -1) + '-' + input_telefoneContato.value[tamanho]
        }
    } else { // Apaga tudo que não for número
        input_telefoneContato.value = input_telefoneContato.value.slice(0, -1)
    }
    
    if (tamanho > 14) { // Não deixa colocar mais que 14 caracteres
        input_telefoneContato.value = input_telefoneContato.value.slice(0, -1)
    }
}