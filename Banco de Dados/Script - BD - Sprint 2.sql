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
contatoTel CHAR(15),
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
    area VARCHAR(25)
);

CREATE TABLE regSensor (
    idRegSensor INT AUTO_INCREMENT,
    fkAmbiente INT,
    fkSensor INT,
    intensidadeLuz INT,
    dtHora DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT pkRegSensor PRIMARY KEY (idRegSensor, fkSensor, fkAmbiente),
    CONSTRAINT fkRegSensor FOREIGN KEY (fkSensor) REFERENCES Sensor(idSensor),
    CONSTRAINT fkRegAmbiente FOREIGN KEY (fkAmbiente) REFERENCES ambiente(idAmbiente)
);


INSERT INTO empresa (razaoSocial, cnpj, cep, responsavel, telefone, dtCadastro, senha) VALUES
('XPTO Technology LTDA', '10276849534012', '01310000', 'Maria Silva', 11987654321, '2025-01-15 10:30:00', 'senha123'),
('Eco Buzziness LTDA', '40345976786543', '01310940', 'João Pereira', 11956433478, '2025-02-10 14:00:00', 'empresa2025'),
('Seguradora de veículos LTDA', '54367891235409', '01310200', 'Ana Lima', 11956422465, '2025-03-05 09:15:00', 'segura@456');

insert into ambiente values 
(default, 2, 'Sala de reunião', 1),
(default, 2, 'Sala de reunião', 1),
(default, 2, 'Sala de reunião', 1),
(default, 2, 'Sala de reunião', 1),
(default, 2, 'Sala de reunião', 1),
(default, 2, 'Sala de reunião', 1);


