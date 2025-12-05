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
(default, 2, 'Berlim', 1),
(default, 2, 'Tokyo', 1),
(default, 2, 'Rio', 1),
(default, 2, 'São Paulo', 1),
(default, 2, 'Nova York', 1),
(default, 2, 'Gramado', 1);


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
-- INSERT INTO regSen sor (intensidadeLuz, fkSensor, fkAmbiente) VALUES
-- (380, 1, 1), 
-- (380, 1, 1), 
-- (360, 1, 1), 
-- (360, 1, 1), 
-- (350, 1, 1), 
-- (330, 1, 1), 
-- (330, 1, 1), 
-- (320, 1, 1),


-- (380, 2, 1), 
-- (380, 2, 1), 
-- (360, 2, 1), 
-- (360, 2, 1), 
-- (350, 2, 1), 
-- (330, 2, 1), 
-- (330, 2, 1), 
-- (320, 2, 1),


-- (370, 3, 1), 
-- (370, 3, 1), 
-- (350, 3, 1), 
-- (350, 3, 1), 
-- (340, 3, 1), 
-- (320, 3, 1), 
-- (320, 3, 1), 
-- (310, 3, 1),


-- (370, 4, 1), 
-- (370, 4, 1), 
-- (350, 4, 1), 
-- (350, 4, 1), 
-- (340, 4, 1), 
-- (320, 4, 1), 
-- (320, 4, 1), 
-- (310, 4, 1),


-- (330, 5, 1), 
-- (330, 5, 1), 
-- (320, 5, 1), 
-- (320, 5, 1), 
-- (310, 5, 1), 
-- (300, 5, 1), 
-- (290, 5, 1), 
-- (290, 5, 1),


-- (330, 6, 1), 
-- (330, 6, 1), 
-- (320, 6, 1), 
-- (320, 6, 1), 
-- (310, 6, 1), 
-- (300, 6, 1), 
-- (290, 6, 1), 
-- (290, 6, 1),


-- (320, 7, 1), 
-- (320, 7, 1), 
-- (310, 7, 1), 
-- (310, 7, 1), 
-- (300, 7, 1), 
-- (290, 7, 1), 
-- (280, 7, 1), 
-- (280, 7, 1),


-- (320, 8, 1), 
-- (320, 8, 1), 
-- (310, 8, 1), 
-- (310, 8, 1), 
-- (300, 8, 1), 
-- (290, 8, 1), 
-- (280, 8, 1), 
-- (280, 8, 1);


-- -- Empresa 2 (Sensores 9-16 no Ambiente 2)
-- INSERT INTO regSensor (intensidadeLuz, fkSensor, fkAmbiente) VALUES
-- (450, 9, 2), 
-- (450, 9, 2), 
-- (460, 9, 2), 
-- (460, 9, 2),


-- (450, 10, 2), 
-- (450, 10, 2), 
-- (460, 10, 2), 
-- (460, 10, 2), 


-- (440, 11, 2), 
-- (440, 11, 2), 
-- (450, 11, 2), 
-- (450, 11, 2),


-- (440, 12, 2), 
-- (440, 12, 2), 
-- (450, 12, 2), 
-- (450, 12, 2),


-- (400, 13, 2), 
-- (400, 13, 2), 
-- (390, 13, 2), 
-- (390, 13, 2),


-- (400, 14, 2), 
-- (400, 14, 2), 
-- (390, 14, 2), 
-- (390, 14, 2),


-- (390, 15, 2), 
-- (390, 15, 2), 
-- (380, 15, 2), 
-- (380, 15, 2),


-- (390, 16, 2), 
-- (390, 16, 2), 
-- (380, 16, 2), 
-- (380, 16, 2);

-- -- Empresa 3 (Sensores 17-28 no Ambiente 3)
-- INSERT INTO regSensor (intensidadeLuz, fkSensor, fkAmbiente) VALUES
-- (370, 17, 3),
-- (370, 17, 3), 
-- (390, 17, 3),


-- (370, 18, 3), 
-- (370, 18, 3), 
-- (390, 18, 3),


-- (380, 19, 3), 
-- (380, 19, 3), 
-- (400, 19, 3),


-- (380, 20, 3), 
-- (380, 20, 3), 
-- (400, 20, 3),


-- (410, 21, 3), 
-- (410, 21, 3), 
-- (410, 21, 3),


-- (410, 22, 3), 
-- (410, 22, 3), 
-- (410, 22, 3),


-- (410, 23, 3), 
-- (410, 23, 3), 
-- (410, 23, 3),


-- (390, 24, 3), 
-- (390, 24, 3), 
-- (390, 24, 3),


-- (370, 25, 3), 
-- (370, 25, 3), 
-- (360, 25, 3),


-- (360, 26, 3), 
-- (360, 26, 3), 
-- (360, 26, 3),


