function validarSessaoCadastrar() {
  var empresaAdmin = sessionStorage.EMPRESAADMIN_USUARIO

  if (empresaAdmin == '0') {
    window.location = 'dashboard.html'
    alert('Sua conta não tem permissão de cadastrar outra conta.')
  }
}

function valNome() {
  var nome = document.getElementById("input_nomeUsuario").value;
  var tamanho = nome.length - 1;
  var ultimaLetra = nome[tamanho];
  var ultimaLetraMaiuscula = ultimaLetra.toUpperCase();
  var ultimaLetraMinuscula = ultimaLetra.toLowerCase();

  if (
    (ultimaLetra == ultimaLetraMaiuscula &&
      ultimaLetra == ultimaLetraMinuscula) ||
    tamanho > 254
  ) {
    // Válido apenas a entrada de letras e o limite é 255
    if (!(ultimaLetra == " ")) {
      input_nomeUsuario.value = input_nomeUsuario.value.slice(0, -1);
    }
  }
}

function valEmail() {
  var email = document.getElementById("input_emailUsuario").value;

  var tamanho = email.length - 1;

  if (email.includes("@")) {
    // Não pode ter mais de 1 '@'
    email = email.replace("@", "*");
    if (email.includes("@")) {
      div_mensagemEmail.innerHTML = 'Apenas 1 "@" é permitido';
    } else {
      div_mensagemEmail.innerHTML = "";
    }
  } else {
    div_mensagemEmail.innerHTML = "";
  }

  if (email[0] == "." || (email[tamanho] == "." && email[tamanho - 1] == ".")) {
    // Não deixa começar com ponto e nem ter 2 pontos seguidos
    input_emailUsuario.value = input_emailUsuario.value.slice(0, -1);
  }

  if (
    email[tamanho] == " " ||
    email[tamanho] == "," ||
    email[tamanho] == ":" ||
    email[tamanho] == ";"
  ) {
    // Não pode usar 'espaço', 'vírgula', ':', ';'
    input_emailUsuario.value = input_emailUsuario.value.slice(0, -1);
  }
}

function valSenha() {
  var senha = document.getElementById("input_senhaUsuario").value;
  var tamanho = senha.length;

  if (tamanho > 50) {
    // Não deixa colocar mais que 50 caracteres
    input_senhaUsuario.value = input_senhaUsuario.value.slice(0, -1);
  }
}

function valRepetirSenha() {
  var repetirSenha = document.getElementById("input_repetirSenhaUsuario").value;
  var tamanho = repetirSenha.length;

  if (tamanho > 50) {
    // Não deixa colocar mais que 50 caracteres
    input_repetirSenhaUsuario.value = input_repetirSenhaUsuario.value.slice(
      0,
      -1
    );
  }
}

function entrar() {
  var nomeUsuario = input_nomeUsuario.value;
  var areaUsuario = input_areaUsuario.value;
  var email = document.getElementById("input_emailUsuario").value;
  var validacao = true;

  var senha = document.getElementById("input_senhaUsuario").value;
  var senhaMaiuscula = senha.toUpperCase();
  var senhaMinuscula = senha.toLowerCase();
  var repetirSenha = document.getElementById("input_repetirSenhaUsuario").value;
  var vincular = sessionStorage.IDEMPRESA_USUARIO;

  // div_mensagemEmailSenha.innerHTML = ''
  if (
    nomeUsuario == "" ||
    email == "" ||
    areaUsuario == "" ||
    senha == "" ||
    repetirSenha == ""
  ) {
    div_mensagemRepetirSenha.innerHTML = `Preencha todos os campos para continuar`;
  } else {
    if (email.length > 255) {
      // Não pode ter mais de 255 caracteres
      validacao = false;
      div_mensagemEmail.innerHTML += `O endereço de email não pode conter mais de 255 caracteres`;
    } else if (email.endsWith(".")) {
      // Não pode terminar com ponto
      validacao = false;
      div_mensagemEmail.innerHTML += `O endereço de email não pode terminar com '.'`;
    } else if (email.includes("@") == false) {
      // Tem que ter pelo menos 1 '@'
      validacao = false;
      div_mensagemEmail.innerHTML += `O endereço de email precisa conter ao menos 1 '@'`;
    } else {
      div_mensagemEmail.innerHTML = "";
    }

    div_mensagemSenha.innerHTML = "";

    // if (senha == senhaMaiuscula && senha == senhaMinuscula) {
    //     div_mensagemSenha.innerHTML += 'É preciso ter pelo menos 1 letra <br>'
    //     validacao = false
    // }
    if (senha == senhaMaiuscula) {
      // A Senha deve ter pelo menos 1 letra Minúscula
      div_mensagemSenha.innerHTML +=
        "A senha deve conter ao menos 1 letra Minúscula <br>";
      validacao = false;
    }
    if (senha == senhaMinuscula) {
      // A Senha deve ter pelo menos 1 letra Maiúscula
      div_mensagemSenha.innerHTML +=
        "A senha deve conter ao menos 1 letra Maiúscula <br>";
      validacao = false;
    }
    if (senha.length < 8) {
      // A senha deve conter pelo menos 8 caracteres
      div_mensagemSenha.innerHTML +=
        "A senha deve conter ao menos 8 Caracteres <br>";
      validacao = false;
    }

    if (senha != repetirSenha) {
      // As senhas devem ser iguais
      div_mensagemRepetirSenha.innerHTML = "As senhas devem ser iguais";
      validacao = false;
    } else {
      div_mensagemRepetirSenha.innerHTML = "";
    }

    if (validacao) {
      fetch("/usuarios/cadastrar", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          // crie um atributo que recebe o valor recuperado aqui
          // Agora vá para o arquivo routes/usuario.js
          nomeServer: nomeUsuario,
          emailServer: email,
          areaEmpresaServer: areaUsuario,
          senhaServer: senha,
          idEmpresaVincularServer: vincular,
        }),
      })
        .then(function (resposta) {
          console.log("resposta: ", resposta);

          if (resposta.ok) {
            alert("Usuário Cadastrado.");
            input_nomeUsuario.value = "";
            input_emailUsuario.value = "";
            input_areaUsuario.value = "";
            input_senhaUsuario.value = "";
            input_repetirSenhaUsuario.value = "";

            setTimeout(() => {
              window.location = "dashboard.html";
            }, "2000");

          } else {
            throw "Houve um erro ao tentar realizar o cadastro!";
          }
        })
        .catch(function (resposta) {
          console.log(`#ERRO: ${resposta}`);
        });

      return false;
    } else {
      alert('Não atendeu as validações')
    }
  }
}