INSERT INTO mensagem (nomeEmpresa, emailEmpresa, nomeRepresentante, contatoTel, mensagem) VALUES
('XPTO Technology LTDA', 'xptotechnology@ecolight.com', 'Friedrich Nietzsche', '11985540981', 'Prezados, informamos a ocorrência de um erro no sistema de monitoramento de intensidade luminosa, no dia 16/20. 
O problema gerou leituras incorretas em alguns pontos de medição. Solicitamos uma revisão para a solução do problema. Esperamos um retorno. Obrigado!! '),
('Eco Buzziness LTDA', 'ecobuzziness@gmail.com', 'Guy Fawkes', '11940028922', 'Prezados, identificamos um erro no sistema de monitoramento de intensidade luminosa em nossa empresa. Solicitamos o suporte técnico para verificação e correção do problema. 
Por favor, agendem uma visita o mais breve possível para realizar a manutenção necessária.');


INSERT INTO usuario (areaEmpresa, email, senha, fkOrganizacao, userAdmin) VALUES
('Administração', 'admin@empresa1.com', 'admin123', 1, 0),
('Recursos Humanos', 'rh@empresa1.com', 'rh2025', 2, 1),
('Gerência', 'gerente@empresa2.com', 'ger@XPTO', 3, 0);


-- Empresa 1
INSERT INTO Sensor (idSensor, tagSensor, area) VALUES
(default, '002-NOR', 'Sala de reuniões'),
(default, '012-NOR', 'Sala de reuniões'),
(default, '022-NOR', 'Sala de reuniões'),
(default, '032-NOR', 'Sala de reuniões'),
(default, '042-SUL', 'Sala de reuniões'),
(default, '052-SUL', 'Sala de reuniões'),
(default, '062-SUL', 'Sala de reuniões'),
(default, '072-SUL', 'Sala de reuniões');

-- Empresa 2
INSERT INTO Sensor (idSensor, tagSensor, area) VALUES
(default, '007-LES', 'Sala de conferência'),
(default, '017-LES', 'Sala de conferência'),
(default, '027-LES', 'Sala de conferência'),
(default, '037-LES', 'Sala de conferência'),
(default, '047-OES', 'Sala de conferência'),
(default, '057-OES', 'Sala de conferência'),
(default, '067-OES', 'Sala de conferência'),
(default, '077-OES', 'Sala de conferência');

-- Empresa 3
INSERT INTO Sensor (idSensor, tagSensor, area) VALUES
(default, '001-OES', 'Recepção'), -- dois primeiros dígitos numericos = andar / último dígito numerico = andar
(default, '011-OES', 'Recepção'),
(default, '021-OES', 'Recepção'),
(default, '031-OES', 'Recepção'),
(default, '001-SUL', 'Recepção'),
(default, '021-SUL', 'Recepção'),
(default, '031-SUL', 'Recepção'),
(default, '041-SUL', 'Recepção'),
(default, '001-LES', 'Recepção'),
(default, '011-LES', 'Recepção'),
(default, '021-LES', 'Recepção'),
(default, '031-LES', 'Recepção');

SELECT * FROM mensagem;

-- Empresa 1 (Sensores 1-8 no Ambiente 1)
INSERT INTO regSensor (intensidadeLuz, fkSensor, fkAmbiente) VALUES
(380, 1, 1), 
(380, 1, 1), 
(360, 1, 1), 
(360, 1, 1), 
(350, 1, 1), 
(330, 1, 1), 
(330, 1, 1), 
(320, 1, 1),


(380, 2, 1), 
(380, 2, 1), 
(360, 2, 1), 
(360, 2, 1), 
(350, 2, 1), 
(330, 2, 1), 
(330, 2, 1), 
(320, 2, 1),


(370, 3, 1), 
(370, 3, 1), 
(350, 3, 1), 
(350, 3, 1), 
(340, 3, 1), 
(320, 3, 1), 
(320, 3, 1), 
(310, 3, 1),


(370, 4, 1), 
(370, 4, 1), 
(350, 4, 1), 
(350, 4, 1), 
(340, 4, 1), 
(320, 4, 1), 
(320, 4, 1), 
(310, 4, 1),


(330, 5, 1), 
(330, 5, 1), 
(320, 5, 1), 
(320, 5, 1), 
(310, 5, 1), 
(300, 5, 1), 
(290, 5, 1), 
(290, 5, 1),


(330, 6, 1), 
(330, 6, 1), 
(320, 6, 1), 
(320, 6, 1), 
(310, 6, 1), 
(300, 6, 1), 
(290, 6, 1), 
(290, 6, 1),


(320, 7, 1), 
(320, 7, 1), 
(310, 7, 1), 
(310, 7, 1), 
(300, 7, 1), 
(290, 7, 1), 
(280, 7, 1), 
(280, 7, 1),


(320, 8, 1), 
(320, 8, 1), 
(310, 8, 1), 
(310, 8, 1), 
(300, 8, 1), 
(290, 8, 1), 
(280, 8, 1), 
(280, 8, 1);


-- Empresa 2 (Sensores 9-16 no Ambiente 2)
INSERT INTO regSensor (intensidadeLuz, fkSensor, fkAmbiente) VALUES
(450, 9, 2), 
(450, 9, 2), 
(460, 9, 2), 
(460, 9, 2),


(450, 10, 2), 
(450, 10, 2), 
(460, 10, 2), 
(460, 10, 2), 


(440, 11, 2), 
(440, 11, 2), 
(450, 11, 2), 
(450, 11, 2),


(440, 12, 2), 
(440, 12, 2), 
(450, 12, 2), 
(450, 12, 2),


(400, 13, 2), 
(400, 13, 2), 
(390, 13, 2), 
(390, 13, 2),


(400, 14, 2), 
(400, 14, 2), 
(390, 14, 2), 
(390, 14, 2),


(390, 15, 2), 
(390, 15, 2), 
(380, 15, 2), 
(380, 15, 2),


(390, 16, 2), 
(390, 16, 2), 
(380, 16, 2), 
(380, 16, 2);

-- Empresa 3 (Sensores 17-28 no Ambiente 3)
INSERT INTO regSensor (intensidadeLuz, fkSensor, fkAmbiente) VALUES
(370, 17, 3),
(370, 17, 3), 
(390, 17, 3),


(370, 18, 3), 
(370, 18, 3), 
(390, 18, 3),


(380, 19, 3), 
(380, 19, 3), 
(400, 19, 3),


(380, 20, 3), 
(380, 20, 3), 
(400, 20, 3),


(410, 21, 3), 
(410, 21, 3), 
(410, 21, 3),


(410, 22, 3), 
(410, 22, 3), 
(410, 22, 3),


(410, 23, 3), 
(410, 23, 3), 
(410, 23, 3),


(390, 24, 3), 
(390, 24, 3), 
(390, 24, 3),


(370, 25, 3), 
(370, 25, 3), 
(360, 25, 3),


(360, 26, 3), 
(360, 26, 3), 
(360, 26, 3),


(360, 27, 3), 
(360, 27, 3), 
(360, 27, 3),


(350, 28, 3), 
(350, 28, 3), 
(350, 28, 3);

-- Dados de cada empresa


-- ----------------------
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

-- view atualizada
CREATE VIEW empresa_sensor_ambiente AS
SELECT DISTINCT 
e.razaoSocial AS 'Nome da Empresa',
e.cnpj AS 'CNPJ',
e.cep AS 'CEP',
e.responsavel AS 'Responsável da empresa',
e.telefone AS 'Telefone para contato',
e.dtCadastro AS 'Data de Cadastro',
e.senha AS 'Senha da Empresa',
a.andar,
a.nome,
s.tagSensor AS 'Tag do Sensor'
FROM empresa e 
JOIN ambiente a ON e.idEmpresa = a.fkEmpresa
JOIN regSensor r ON a.idAmbiente = r.fkAmbiente
JOIN Sensor s ON s.idSensor = r.fkSensor;

/* Consultar dados da empresa e seus sensores da view empresa_sensor_ambiente */
select * from empresa_sensor_ambiente;
select * from dados_das_empresas;


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

-- select atualizado
SELECT 
    e.razaoSocial AS 'Nome da Empresa',
    e.responsavel AS 'Responsável',
    u.areaEmpresa AS 'Função do Usuário',
    u.email AS 'Email para contato',
    s.tagSensor AS 'Tag do Sensor',
    s.area AS 'Local do Sensor',
    s.idSensor AS 'ID Sensor'
FROM empresa e 
JOIN usuario u ON e.idEmpresa = u.fkOrganizacao
JOIN ambiente a ON a.fkEmpresa = e.idEmpresa
JOIN regSensor r ON r.fkAmbiente = a.idAmbiente
JOIN Sensor s ON s.idSensor = r.fkSensor
GROUP BY s.idSensor, e.razaoSocial, e.responsavel, u.areaEmpresa, u.email, s.tagSensor, s.area;


-- select atualizado
SELECT 
    e.razaoSocial AS 'Nome da Empresa',
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
FROM empresa e 
JOIN usuario u ON e.idEmpresa = u.fkOrganizacao
JOIN ambiente a ON e.idEmpresa = a.fkEmpresa      
JOIN regSensor r ON a.idAmbiente = r.fkAmbiente    
JOIN Sensor s ON r.fkSensor = s.idSensor        
ORDER BY e.idEmpresa, s.idSensor, r.dtHora;

SELECT nomeEmpresa AS Empresa, emailEmpresa AS Email, mensagem AS Mensagem
FROM mensagem;


-- SELECTS GERAIS BÁSICOS
SELECT * FROM empresa;
SELECT * FROM usuario;
SELECT * FROM mensagem;
SELECT * FROM ambiente;
SELECT * FROM Sensor;
SELECT * FROM regSensor;

-- Quantidade de ambientes na empresa
SELECT COUNT(fkEmpresa) AS quantidadeAmbientes FROM ambiente WHERE fkEmpresa = 1;

-- Nome dos ambientes e quantidade de sensores para cada ambiente
SELECT 
    a.nome, 
    COUNT(DISTINCT r.fkSensor) AS quantidadeSensores 
FROM ambiente a 
LEFT JOIN regSensor r ON a.idAmbiente = r.fkAmbiente 
WHERE a.fkEmpresa = 1 
GROUP BY a.nome;

-- Hora dos Registros desse ambiente e últimos registros de cada sensor
SELECT reg.idRegSensor, reg.fkSensor, reg.intensidadeLuz, MAX(reg.dtHora) AS dtRegistro 
	FROM regSensor AS reg
    JOIN Sensor ON idSensor = fkSensor 
    JOIN ambiente ON idAmbiente = fkAmbiente 
		WHERE ambiente.fkEmpresa = 1 AND reg.dtHora = (SELECT MAX(reg2.dtHora) FROM regSensor AS reg2 WHERE reg.fkSensor = reg2.fkSensor) 
			GROUP BY reg.intensidadeLuz, reg.fkSensor, reg.idRegSensor
            ORDER BY Max(dtHora) DESC;
            
UPDATE regSensor SET dtHora = '2025-12-02 20:05:00' WHERE idRegSensor = 1;
UPDATE regSensor SET dtHora = '2025-12-02 20:05:00' WHERE idRegSensor = 5;
UPDATE regSensor SET dtHora = '2025-12-02 20:05:00' WHERE idRegSensor = 10;
UPDATE regSensor SET dtHora = '2025-12-02 20:05:00' WHERE idRegSensor = 15;
UPDATE regSensor SET dtHora = '2025-12-02 20:05:00' WHERE idRegSensor = 20;
UPDATE regSensor SET dtHora = '2025-12-02 20:05:00' WHERE idRegSensor = 25;
UPDATE regSensor SET dtHora = '2025-12-02 20:05:00' WHERE idRegSensor = 30;
UPDATE regSensor SET dtHora = '2025-12-02 20:05:00' WHERE idRegSensor = 40;
UPDATE regSensor SET dtHora = '2025-12-02 20:05:00' WHERE idRegSensor = 45;
UPDATE regSensor SET dtHora = '2025-12-02 20:05:00' WHERE idRegSensor = 50;
UPDATE regSensor SET dtHora = '2025-12-02 20:05:00' WHERE idRegSensor = 55;
UPDATE regSensor SET dtHora = '2025-12-02 20:05:00' WHERE idRegSensor = 60;
UPDATE regSensor SET dtHora = '2025-12-02 20:05:00' WHERE idRegSensor = 65;
UPDATE regSensor SET dtHora = '2025-12-02 20:05:00' WHERE idRegSensor = 70;
UPDATE regSensor SET dtHora = '2025-12-02 20:05:00' WHERE idRegSensor = 75;
UPDATE regSensor SET dtHora = '2025-12-02 20:05:00' WHERE idRegSensor = 80;
UPDATE regSensor SET dtHora = '2025-12-02 20:05:00' WHERE idRegSensor = 85;
UPDATE regSensor SET dtHora = '2025-12-02 20:05:00' WHERE idRegSensor = 90;
UPDATE regSensor SET dtHora = '2025-12-02 20:05:00' WHERE idRegSensor = 95;