-- (360, 27, 3), 
-- (360, 27, 3), 
-- (360, 27, 3),


-- (350, 28, 3), 
-- (350, 28, 3), 
-- (350, 28, 3);

-- Dados de cada empresa


-- ----------------------
-- CREATE VIEW dados_das_empresas AS
-- SELECT e.razaoSocial AS 'Nome da Empresa',
-- e.cnpj AS 'CNPJ',
-- e.cep AS 'CEP',
-- e.responsavel AS 'Responsável da empresa',
-- e.telefone AS 'Telefone para contato',
-- e.dtCadastro AS 'Data de Cadastro',
-- e.senha AS 'Senha da Empresa',
-- u.areaEmpresa AS 'Função do Usuário',
-- u.email AS 'Email para contato',
-- u.senha AS 'Senha do Usuário'
-- FROM empresa e JOIN usuario u
-- ON e.idEmpresa = u.fkOrganizacao;

-- view atualizada
-- CREATE VIEW empresa_sensor_ambiente AS
-- SELECT DISTINCT 
-- e.razaoSocial AS 'Nome da Empresa',
-- e.cnpj AS 'CNPJ',
-- e.cep AS 'CEP',
-- e.responsavel AS 'Responsável da empresa',
-- e.telefone AS 'Telefone para contato',
-- e.dtCadastro AS 'Data de Cadastro',
-- e.senha AS 'Senha da Empresa',
-- a.andar,
-- a.nome,
-- s.tagSensor AS 'Tag do Sensor'
-- FROM empresa e 
-- JOIN ambiente a ON e.idEmpresa = a.fkEmpresa
-- JOIN regSensor r ON a.idAmbiente = r.fkAmbiente
-- JOIN Sensor s ON s.idSensor = r.fkSensor;

/* Consultar dados da empresa e seus sensores da view empresa_sensor_ambiente */
-- select * from empresa_sensor_ambiente;
-- select * from dados_das_empresas;


/*Consultar nome da empresa, andar, nome do ambiente e tag do sensor da view empresa_sensor_ambiente*/
-- select 'Nome da Empresa', andar, nome, 'Tag do Sensor' FROM empresa_sensor_ambiente;  


/* Consultar registros de cada sensor */
-- CREATE VIEW registro_sensor AS
-- Select e.razaoSocial as Empresa, a.nome as Ambiente ,intensidadeLuz as Lux, tagSensor as Sensor, dtHora as 'Data' 
-- FROM Sensor s JOIN regSensor r
-- on s.idSensor = r.fkSensor
-- JOIN ambiente a
-- on a.idAmbiente = s.fkAmbiente
-- JOIN empresa e
-- on e.idEmpresa = a.fkEmpresa;

/* Consultar registros de cada sensor e de cada empresa - View*/
-- select * from registro_sensor;

-- select atualizado
-- SELECT 
--     e.razaoSocial AS 'Nome da Empresa',
--     e.responsavel AS 'Responsável',
--     u.areaEmpresa AS 'Função do Usuário',
--     u.email AS 'Email para contato',
--     s.tagSensor AS 'Tag do Sensor',
--     s.area AS 'Local do Sensor',
--     s.idSensor AS 'ID Sensor'
-- FROM empresa e 
-- JOIN usuario u ON e.idEmpresa = u.fkOrganizacao
-- JOIN ambiente a ON a.fkEmpresa = e.idEmpresa
-- JOIN regSensor r ON r.fkAmbiente = a.idAmbiente
-- JOIN Sensor s ON s.idSensor = r.fkSensor
-- GROUP BY s.idSensor, e.razaoSocial, e.responsavel, u.areaEmpresa, u.email, s.tagSensor, s.area;


-- select atualizado
-- SELECT 
--     e.razaoSocial AS 'Nome da Empresa',
--     e.cnpj AS 'CNPJ',
--     e.cep AS 'CEP',
--     e.responsavel AS 'Responsável',
--     e.telefone AS 'Telefone',
--     e.dtCadastro AS 'Data de Cadastro',
--     u.areaEmpresa AS 'Área do Usuário',
--     u.email AS 'E-mail do Usuário',
--     u.senha AS 'Senha do Usuário',
--     s.tagSensor AS 'Tag do Sensor',
--     s.area AS 'Local do Sensor',
--     r.intensidadeLuz AS 'Intensidade da Luz',
--     r.dtHora AS 'Data e Hora da Leitura'
-- FROM empresa e 
-- JOIN usuario u ON e.idEmpresa = u.fkOrganizacao
-- JOIN ambiente a ON e.idEmpresa = a.fkEmpresa      
-- JOIN regSensor r ON a.idAmbiente = r.fkAmbiente    
-- JOIN Sensor s ON r.fkSensor = s.idSensor        
-- ORDER BY e.idEmpresa, s.idSensor, r.dtHora;

