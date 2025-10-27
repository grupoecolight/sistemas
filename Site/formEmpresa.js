function buttonSubmitForm () {
    var messagem = document.getElementById('textarea_mensagem').value

    var cont = 0
    while (cont < messagem.length) {
        cont++
    }
    if (cont > 500) {
        alert(`Erro! Você ultrapassou o limite de 500 caracteres.`)
    } else {
        alert(`Mensagem enviada`)
    }
}