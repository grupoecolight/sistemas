function buttonSubmitForm () {
    var mensagem = document.getElementById('textarea_mensagem').value;
    var nomeEmpresa = document.getElementById('input_nomeEmpresa').value;
    var email = document.getElementById('input_emailEmpresa').value;
    var nomeRepresentante = document.getElementById('input_nomeRepresentante').value;
    var tellContato = document.getElementById('input_telefoneContato').value;
    var cont = 0

    while (cont < mensagem.length) {
        cont++
    }

    if (nomeEmpresa == "" || email == "" || nomeRepresentante == "" || tellContato == "" || mensagem == ""){
        div_mensagemMensagem.innerHTML = `Preencha todos os campos para continuar`
    } else if (cont > 500){
        div_mensagemMensagem.innerHTML = `Erro! A mensagem ultrapassou os 500 caracters`
    } else {
        div_mensagemMensagem.innerHTML = ``
        alert(`Mensagem enviada`)
        input_nomeEmpresa.value = ''
        input_emailEmpresa.value = ''
        input_nomeRepresentante.value = ''
        input_telefoneContato.value = ''
        textarea_mensagem.value = ''
    }
}