-- SELECT nomeEmpresa AS Empresa, emailEmpresa AS Email, mensagem AS Mensagem
-- FROM mensagem;


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
SELECT reg.idRegSensor, reg.fkAmbiente, reg.fkSensor, ambiente.nome, Sensor.tagSensor, reg.intensidadeLuz, MAX(reg.dtHora) AS dtRegistro 
	FROM regSensor AS reg
    JOIN Sensor ON idSensor = fkSensor 
    JOIN ambiente ON idAmbiente = fkAmbiente 
		WHERE ambiente.fkEmpresa = 1 AND reg.dtHora = (SELECT MAX(reg2.dtHora) FROM regSensor AS reg2 WHERE reg.fkSensor = reg2.fkSensor) 
			GROUP BY reg.intensidadeLuz, reg.fkSensor, reg.idRegSensor, fkAmbiente;
            
-- Últimos 10 Registros de cada Sensor SLA SLA SLA
SELECT fkSensor, intensidadeLuz, dtHora 
	FROM regSensor
	JOIN Sensor ON idSensor = fkSensor 
    JOIN ambiente ON idAmbiente = fkAmbiente 
 	   	WHERE dtHora < '2025-12-03 23:20:00' AND dtHora > '2025-12-03 18:20:00' AND fkEmpresa = 1; 

-- INSERT INTO regSensor (fkAmbiente,  fkSensor, intensidadeLuz, dtHora) VALUES 
-- 	(1, 1, 400, '2025-12-03 18:50:00'),
-- 	(1, 1, 440, '2025-12-03 18:51:00'),
-- 	(1, 1, 480, '2025-12-03 18:52:00'),
-- 	(1, 1, 520, '2025-12-03 18:53:00');
--             
-- INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES 
-- 	(1, 1, 340, '2025-12-03 19:00:00'),
-- 	(1, 2, 320, '2025-12-03 19:00:00'),
-- 	(1, 3, 310, '2025-12-03 19:00:00'),
-- 	(1, 4, 360, '2025-12-03 19:00:00'),
-- 	(1, 5, 260, '2025-12-03 19:00:00'),
-- 	(1, 6, 380, '2025-12-03 19:00:00'),
-- 	(1, 7, 390, '2025-12-03 19:00:00'),
-- 	(1, 8, 330, '2025-12-03 19:00:00'),
--     (2, 9, 400, '2025-12-03 19:05:00'),
--     (2, 10, 430, '2025-12-03 19:05:00'),
--     (2, 11, 420, '2025-12-03 19:05:00'),
--     (2, 12, 450, '2025-12-03 19:05:00'),
--     (2, 13, 410, '2025-12-03 19:05:00'),
--     (2, 14, 370, '2025-12-03 19:05:00'),
--     (2, 15, 360, '2025-12-03 19:05:00'),
--     (2, 16, 390, '2025-12-03 19:05:00'),
--     (3, 17, 340, '2025-12-03 19:10:00'),
--     (3, 18, 350, '2025-12-03 19:10:00'),
--     (3, 19, 360, '2025-12-03 19:10:00'),
--     (3, 20, 400, '2025-12-03 19:10:00'),
--     (3, 21, 400, '2025-12-03 19:10:00'),
--     (3, 22, 420, '2025-12-03 19:10:00'),
--     (3, 23, 410, '2025-12-03 19:10:00'),
--     (3, 24, 380, '2025-12-03 19:10:00'),
--     (3, 25, 440, '2025-12-03 19:10:00'),
--     (3, 26, 430, '2025-12-03 19:10:00'),
--     (3, 27, 420, '2025-12-03 19:10:00'),
--     (3, 28, 410, '2025-12-03 19:10:00');
--     
-- INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
-- (1, 1, 325, '2025-12-03 08:00:00'),
-- (1, 1, 350, '2025-12-03 08:10:00'),
-- (1, 1, 410, '2025-12-03 08:20:00'),
-- (1, 1, 390, '2025-12-03 08:30:00'),
-- (1, 1, 420, '2025-12-03 08:40:00'),
-- (1, 1, 455, '2025-12-03 08:50:00'),
-- (1, 1, 470, '2025-12-03 09:00:00'),
-- (1, 1, 480, '2025-12-03 09:10:00'),
-- (1, 1, 500, '2025-12-03 09:20:00'),
-- (1, 1, 520, '2025-12-03 09:30:00'),
-- (1, 1, 540, '2025-12-03 09:40:00'),
-- (1, 1, 560, '2025-12-03 09:50:00');

-- INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
-- (1, 2, 300, '2025-12-03 08:00:00'),
-- (1, 2, 315, '2025-12-03 08:10:00'),
-- (1, 2, 330, '2025-12-03 08:20:00'),
-- (1, 2, 340, '2025-12-03 08:30:00'),
-- (1, 2, 350, '2025-12-03 08:40:00'),
-- (1, 2, 365, '2025-12-03 08:50:00'),
-- (1, 2, 380, '2025-12-03 09:00:00'),
-- (1, 2, 395, '2025-12-03 09:10:00'),
-- (1, 2, 410, '2025-12-03 09:20:00'),
-- (1, 2, 420, '2025-12-03 09:30:00'),
-- (1, 2, 430, '2025-12-03 09:40:00'),
-- (1, 2, 450, '2025-12-03 09:50:00');

-- INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
-- (1, 3, 280, '2025-12-03 08:00:00'),
-- (1, 3, 295, '2025-12-03 08:10:00'),
-- (1, 3, 310, '2025-12-03 08:20:00'),
-- (1, 3, 320, '2025-12-03 08:30:00'),
-- (1, 3, 340, '2025-12-03 08:40:00'),
-- (1, 3, 355, '2025-12-03 08:50:00'),
-- (1, 3, 370, '2025-12-03 09:00:00'),
-- (1, 3, 385, '2025-12-03 09:10:00'),
-- (1, 3, 400, '2025-12-03 09:20:00'),
-- (1, 3, 420, '2025-12-03 09:30:00'),
-- (1, 3, 440, '2025-12-03 09:40:00'),
-- (1, 3, 465, '2025-12-03 09:50:00');

-- AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

-- SENSOR 1 (ambiente 1)
INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(1, 1, 512, '2025-12-03 08:00:00'),
(1, 1, 518, '2025-12-03 08:10:00'),
(1, 1, 525, '2025-12-03 08:20:00'),
(1, 1, 531, '2025-12-03 08:30:00'),
(1, 1, 528, '2025-12-03 08:40:00'),
(1, 1, 534, '2025-12-03 08:50:00'),
(1, 1, 540, '2025-12-03 09:00:00'),
(1, 1, 547, '2025-12-03 09:10:00'),
(1, 1, 552, '2025-12-03 09:20:00'),
(1, 1, 548, '2025-12-03 09:30:00'),
(1, 1, 555, '2025-12-03 09:40:00'),
(1, 1, 562, '2025-12-03 09:50:00');

-- SENSOR 2 (ambiente 1)
INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(1, 2, 601, '2025-12-03 08:00:00'),
(1, 2, 608, '2025-12-03 08:10:00'),
(1, 2, 615, '2025-12-03 08:20:00'),
(1, 2, 621, '2025-12-03 08:30:00'),
(1, 2, 618, '2025-12-03 08:40:00'),
(1, 2, 625, '2025-12-03 08:50:00'),
(1, 2, 632, '2025-12-03 09:00:00'),
(1, 2, 637, '2025-12-03 09:10:00'),
(1, 2, 641, '2025-12-03 09:20:00'),
(1, 2, 639, '2025-12-03 09:30:00'),
(1, 2, 645, '2025-12-03 09:40:00'),
(1, 2, 652, '2025-12-03 09:50:00');

-- SENSOR 3 (ambiente 1)
INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(1, 3, 420, '2025-12-03 08:00:00'),
(1, 3, 428, '2025-12-03 08:10:00'),
(1, 3, 432, '2025-12-03 08:20:00'),
(1, 3, 439, '2025-12-03 08:30:00'),
(1, 3, 445, '2025-12-03 08:40:00'),
(1, 3, 452, '2025-12-03 08:50:00'),
(1, 3, 458, '2025-12-03 09:00:00'),
(1, 3, 463, '2025-12-03 09:10:00'),
(1, 3, 470, '2025-12-03 09:20:00'),
(1, 3, 468, '2025-12-03 09:30:00'),
(1, 3, 474, '2025-12-03 09:40:00'),
(1, 3, 481, '2025-12-03 09:50:00');

-- SENSOR 4 (ambiente 1)
INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(1, 4, 700, '2025-12-03 08:00:00'),
(1, 4, 708, '2025-12-03 08:10:00'),
(1, 4, 715, '2025-12-03 08:20:00'),
(1, 4, 722, '2025-12-03 08:30:00'),
(1, 4, 719, '2025-12-03 08:40:00'),
(1, 4, 727, '2025-12-03 08:50:00'),
(1, 4, 733, '2025-12-03 09:00:00'),
(1, 4, 739, '2025-12-03 09:10:00'),
(1, 4, 745, '2025-12-03 09:20:00'),
(1, 4, 742, '2025-12-03 09:30:00'),
(1, 4, 749, '2025-12-03 09:40:00'),
(1, 4, 756, '2025-12-03 09:50:00');

