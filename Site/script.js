function valEmail() {
    var email = document.getElementById('input_emailEmpresa').value

    var tamanho = email.length - 1
    
    
    if (email.includes('@')) { // Não pode ter mais de 1 '@'
        email = email.replace('@', '*')
        if (email.includes('@')) {
            div_mensagemEmail.innerText = 'Apenas 1 "@" é permitido'
        } else {
            div_mensagemEmail.innerText = ''
        }    
    }
    
    if (email[tamanho] == ' ' || email[tamanho] == ',' || email[tamanho] == ':' || email[tamanho] == ';') { // Não pode usar 'espaço', 'vírgula', ':', ';'
        input_emailEmpresa.value = input_emailEmpresa.value.slice(0, -1)
    }
}

function entrar() {
    var email = document.getElementById('input_emailEmpresa').value
    var validacao = true

    if (email.length > 255) { // Não pode ter mais de 255 caracteres
        validacao = false
        alert(`Não pode ter mais de 255 caracteres`)
    } else if (email.startsWith('.') || email.endsWith('.')) { // Não pode começar nem terminar com ponto
        validacao = false
        alert(`Não pode começar nem terminar com ponto`)
    } else if (email.includes('..')){ // Não pode ter 2 pontos seguidos
        validacao = false
        alert(`Não pode ter 2 pontos seguidos`)
    } else if (email.includes('@') == false) { // Tem que ter pelo menos 1 '@'
        validacao = false
        alert(`Tem que ter pelo menos 1 '@'`)
    }

}