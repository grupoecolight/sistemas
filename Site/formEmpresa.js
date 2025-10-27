function buttonSubmitForm () {
    var messagem = document.getElementById('textarea_mensagem').value;
    var nomeEmpresa = input_nomeEmpresa.value;
    var email = input_emailEmpresa.value;
    var nomeRepresentante = input_nomeRepresentante.value;
    var tellContato = input_telefoneContato.value;
    var cont = 0


    if (nomeEmpresa == ""){
        alert(`Insira o nome da empressa para poder continuar`)
    }
    if(email == ""){
        alert(`Insira o email para poder continuar`)
    }
    if(nomeRepresentante == ""){
        alert(`Insira o nome do representante para continuar`)
    }
    if(tellContato == ""){
        alert(`Insira um telefone para contato para continuar`)
    }

    while (cont < messagem.length) {
        cont++
    }
    if (cont <= 0 ) {
        alert(`Erro! Algo precisa ser inserido para a mensagem ser enviada.`)
    } else if (cont > 500){
        alert(`Erro! A mensagem ultrapassou os 500 caracters`)
    } else {
        alert(`Mensagem enviada`)
    }
    }

