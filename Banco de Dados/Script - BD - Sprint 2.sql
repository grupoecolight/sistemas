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

INSERT INTO empresa (razaoSocial, cnpj, cep, responsavel, telefone, dtCadastro, senha) VALUES
('XPTO Technology LTDA', '10276849534012', '01310000', 'Maria Silva', 11987654321, '2025-01-15 10:30:00', 'senha123'),
('Eco Buzziness LTDA', '40345976786543', '01310940', 'João Pereira', 11956433478, '2025-02-10 14:00:00', 'empresa2025'),
('Seguradora de veículos LTDA', '54367891235409', '01310200', 'Ana Lima', 11956422465, '2025-03-05 09:15:00', 'segura@456');


SELECT * FROM empresa;


CREATE TABLE mensagem (
idMensagem INT PRIMARY KEY AUTO_INCREMENT,
nomeEmpresa VARCHAR (45),
emailEmpresa VARCHAR (255),
nomeRepresentante VARCHAR (45),
contatoTel CHAR(11),
mensagem VARCHAR(500)
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


INSERT INTO usuario (areaEmpresa, email, senha, fkOrganizacao, userAdmin) VALUES
('Administração', 'admin@empresa1.com', 'admin123', 1, 0),
('Recursos Humanos', 'rh@empresa1.com', 'rh2025', 2, 1),
('Gerência', 'gerente@empresa2.com', 'ger@XPTO', 3, 0);

SELECT * FROM usuario;


-- Configuração das FK
-- UPDATE usuario SET fkOrganizacao = 1 WHERE idUsuario = 1;
-- UPDATE usuario SET fkOrganizacao = 2 WHERE idUsuario = 2;
-- UPDATE usuario SET fkOrganizacao = 3 WHERE idUsuario = 3;


-- JOIN das FK com as PK
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

-- 
CREATE TABLE Sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    tagSensor CHAR(7),
    area VARCHAR(25),
    fkEmpresa INT,
    CONSTRAINT fkSensorEmpresa FOREIGN KEY (fkEmpresa)
        REFERENCES empresa(idEmpresa)
);

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

SELECT * FROM Sensor;

-- UPDATE Sensor SET fkEmpresa = 1 WHERE idSensor = 1;
-- UPDATE Sensor SET fkEmpresa = 2 WHERE idSensor = 2;
-- UPDATE Sensor SET fkEmpresa = 3 WHERE idSensor = 3;

SELECT e.razaoSocial AS 'Nome da Empresa',
e.cnpj AS 'CNPJ',
e.cep AS 'CEP',
e.responsavel AS 'Responsável da empresa',
e.telefone AS 'Telefone para contato',
e.dtCadastro AS 'Data de Cadastro',
e.senha AS 'Senha da Empresa',
s.tagSensor AS 'Tag do Sensor',
s.area AS 'Setor onde está localizado'
FROM empresa e JOIN Sensor s
ON e.idEmpresa = s.fkEmpresa; 


CREATE TABLE regSensor (
    idRegSensor INT AUTO_INCREMENT,
    intensidadeLuz DECIMAL(3,1),
    fkSensor INT,
    dtHora DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pkRegSensor PRIMARY KEY (idRegSensor, fkSensor),
    CONSTRAINT fkRegSensor FOREIGN KEY (fkSensor)
        REFERENCES Sensor(idSensor)
);

-- Empresa 1
INSERT INTO regSensor (intensidadeLuz, fkSensor) VALUES
(38.0, 1),
(38.0, 1),
(36.0, 1),
(36.0, 1),
(35.0, 1),
(33.0, 1),
(33.0, 1),
(32.0, 1);

-- Empresa 1
INSERT INTO regSensor (intensidadeLuz, fkSensor) VALUES
(38.0, 2),
(38.0, 2),
(36.0, 2),
(36.0, 2),
(35.0, 2),
(33.0, 2),
(33.0, 2),
(32.0, 2);

-- Empresa 1
INSERT INTO regSensor (intensidadeLuz, fkSensor) VALUES
(37.0, 3),
(37.0, 3),
(35.0, 3),
(35.0, 3),
(34.0, 3),
(32.0, 3),
(32.0, 3),
(31.0, 3),

(37.0, 4),
(37.0, 4),
(35.0, 4),
(35.0, 4),
(34.0, 4),
(32.0, 4),
(32.0, 4),
(31.0, 4),

(33.0, 5),
(33.0, 5),
(32.0, 5),
(32.0, 5),
(31.0, 5),
(30.0, 5),
(29.0, 5),
(29.0, 5),

(33.0, 6),
(33.0, 6),
(32.0, 6),
(32.0, 6),
(31.0, 6),
(30.0, 6),
(29.0, 6),
(29.0, 6),

(32.0, 7),
(32.0, 7),
(31.0, 7),
(31.0, 7),
(30.0, 7),
(29.0, 7),
(28.0, 7),
(28.0, 7),

(32.0, 8),
(32.0, 8),
(31.0, 8),
(31.0, 8),
(30.0, 8),
(29.0, 8),
(28.0, 8),
(28.0, 8);


-- Empresa 2
INSERT INTO regSensor (intensidadeLuz, fkSensor) VALUES
(45.0, 9),
(45.0, 9),
(46.0, 9),
(46.0, 9);

-- Empresa 2
INSERT INTO regSensor (intensidadeLuz, fkSensor) VALUES
(45.0, 10),
(45.0, 10),
(46.0, 10),
(46.0, 10),

(44.0, 11),
(44.0, 11),
(45.0, 11),
(45.0, 11),

(44.0, 12),
(44.0, 12),
(45.0, 12),
(45.0, 12);

-- Empresa 2
INSERT INTO regSensor (intensidadeLuz, fkSensor) VALUES
(40.0, 13),
(40.0, 13),
(39.0, 13),
(39.0, 13),

(40.0, 14),
(40.0, 14),
(39.0, 14),
(39.0, 14),

(39.0, 15),
(39.0, 15),
(38.0, 15),
(38.0, 15),

(39.0, 16),
(39.0, 16),
(38.0, 16),
(38.0, 16);


-- Empresa 3
INSERT INTO regSensor (intensidadeLuz, fkSensor) VALUES
(37.0, 17),
(37.0, 17),
(39.0, 17),

(37.0, 18),
(37.0, 18),
(39.0, 18),

(38.0, 19),
(38.0, 19),
(40.0, 19),

(38.0, 20),
(38.0, 20),
(40.0, 20),

(41.0, 21),
(41.0, 21),
(41.0, 21),

(41.0, 22),
(41.0, 22),
(41.0, 22),

(41.0, 23),
(41.0, 23),
(41.0, 23),

(39.0, 24),
(39.0, 24),
(39.0, 24),

(37.0, 25),
(37.0, 25),
(36.0, 25),

(36.0, 26),
(36.0, 26),
(36.0, 26),

(36.0, 27),
(36.0, 27),
(36.0, 27),

(35.0, 28),
(35.0, 28),
(35.0, 28);

select * from regSensor;



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
