CREATE DATABASE Ecolight;
USE Ecolight;

CREATE TABLE empresa (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    razaoSocial VARCHAR(255),
    cnpj CHAR(14),
    cep CHAR(8),
    responsavel VARCHAR(255),
    telefone CHAR(11),
    dtCadastro DATETIME,
    senha VARCHAR(45)
);

CREATE TABLE mensagem (
idMensagem INT PRIMARY KEY AUTO_INCREMENT,
nomeEmpresa VARCHAR (45),
emailEmpresa VARCHAR (255),
nomeRepresentante VARCHAR (45),
contatoTel CHAR(11),
mensagem VARCHAR(500),
dtEnvio DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE usuario (
    idUsuario INT AUTO_INCREMENT,
    nome VARCHAR(45),
    areaEmpresa VARCHAR(45),
    email VARCHAR(255),
    senha VARCHAR(45),
    userAdmin INT,
    CONSTRAINT chkUserAdmin CHECK (userAdmin IN (0,1)),
    
    fkOrganizacao INT,
    CONSTRAINT pkUsuario PRIMARY KEY (idUsuario, fkOrganizacao),
    CONSTRAINT fkUsuarioEmpresa FOREIGN KEY (fkOrganizacao)
        REFERENCES empresa(idEmpresa)
);

CREATE TABLE ambiente (
idAmbiente INT PRIMARY KEY AUTO_INCREMENT,
andar INT,
nome VARCHAR(45),
fkEmpresa INT,
	CONSTRAINT fkambiente_empresa
		FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

CREATE TABLE Sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    tagSensor CHAR(7),
    area VARCHAR(25),
    fkAmbiente INT,
    CONSTRAINT fkSensorEmpresa FOREIGN KEY (fkAmbiente)
        REFERENCES ambiente(idAmbiente)
);

CREATE TABLE regSensor (
    idRegSensor INT AUTO_INCREMENT,
    intensidadeLuz INT,
    fkSensor INT,
    dtHora DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pkRegSensor PRIMARY KEY (idRegSensor, fkSensor),
    CONSTRAINT fkRegSensor FOREIGN KEY (fkSensor)
        REFERENCES Sensor(idSensor)
);

insert into ambiente values 
(default, 2, 'Sala de reunião', 2),
(default, 2, 'Sala de reunião', 2),
(default, 2, 'Sala de reunião', 2),
(default, 2, 'Sala de reunião', 2),
(default, 2, 'Sala de reunião', 2),
(default, 2, 'Sala de reunião', 2);


INSERT INTO empresa (razaoSocial, cnpj, cep, responsavel, telefone, dtCadastro, senha) VALUES
('XPTO Technology LTDA', '10276849534012', '01310000', 'Maria Silva', 11987654321, '2025-01-15 10:30:00', 'senha123'),
('Eco Buzziness LTDA', '40345976786543', '01310940', 'João Pereira', 11956433478, '2025-02-10 14:00:00', 'empresa2025'),
('Seguradora de veículos LTDA', '54367891235409', '01310200', 'Ana Lima', 11956422465, '2025-03-05 09:15:00', 'segura@456');


INSERT INTO mensagem VALUES
(DEFAULT, 'XPTO Technology LTDA', 'xptotechnology@ecolight.com', 'Friedrich Nietzsche', '11985540981', 'Prezados, informamos a ocorrência de um erro no sistema de monitoramento de intensidade luminosa, no dia 16/20. 
O problema gerou leituras incorretas em alguns pontos de medição. Solicitamos uma revisão para a solução do problema. Esperamos um retorno. Obrigado!! '),
(DEFAULT, 'Eco Buzziness LTDA', 'ecobuzziness@gmail.com', 'Guy Fawkes', '11940028922', 'Prezados, identificamos um erro no sistema de monitoramento de intensidade luminosa em nossa empresa. Solicitamos o suporte técnico para verificação e correção do problema. 
Por favor, agendem uma visita o mais breve possível para realizar a manutenção necessária.');


INSERT INTO usuario (areaEmpresa, email, senha, fkOrganizacao, userAdmin) VALUES
('Administração', 'admin@empresa1.com', 'admin123', 1, 0),
('Recursos Humanos', 'rh@empresa1.com', 'rh2025', 2, 1),
('Gerência', 'gerente@empresa2.com', 'ger@XPTO', 3, 0);


-- Empresa 1
INSERT INTO Sensor (idSensor, tagSensor, area, fkEmpresa) VALUES
(default, '002-NOR', 'Sala de reuniões', 1),
(default, '012-NOR', 'Sala de reuniões', 1),
(default, '022-NOR', 'Sala de reuniões', 1),
(default, '032-NOR', 'Sala de reuniões', 1),
(default, '042-SUL', 'Sala de reuniões', 1),
(default, '052-SUL', 'Sala de reuniões', 1),
(default, '062-SUL', 'Sala de reuniões', 1),
(default, '072-SUL', 'Sala de reuniões', 1);

-- Empresa 2
INSERT INTO Sensor (idSensor, tagSensor, area, fkEmpresa) VALUES
(default, '007-LES', 'Sala de conferência', 2),
(default, '017-LES', 'Sala de conferência', 2),
(default, '027-LES', 'Sala de conferência', 2),
(default, '037-LES', 'Sala de conferência', 2),
(default, '047-OES', 'Sala de conferência', 2),
(default, '057-OES', 'Sala de conferência', 2),
(default, '067-OES', 'Sala de conferência', 2),
(default, '077-OES', 'Sala de conferência', 2);

-- Empresa 3
INSERT INTO Sensor (idSensor, tagSensor, area, fkEmpresa) VALUES
(default, '001-OES', 'Recepção', 3), -- dois primeiros dígitos numericos = andar / último dígito numerico = andar
(default, '011-OES', 'Recepção', 3),
(default, '021-OES', 'Recepção', 3),
(default, '031-OES', 'Recepção', 3),
(default, '001-SUL', 'Recepção', 3),
(default, '021-SUL', 'Recepção', 3),
(default, '031-SUL', 'Recepção', 3),
(default, '041-SUL', 'Recepção', 3),
(default, '001-LES', 'Recepção', 3),
(default, '011-LES', 'Recepção', 3),
(default, '021-LES', 'Recepção', 3),
(default, '031-LES', 'Recepção', 3);


-- Empresa 1
INSERT INTO regSensor (intensidadeLuz, fkSensor) VALUES
(380, 1),
(380, 1),
(360, 1),
(360, 1),
(350, 1),
(330, 1),
(330, 1),
(320, 1);


-- Empresa 1
INSERT INTO regSensor (intensidadeLuz, fkSensor) VALUES
(380, 2),
(380, 2),
(360, 2),
(360, 2),
(350, 2),
(330, 2),
(330, 2),
(320, 2);


-- Empresa 1
INSERT INTO regSensor (intensidadeLuz, fkSensor) VALUES
(370, 3),
(370, 3),
(350, 3),
(350, 3),
(340, 3),
(320, 3),
(320, 3),
(310, 3),

(370, 4),
(370, 4),
(350, 4),
(350, 4),
(340, 4),
(320, 4),
(320, 4),
(310, 4),

(330, 5),
(330, 5),
(320, 5),
(320, 5),
(310, 5),
(300, 5),
(290, 5),
(290, 5),

(330, 6),
(330, 6),
(320, 6),
(320, 6),
(310, 6),
(300, 6),
(290, 6),
(290, 6),

(320, 7),
(320, 7),
(310, 7),
(310, 7),
(300, 7),
(290, 7),
(280, 7),
(280, 7),

(320, 8),
(320, 8),
(310, 8),
(310, 8),
(300, 8),
(290, 8),
(280, 8),
(280, 8);


-- Empresa 2
INSERT INTO regSensor (intensidadeLuz, fkSensor) VALUES
(450, 9),
(450, 9),
(460, 9),
(460, 9);


-- Empresa 2
INSERT INTO regSensor (intensidadeLuz, fkSensor) VALUES
(450, 10),
(450, 10),
(460, 10),
(460, 10),

(440, 11),
(440, 11),
(450, 11),
(450, 11),

(440, 12),
(440, 12),
(450, 12),
(450, 12);


-- Empresa 2
INSERT INTO regSensor (intensidadeLuz, fkSensor) VALUES
(400, 13),
(400, 13),
(390, 13),
(390, 13),

(400, 14),
(400, 14),
(390, 14),
(390, 14),

(390, 15),
(390, 15),
(380, 15),
(380, 15),

(390, 16),
(390, 16),
(380, 16),
(380, 16);


-- Empresa 3
INSERT INTO regSensor (intensidadeLuz, fkSensor) VALUES
(370, 17),
(370, 17),
(390, 17),

(370, 18),
(370, 18),
(390, 18),

(380, 19),
(380, 19),
(400, 19),

(380, 20),
(380, 20),
(400, 20),

(410, 21),
(410, 21),
(410, 21),

(410, 22),
(410, 22),
(410, 22),

(410, 23),
(410, 23),
(410, 23),

(390, 24),
(390, 24),
(390, 24),

(370, 25),
(370, 25),
(360, 25),

(360, 26),
(360, 26),
(360, 26),

(360, 27),
(360, 27),
(360, 27),

(350, 28),
(350, 28),
(350, 28);


-- Dados de cada empresa
CREATE VIEW dados_das_empresas AS
SELECT e.razaoSocial AS 'Nome da Empresa',
e.cnpj AS 'CNPJ',
e.cep AS 'CEP',
e.responsavel AS 'Responsável da empresa',
e.telefone AS 'Telefone para contato',
e.dtCadastro AS 'Data de Cadastro',
e.senha AS 'Senha da Empresa',
u.areaEmpresa AS 'Função do Usuário',
u.email AS 'Email para contato',
u.senha AS 'Senha do Usuário'
FROM empresa e JOIN usuario u
ON e.idEmpresa = u.fkOrganizacao;


CREATE VIEW empresa_sensor_ambiente AS
SELECT e.razaoSocial AS 'Nome da Empresa',
e.cnpj AS 'CNPJ',
e.cep AS 'CEP',
e.responsavel AS 'Responsável da empresa',
e.telefone AS 'Telefone para contato',
e.dtCadastro AS 'Data de Cadastro',
e.senha AS 'Senha da Empresa',
a.andar,
a.nome,
s.tagSensor AS 'Tag do Sensor'
FROM empresa e JOIN ambiente a
on e.idEmpresa = a.fkEmpresa
JOIN Sensor s
on s.idSensor = a.fkEmpresa;

/* Consultar dados da empresa e seus sensores da view empresa_sensor_ambiente */
select * from empresa_sensor_ambiente;


/*Consultar nome da empresa, andar, nome do ambiente e tag do sensor da view empresa_sensor_ambiente*/
select 'Nome da Empresa', andar, nome, 'Tag do Sensor' FROM empresa_sensor_ambiente;  


/* Consultar registros de cada sensor */
CREATE VIEW registro_sensor AS
Select e.razaoSocial as Empresa, a.nome as Ambiente ,intensidadeLuz as Lux, tagSensor as Sensor, dtHora as 'Data' 
FROM Sensor s JOIN regSensor r
on s.idSensor = r.fkSensor
JOIN ambiente a
on a.idAmbiente = s.fkAmbiente
JOIN empresa e
on e.idEmpresa = a.fkEmpresa;

/* Consultar registros de cada sensor e de cada empresa - View*/
select * from registro_sensor;

SELECT e.razaoSocial AS 'Nome da Empresa',
e.responsavel AS 'Responsável',
u.areaEmpresa AS 'Função do Usuário',
u.email AS 'Email para contato',
s.tagSensor AS 'Tag do Sensor',
s.area AS 'Local do Sensor',
s.idSensor AS 'ID Sensor'
FROM empresa e JOIN usuario u 
ON e.idEmpresa = u.fkOrganizacao
JOIN Sensor s ON e.idEmpresa = s.fkEmpresa
ORDER BY e.idEmpresa;

SELECT e.razaoSocial AS 'Nome da Empresa',
e.cnpj AS 'CNPJ',
e.cep AS 'CEP',
e.responsavel AS 'Responsável',
e.telefone AS 'Telefone',
e.dtCadastro AS 'Data de Cadastro',
u.areaEmpresa AS 'Área do Usuário',
u.email AS 'E-mail do Usuário',
u.senha AS 'Senha do Usuário',
s.tagSensor AS 'Tag do Sensor',
s.area AS 'Local do Sensor',
r.intensidadeLuz AS 'Intensidade da Luz',
r.dtHora AS 'Data e Hora da Leitura'
FROM empresa e JOIN usuario u 
ON e.idEmpresa = u.fkOrganizacao
JOIN Sensor s ON e.idEmpresa = s.fkEmpresa
LEFT JOIN regSensor r ON s.idSensor = r.fkSensor
ORDER BY e.idEmpresa, s.idSensor, r.dtHora;

SELECT nomeEmpresa AS Empresa, emailEmpresa AS Email, mensagem AS Mensagem
FROM mensagem;
