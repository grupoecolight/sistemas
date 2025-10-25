function buttonSubmitForm () {
    var messagem = document.getElementById('textarea_mensagem').value

    var cont = 0
    while (cont < messagem.length) {
        cont++
    }
    if (cont > 500) {
        alert(`Para a mensagem ser enviada, ela precisa ser abaixo de 500 caracteres.`)
    } else {
        alert(`Mensagem enviada`)
    }
}