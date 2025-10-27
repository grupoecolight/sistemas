function valEmail() {
    var email = document.getElementById('input_emailOuCnpj').value

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
        input_emailOuCnpj.value = input_emailOuCnpj.value.slice(0, -1)
    }
    
    if (email[tamanho] == ' ' || email[tamanho] == ',' || email[tamanho] == ':' || email[tamanho] == ';') { // Não pode usar 'espaço', 'vírgula', ':', ';'
        input_emailOuCnpj.value = input_emailOuCnpj.value.slice(0, -1)
    }
}

function valSenha() {
    var senha = document.getElementById('input_password').value
    var tamanho = senha.length

    if (tamanho > 50) { // Não deixa colocar mais que 50 caracteres
        input_password.value = input_password.value.slice(0, -1)
    }
}

function entrar() {
    var emailCorreto = 'admin@ecolight.com'
    var senhaCorreta = 'Urubu100'

    var email = document.getElementById('input_emailOuCnpj').value
    var validacao = true

    var senha = document.getElementById('input_password').value
    var senhaMaiuscula = senha.toUpperCase()
    var senhaMinuscula = senha.toLowerCase()

    div_mensagemEmail.innerHTML = ''

    if (email.length > 255) { // Não pode ter mais de 255 caracteres
        validacao = false
        div_mensagemEmail.innerHTML += `Não pode ter mais de 255 caracteres`
    } else if (email.endsWith('.')) { // Não pode terminar com ponto
        validacao = false
        div_mensagemEmail.innerHTML += `Não pode terminar com ponto`
    } else if (email.includes('@') == false) { // Tem que ter pelo menos 1 '@'
        validacao = false
        div_mensagemEmail.innerHTML += `Tem que ter pelo menos 1 '@'`
    }

    div_mensagemSenha.innerHTML = ''

    // if (senha == senhaMaiuscula && senha == senhaMinuscula) {
    //     div_mensagemSenha.innerHTML += 'É preciso ter pelo menos 1 letra <br>'
    //     validacao = false
    // }
    if (senha == senhaMaiuscula) { // A Senha deve ter pelo menos 1 letra Minúscula
        div_mensagemSenha.innerHTML += 'É preciso ter pelo menos 1 letra Minúscula <br>'
        validacao = false
    }
    if (senha == senhaMinuscula) { // A Senha deve ter pelo menos 1 letra Maiúscula
        div_mensagemSenha.innerHTML += 'É preciso ter pelo menos 1 letra Maiúscula <br>'
        validacao = false
    }
    if (senha.length < 8) { // A senha deve conter pelo menos 8 caracteres
        div_mensagemSenha.innerHTML += 'É preciso ter pelo menos 8 Caracteres <br>'
        validacao = false
    }

    if (validacao) {
        if (email == emailCorreto) {
            if (senha == senhaCorreta) {
                window.location.href = './dashboard.html'
            } else {
                alert(`Senha Incorreta.`)
            }
        } else {
            alert(`Email não encontrado em nosso Banco de Dados.`)
        }
    }
    
}