-- SENSOR 5 (ambiente 1)
INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(1, 5, 300, '2025-12-03 08:00:00'),
(1, 5, 308, '2025-12-03 08:10:00'),
(1, 5, 315, '2025-12-03 08:20:00'),
(1, 5, 322, '2025-12-03 08:30:00'),
(1, 5, 319, '2025-12-03 08:40:00'),
(1, 5, 328, '2025-12-03 08:50:00'),
(1, 5, 333, '2025-12-03 09:00:00'),
(1, 5, 339, '2025-12-03 09:10:00'),
(1, 5, 344, '2025-12-03 09:20:00'),
(1, 5, 341, '2025-12-03 09:30:00'),
(1, 5, 348, '2025-12-03 09:40:00'),
(1, 5, 354, '2025-12-03 09:50:00');

-- SENSOR 6 (ambiente 1)
INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(1, 6, 520, '2025-12-03 08:00:00'),
(1, 6, 528, '2025-12-03 08:10:00'),
(1, 6, 535, '2025-12-03 08:20:00'),
(1, 6, 541, '2025-12-03 08:30:00'),
(1, 6, 538, '2025-12-03 08:40:00'),
(1, 6, 545, '2025-12-03 08:50:00'),
(1, 6, 552, '2025-12-03 09:00:00'),
(1, 6, 557, '2025-12-03 09:10:00'),
(1, 6, 563, '2025-12-03 09:20:00'),
(1, 6, 559, '2025-12-03 09:30:00'),
(1, 6, 566, '2025-12-03 09:40:00'),
(1, 6, 572, '2025-12-03 09:50:00');

-- SENSOR 7 (ambiente 1)
INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(1, 7, 430, '2025-12-03 08:00:00'),
(1, 7, 437, '2025-12-03 08:10:00'),
(1, 7, 444, '2025-12-03 08:20:00'),
(1, 7, 452, '2025-12-03 08:30:00'),
(1, 7, 447, '2025-12-03 08:40:00'),
(1, 7, 454, '2025-12-03 08:50:00'),
(1, 7, 461, '2025-12-03 09:00:00'),
(1, 7, 467, '2025-12-03 09:10:00'),
(1, 7, 473, '2025-12-03 09:20:00'),
(1, 7, 469, '2025-12-03 09:30:00'),
(1, 7, 476, '2025-12-03 09:40:00'),
(1, 7, 482, '2025-12-03 09:50:00');

-- SENSOR 8 (ambiente 1)
INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(1, 8, 380, '2025-12-03 08:00:00'),
(1, 8, 388, '2025-12-03 08:10:00'),
(1, 8, 395, '2025-12-03 08:20:00'),
(1, 8, 402, '2025-12-03 08:30:00'),
(1, 8, 398, '2025-12-03 08:40:00'),
(1, 8, 406, '2025-12-03 08:50:00'),
(1, 8, 413, '2025-12-03 09:00:00'),
(1, 8, 418, '2025-12-03 09:10:00'),
(1, 8, 425, '2025-12-03 09:20:00'),
(1, 8, 421, '2025-12-03 09:30:00'),
(1, 8, 428, '2025-12-03 09:40:00'),
(1, 8, 434, '2025-12-03 09:50:00');

---------------------------------------------------------
-- AMBIENTE 2 — Sensores 9 a 16
---------------------------------------------------------

-- SENSOR 9 (ambiente 2)
INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(2, 9, 510, '2025-12-03 08:00:00'),
(2, 9, 516, '2025-12-03 08:10:00'),
(2, 9, 523, '2025-12-03 08:20:00'),
(2, 9, 529, '2025-12-03 08:30:00'),
(2, 9, 526, '2025-12-03 08:40:00'),
(2, 9, 533, '2025-12-03 08:50:00'),
(2, 9, 539, '2025-12-03 09:00:00'),
(2, 9, 545, '2025-12-03 09:10:00'),
(2, 9, 551, '2025-12-03 09:20:00'),
(2, 9, 548, '2025-12-03 09:30:00'),
(2, 9, 553, '2025-12-03 09:40:00'),
(2, 9, 560, '2025-12-03 09:50:00');

-- SENSOR 10 (ambiente 2)
INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(2, 10, 620, '2025-12-03 08:00:00'),
(2, 10, 627, '2025-12-03 08:10:00'),
(2, 10, 634, '2025-12-03 08:20:00'),
(2, 10, 641, '2025-12-03 08:30:00'),
(2, 10, 639, '2025-12-03 08:40:00'),
(2, 10, 646, '2025-12-03 08:50:00'),
(2, 10, 652, '2025-12-03 09:00:00'),
(2, 10, 658, '2025-12-03 09:10:00'),
(2, 10, 664, '2025-12-03 09:20:00'),
(2, 10, 661, '2025-12-03 09:30:00'),
(2, 10, 668, '2025-12-03 09:40:00'),
(2, 10, 675, '2025-12-03 09:50:00');

