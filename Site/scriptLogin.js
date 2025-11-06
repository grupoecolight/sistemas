function valEmail() {
    var email = document.getElementById('input_email').value

    var tamanho = email.length - 1


    if (email.includes('@')) { // Não pode ter mais de 1 '@'
        email = email.replace('@', '*')
        if (email.includes('@')) {
            div_mensagemEmail.innerHTML = 'O e-mail comporta apenas 1 "@".'
        } else {
            div_mensagemEmail.innerHTML = ''
        }
    } else {
        div_mensagemEmail.innerHTML = ''
    }

    if (email[0] == '.' || (email[tamanho] == '.' && email[(tamanho - 1)] == '.')) { // Não deixa começar com ponto e nem ter 2 pontos seguidos
        input_email.value = input_email.value.slice(0, -1)
    }

    if (email[tamanho] == ' ' || email[tamanho] == ',' || email[tamanho] == ':' || email[tamanho] == ';') { // Não pode usar 'espaço', 'vírgula', ':', ';'
        input_email.value = input_email.value.slice(0, -1)
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

    var email = document.getElementById('input_email').value
    var validacao = true

    var senha = document.getElementById('input_password').value
    var senhaMaiuscula = senha.toUpperCase()
    var senhaMinuscula = senha.toLowerCase()
    
    div_mensagemEmail.innerHTML = ''
    div_mensagemSenha.innerHTML = ''

    if (email.length == 0) {
        validacao = false
        div_mensagemSenha.innerHTML += `O campo e-mail não foi preenchido. <br>`
        
    } else if (email.length > 255) { // Não pode ter mais de 255 caracteres
        validacao = false
        div_mensagemSenha.innerHTML += `O campo e-mail não comporta mais de 255 caracteres <br>`
    } else if (email.endsWith('.')) { // Não pode terminar com ponto
        validacao = false
        div_mensagemSenha.innerHTML += `O campo e-mail não pode terminar com "." <br>`
    } else if (email != emailCorreto || senha != senhaCorreta) {
        div_mensagemSenha.innerHTML += 'Seu e-mail ou senha estão incorretos. <br>'
        validacao = false
    }


    if (senha.length == 0) {
        div_mensagemSenha.innerHTML += 'O campo senha não foi preenchido. <br>'
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
            input_password.value = ""
            input_email.value = ""
        }
    }

}
