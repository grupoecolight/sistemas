function buttonSubmitForm () {
    var messagem = document.getElementById('textarea_mensagem').value;
    var nomeEmpresa = input_nomeEmpresa.value;
    var email = input_emailEmpresa.value;
    var nomeRepresentante = input_nomeRepresentante.value;
    var tellContato = input_telefoneContato.value;
    var cont = 0


    if (nomeEmpresa == "" || email == "" || nomeRepresentante == "" || tellContato == "" ){
        alert(`Preencha todos os campos parar continuar`)
    }

    while (cont < messagem.length) {
        cont++
    }
    if (cont <= 0 ) {
        
    } else if (cont > 500){
        alert(`Erro! A mensagem ultrapassou os 500 caracters`)
    } else {
        alert(`Mensagem enviada`)
    }
    }