-- SENSOR 11 (ambiente 2)
INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(2, 11, 430, '2025-12-03 08:00:00'),
(2, 11, 437, '2025-12-03 08:10:00'),
(2, 11, 443, '2025-12-03 08:20:00'),
(2, 11, 449, '2025-12-03 08:30:00'),
(2, 11, 446, '2025-12-03 08:40:00'),
(2, 11, 454, '2025-12-03 08:50:00'),
(2, 11, 460, '2025-12-03 09:00:00'),
(2, 11, 466, '2025-12-03 09:10:00'),
(2, 11, 472, '2025-12-03 09:20:00'),
(2, 11, 469, '2025-12-03 09:30:00'),
(2, 11, 475, '2025-12-03 09:40:00'),
(2, 11, 482, '2025-12-03 09:50:00');

-- SENSOR 12 (ambiente 2)
INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(2, 12, 320, '2025-12-03 08:00:00'),
(2, 12, 327, '2025-12-03 08:10:00'),
(2, 12, 334, '2025-12-03 08:20:00'),
(2, 12, 339, '2025-12-03 08:30:00'),
(2, 12, 336, '2025-12-03 08:40:00'),
(2, 12, 343, '2025-12-03 08:50:00'),
(2, 12, 349, '2025-12-03 09:00:00'),
(2, 12, 355, '2025-12-03 09:10:00'),
(2, 12, 361, '2025-12-03 09:20:00'),
(2, 12, 358, '2025-12-03 09:30:00'),
(2, 12, 365, '2025-12-03 09:40:00'),
(2, 12, 372, '2025-12-03 09:50:00');

-- SENSOR 13 (ambiente 2)
INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(2, 13, 540, '2025-12-03 08:00:00'),
(2, 13, 547, '2025-12-03 08:10:00'),
(2, 13, 553, '2025-12-03 08:20:00'),
(2, 13, 559, '2025-12-03 08:30:00'),
(2, 13, 556, '2025-12-03 08:40:00'),
(2, 13, 563, '2025-12-03 08:50:00'),
(2, 13, 569, '2025-12-03 09:00:00'),
(2, 13, 575, '2025-12-03 09:10:00'),
(2, 13, 582, '2025-12-03 09:20:00'),
(2, 13, 579, '2025-12-03 09:30:00'),
(2, 13, 585, '2025-12-03 09:40:00'),
(2, 13, 591, '2025-12-03 09:50:00');

-- SENSOR 14 (ambiente 2)
INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(2, 14, 610, '2025-12-03 08:00:00'),
(2, 14, 617, '2025-12-03 08:10:00'),
(2, 14, 623, '2025-12-03 08:20:00'),
(2, 14, 629, '2025-12-03 08:30:00'),
(2, 14, 626, '2025-12-03 08:40:00'),
(2, 14, 633, '2025-12-03 08:50:00'),
(2, 14, 639, '2025-12-03 09:00:00'),
(2, 14, 645, '2025-12-03 09:10:00'),
(2, 14, 651, '2025-12-03 09:20:00'),
(2, 14, 648, '2025-12-03 09:30:00'),
(2, 14, 654, '2025-12-03 09:40:00'),
(2, 14, 661, '2025-12-03 09:50:00');

-- SENSOR 15 (ambiente 2)
INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(2, 15, 470, '2025-12-03 08:00:00'),
(2, 15, 476, '2025-12-03 08:10:00'),
(2, 15, 483, '2025-12-03 08:20:00'),
(2, 15, 489, '2025-12-03 08:30:00'),
(2, 15, 486, '2025-12-03 08:40:00'),
(2, 15, 492, '2025-12-03 08:50:00'),
(2, 15, 498, '2025-12-03 09:00:00'),
(2, 15, 505, '2025-12-03 09:10:00'),
(2, 15, 510, '2025-12-03 09:20:00'),
(2, 15, 507, '2025-12-03 09:30:00'),
(2, 15, 513, '2025-12-03 09:40:00'),
(2, 15, 520, '2025-12-03 09:50:00');

-- SENSOR 16 (ambiente 2)
INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(2, 16, 390, '2025-12-03 08:00:00'),
(2, 16, 398, '2025-12-03 08:10:00'),
(2, 16, 405, '2025-12-03 08:20:00'),
(2, 16, 412, '2025-12-03 08:30:00'),
(2, 16, 408, '2025-12-03 08:40:00'),
(2, 16, 416, '2025-12-03 08:50:00'),
(2, 16, 423, '2025-12-03 09:00:00'),
(2, 16, 428, '2025-12-03 09:10:00'),
(2, 16, 435, '2025-12-03 09:20:00'),
(2, 16, 431, '2025-12-03 09:30:00'),
(2, 16, 438, '2025-12-03 09:40:00'),
(2, 16, 445, '2025-12-03 09:50:00');

---------------------------------------------------------
-- AMBIENTE 3 — Sensores 17 a 28
---------------------------------------------------------

