function valEmail() {
  var email = document.getElementById("input_email").value;

  var tamanho = email.length - 1;

  if (email.includes("@")) {
    // Não pode ter mais de 1 '@'
    email = email.replace("@", "*");
    if (email.includes("@")) {
      div_mensagemEmail.innerHTML = 'O e-mail comporta apenas 1 "@".';
    } else {
      div_mensagemEmail.innerHTML = "";
    }
  } else {
    div_mensagemEmail.innerHTML = "";
  }

  if (email[0] == "." || (email[tamanho] == "." && email[tamanho - 1] == ".")) {
    // Não deixa começar com ponto e nem ter 2 pontos seguidos
    input_email.value = input_email.value.slice(0, -1);
  }

  if (
    email[tamanho] == " " ||
    email[tamanho] == "," ||
    email[tamanho] == ":" ||
    email[tamanho] == ";"
  ) {
    // Não pode usar 'espaço', 'vírgula', ':', ';'
    input_email.value = input_email.value.slice(0, -1);
  }
}

function valSenha() {
  var senha = document.getElementById("input_password").value;
  var tamanho = senha.length;

  if (tamanho > 50) {
    // Não deixa colocar mais que 50 caracteres
    input_password.value = input_password.value.slice(0, -1);
  }
}

function entrar() {

  var email = document.getElementById("input_email").value;
  var validacao = true;

  var senha = document.getElementById("input_password").value;
  var senhaMaiuscula = senha.toUpperCase();
  var senhaMinuscula = senha.toLowerCase();

  div_mensagemEmail.innerHTML = "";
  div_mensagemSenha.innerHTML = "";

  if (email.length == 0 || senha.length == 0) {
    validacao = false;
    div_mensagemSenha.innerHTML += `Preencha os campos de Email e Senha. <br>`;
  } else if (email.length > 255) {
    // Não pode ter mais de 255 caracteres
    validacao = false;
    div_mensagemSenha.innerHTML += `O campo e-mail não comporta mais de 255 caracteres <br>`;
  } else if (email.endsWith(".")) {
    // Não pode terminar com ponto
    validacao = false;
    div_mensagemSenha.innerHTML += `O campo e-mail não pode terminar com "." <br>`;
  }

  if (validacao) {

        fetch("/usuarios/autenticar", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            emailServer: email,
            senhaServer: senha,
          }),
        })
          .then(function (resposta) {
            console.log("ESTOU NO THEN DO entrar()!");

            if (resposta.ok) {
              console.log(resposta);

              resposta.json().then((json) => {
                console.log(json);
                console.log(JSON.stringify(json));
                sessionStorage.EMAIL_USUARIO = json.email;
                sessionStorage.NOME_USUARIO = json.nome;
                sessionStorage.USERADMIN_USUARIO = json.userAdmin;
                sessionStorage.EMPRESAADMIN_USUARIO = json.empresaAdmin;
                sessionStorage.IDEMPRESA_USUARIO = json.idEmpresa

                setTimeout(function () {
                  window.location = "./dashboard.html";
                }, 1000); // apenas para exibir o loading
              });
            } else {
              div_mensagemSenha.innerHTML = `Email e/ou Senha não encontrado.`; 
              console.log("Houve um erro ao tentar realizar o login!");

              resposta.text().then((texto) => {
                console.error(texto);
                finalizarAguardar(texto);
              });
            }
          })
          .catch(function (erro) {
            console.log(erro);
          });

        return false;
      }
    }