-- SENSOR 17 (ambiente 3)
INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(3, 17, 580, '2025-12-03 08:00:00'),
(3, 17, 586, '2025-12-03 08:10:00'),
(3, 17, 593, '2025-12-03 08:20:00'),
(3, 17, 600, '2025-12-03 08:30:00'),
(3, 17, 597, '2025-12-03 08:40:00'),
(3, 17, 603, '2025-12-03 08:50:00'),
(3, 17, 609, '2025-12-03 09:00:00'),
(3, 17, 615, '2025-12-03 09:10:00'),
(3, 17, 621, '2025-12-03 09:20:00'),
(3, 17, 618, '2025-12-03 09:30:00'),
(3, 17, 624, '2025-12-03 09:40:00'),
(3, 17, 631, '2025-12-03 09:50:00');

-- SENSOR 18 (ambiente 3)
INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(3, 18, 460, '2025-12-03 08:00:00'),
(3, 18, 468, '2025-12-03 08:10:00'),
(3, 18, 474, '2025-12-03 08:20:00'),
(3, 18, 480, '2025-12-03 08:30:00'),
(3, 18, 476, '2025-12-03 08:40:00'),
(3, 18, 483, '2025-12-03 08:50:00'),
(3, 18, 490, '2025-12-03 09:00:00'),
(3, 18, 495, '2025-12-03 09:10:00'),
(3, 18, 502, '2025-12-03 09:20:00'),
(3, 18, 499, '2025-12-03 09:30:00'),
(3, 18, 505, '2025-12-03 09:40:00'),
(3, 18, 512, '2025-12-03 09:50:00');

-- SENSOR 19 (ambiente 3)
INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(3, 19, 350, '2025-12-03 08:00:00'),
(3, 19, 358, '2025-12-03 08:10:00'),
(3, 19, 365, '2025-12-03 08:20:00'),
(3, 19, 372, '2025-12-03 08:30:00'),
(3, 19, 368, '2025-12-03 08:40:00'),
(3, 19, 375, '2025-12-03 08:50:00'),
(3, 19, 381, '2025-12-03 09:00:00'),
(3, 19, 387, '2025-12-03 09:10:00'),
(3, 19, 393, '2025-12-03 09:20:00'),
(3, 19, 390, '2025-12-03 09:30:00'),
(3, 19, 396, '2025-12-03 09:40:00'),
(3, 19, 402, '2025-12-03 09:50:00');

-- SENSOR 20 (ambiente 3)
INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(3, 20, 490, '2025-12-03 08:00:00'),
(3, 20, 498, '2025-12-03 08:10:00'),
(3, 20, 505, '2025-12-03 08:20:00'),
(3, 20, 512, '2025-12-03 08:30:00'),
(3, 20, 509, '2025-12-03 08:40:00'),
(3, 20, 517, '2025-12-03 08:50:00'),
(3, 20, 523, '2025-12-03 09:00:00'),
(3, 20, 529, '2025-12-03 09:10:00'),
(3, 20, 536, '2025-12-03 09:20:00'),
(3, 20, 532, '2025-12-03 09:30:00'),
(3, 20, 538, '2025-12-03 09:40:00'),
(3, 20, 545, '2025-12-03 09:50:00');

-- SENSOR 21 (ambiente 3)
INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(3, 21, 330, '2025-12-03 08:00:00'),
(3, 21, 338, '2025-12-03 08:10:00'),
(3, 21, 344, '2025-12-03 08:20:00'),
(3, 21, 351, '2025-12-03 08:30:00'),
(3, 21, 347, '2025-12-03 08:40:00'),
(3, 21, 354, '2025-12-03 08:50:00'),
(3, 21, 361, '2025-12-03 09:00:00'),
(3, 21, 366, '2025-12-03 09:10:00'),
(3, 21, 373, '2025-12-03 09:20:00'),
(3, 21, 369, '2025-12-03 09:30:00'),
(3, 21, 376, '2025-12-03 09:40:00'),
(3, 21, 383, '2025-12-03 09:50:00');

-- SENSOR 22 (ambiente 3)
INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(3, 22, 750, '2025-12-03 08:00:00'),
(3, 22, 758, '2025-12-03 08:10:00'),
(3, 22, 765, '2025-12-03 08:20:00'),
(3, 22, 772, '2025-12-03 08:30:00'),
(3, 22, 769, '2025-12-03 08:40:00'),
(3, 22, 776, '2025-12-03 08:50:00'),
(3, 22, 782, '2025-12-03 09:00:00'),
(3, 22, 788, '2025-12-03 09:10:00'),
(3, 22, 795, '2025-12-03 09:20:00'),
(3, 22, 792, '2025-12-03 09:30:00'),
(3, 22, 799, '2025-12-03 09:40:00'),
(3, 22, 806, '2025-12-03 09:50:00');

-- SENSOR 23 (ambiente 3)
INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(3, 23, 370, '2025-12-03 08:00:00'),
(3, 23, 377, '2025-12-03 08:10:00'),
(3, 23, 384, '2025-12-03 08:20:00'),
(3, 23, 389, '2025-12-03 08:30:00'),
(3, 23, 386, '2025-12-03 08:40:00'),
(3, 23, 392, '2025-12-03 08:50:00'),
(3, 23, 398, '2025-12-03 09:00:00'),
(3, 23, 404, '2025-12-03 09:10:00'),
(3, 23, 410, '2025-12-03 09:20:00'),
(3, 23, 407, '2025-12-03 09:30:00'),
(3, 23, 413, '2025-12-03 09:40:00'),
(3, 23, 420, '2025-12-03 09:50:00');

-- SENSOR 24 (ambiente 3)
INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(3, 24, 450, '2025-12-03 08:00:00'),
(3, 24, 458, '2025-12-03 08:10:00'),
(3, 24, 465, '2025-12-03 08:20:00'),
(3, 24, 472, '2025-12-03 08:30:00'),
(3, 24, 468, '2025-12-03 08:40:00'),
(3, 24, 475, '2025-12-03 08:50:00'),
(3, 24, 482, '2025-12-03 09:00:00'),
(3, 24, 488, '2025-12-03 09:10:00'),
(3, 24, 493, '2025-12-03 09:20:00'),
(3, 24, 490, '2025-12-03 09:30:00'),
(3, 24, 498, '2025-12-03 09:40:00'),
(3, 24, 504, '2025-12-03 09:50:00');

-- SENSOR 25 (ambiente 3)
INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(3, 25, 520, '2025-12-03 08:00:00'),
(3, 25, 528, '2025-12-03 08:10:00'),
(3, 25, 535, '2025-12-03 08:20:00'),
(3, 25, 542, '2025-12-03 08:30:00'),
(3, 25, 539, '2025-12-03 08:40:00'),
(3, 25, 546, '2025-12-03 08:50:00'),
(3, 25, 552, '2025-12-03 09:00:00'),
(3, 25, 558, '2025-12-03 09:10:00'),
(3, 25, 564, '2025-12-03 09:20:00'),
(3, 25, 560, '2025-12-03 09:30:00'),
(3, 25, 567, '2025-12-03 09:40:00'),
(3, 25, 573, '2025-12-03 09:50:00');

-- SENSOR 26 (ambiente 3)
INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(3, 26, 310, '2025-12-03 08:00:00'),
(3, 26, 318, '2025-12-03 08:10:00'),
(3, 26, 323, '2025-12-03 08:20:00'),
(3, 26, 329, '2025-12-03 08:30:00'),
(3, 26, 325, '2025-12-03 08:40:00'),
(3, 26, 332, '2025-12-03 08:50:00'),
(3, 26, 338, '2025-12-03 09:00:00'),
(3, 26, 343, '2025-12-03 09:10:00'),
(3, 26, 349, '2025-12-03 09:20:00'),
(3, 26, 346, '2025-12-03 09:30:00'),
(3, 26, 353, '2025-12-03 09:40:00'),
(3, 26, 359, '2025-12-03 09:50:00');

-- SENSOR 27 (ambiente 3)
INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(3, 27, 420, '2025-12-03 08:00:00'),
(3, 27, 428, '2025-12-03 08:10:00'),
(3, 27, 435, '2025-12-03 08:20:00'),
(3, 27, 441, '2025-12-03 08:30:00'),
(3, 27, 438, '2025-12-03 08:40:00'),
(3, 27, 445, '2025-12-03 08:50:00'),
(3, 27, 451, '2025-12-03 09:00:00'),
(3, 27, 457, '2025-12-03 09:10:00'),
(3, 27, 463, '2025-12-03 09:20:00'),
(3, 27, 460, '2025-12-03 09:30:00'),
(3, 27, 466, '2025-12-03 09:40:00'),
(3, 27, 473, '2025-12-03 09:50:00');

-- SENSOR 28 (ambiente 3)
INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(3, 28, 550, '2025-12-03 08:00:00'),
(3, 28, 557, '2025-12-03 08:10:00'),
(3, 28, 565, '2025-12-03 08:20:00'),
(3, 28, 571, '2025-12-03 08:30:00'),
(3, 28, 568, '2025-12-03 08:40:00'),
(3, 28, 575, '2025-12-03 08:50:00'),
(3, 28, 582, '2025-12-03 09:00:00'),
(3, 28, 587, '2025-12-03 09:10:00'),
(3, 28, 594, '2025-12-03 09:20:00'),
(3, 28, 590, '2025-12-03 09:30:00'),
(3, 28, 597, '2025-12-03 09:40:00'),
(3, 28, 603, '2025-12-03 09:50:00');

