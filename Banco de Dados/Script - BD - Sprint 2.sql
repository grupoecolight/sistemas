CREATE DATABASE Ecolight;

USE Ecolight;

CREATE TABLE empresa (
    idCliente INT PRIMARY KEY,
    razaoSocial VARCHAR(255),
    cnpj CHAR(14),
    cep CHAR(8),
    responsavel VARCHAR(255),
    fone CHAR(11),
    dtCadastro DATETIME,
    senha VARCHAR(45)
);

INSERT INTO empresa (idCliente, razaoSocial, cnpj, cep, responsavel, fone, dtCadastro, senha) VALUES
(1, 'XPTO Technology LTDA', '10276849534012', '01310000', 'Maria Silva', 11987654321, '2025-01-15 10:30:00', 'senha123'),
(2, 'Eco Buzziness LTDA', '40345976786543', '01310940', 'João Pereira', 11956433478, '2025-02-10 14:00:00', 'empresa2025'),
(3, 'Seguradora de veículos LTDA', '54367891235409', '01310200', 'Ana Lima', 11956422465, '2025-03-05 09:15:00', 'segura@456');


SELECT * FROM empresa;



CREATE TABLE usuario (
    idUsuario INT,
    areaEmpresa VARCHAR(45),
    email VARCHAR(255),
    senha VARCHAR(45),
    fkEmpregado INT,
    CONSTRAINT pkUsuario PRIMARY KEY (idUsuario, fkEmpregado),
    CONSTRAINT fkUsuarioEmpresa FOREIGN KEY (fkEmpregado)
        REFERENCES empresa(idCliente)
);

INSERT INTO usuario (idUsuario, areaEmpresa, email, senha, fkEmpregado) VALUES
(1, 'Administração', 'admin@empresa1.com', 'admin123', 1),
(2, 'Recursos Humanos', 'rh@empresa1.com', 'rh2025', 2),
(3, 'Gerência', 'gerente@empresa2.com', 'ger@XPTO', 3);

SELECT * FROM usuario;


-- Configuração das FK
UPDATE usuario SET fkEmpregado = 1 WHERE idUsuario = 1;
UPDATE usuario SET fkEmpregado = 2 WHERE idUsuario = 2;
UPDATE usuario SET fkEmpregado = 3 WHERE idUsuario = 3;
-- 


-- JOIN das FK com as PK
SELECT e.razaoSocial AS 'Nome da Empresa',
e.cnpj AS 'CNPJ',
e.cep AS 'CEP',
e.responsavel AS 'Responsavel da empresa',
e.fone AS 'Telefone para contato',
e.dtCadastro AS 'Data de Cadastro',
e.senha AS 'Senha da Empresa',
u.areaEmpresa AS 'Função do Usuario',
u.email AS 'Email para contato',
u.senha AS 'Senha do Usuario'
FROM empresa e JOIN usuario u
ON e.idCliente = u.fkEmpregado;

-- 
CREATE TABLE Sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    tagSensor CHAR(6),
    area VARCHAR(25),
    andar INT,
    fkEmpresa INT,
    CONSTRAINT fkSensorEmpresa FOREIGN KEY (fkEmpresa)
        REFERENCES empresa(idCliente)
);

-- Empresa 1
INSERT INTO Sensor (idSensor, tagSensor, area, andar, fkEmpresa) VALUES
(default, '01-NOR', 'Sala de reuniões', 2, 1),
(default, '02-NOR', 'Sala de reuniões', 2, 1),
(default, '03-NOR', 'Sala de reuniões', 2, 1),
(default, '04-NOR', 'Sala de reuniões', 2, 1),
(default, '01-SUL', 'Sala de reuniões', 2, 1),
(default, '02-SUL', 'Sala de reuniões', 2, 1),
(default, '03-SUL', 'Sala de reuniões', 2, 1),
(default, '04-SUL', 'Sala de reuniões', 2, 1);


-- Empresa 2
INSERT INTO Sensor (idSensor, tagSensor, area, andar, fkEmpresa) VALUES
(default, '01-LES', 'Sala de conferência', 7, 2),
(default, '02-LES', 'Sala de conferência', 7, 2),
(default, '03-LES', 'Sala de conferência', 7, 2),
(default, '04-LES', 'Sala de conferência', 7, 2),
(default, '01-OES', 'Sala de conferência', 7, 2),
(default, '02-OES', 'Sala de conferência', 7, 2),
(default, '03-OES', 'Sala de conferência', 7, 2),
(default, '04-OES', 'Sala de conferência', 7, 2);


-- Empresa 3
INSERT INTO Sensor (idSensor, tagSensor, area, andar, fkEmpresa) VALUES
(default, '01-OES', 'Recepção', 4, 3),
(default, '02-OES', 'Recepção', 4, 3),
(default, '03-OES', 'Recepção', 4, 3),
(default, '04-OES', 'Recepção', 4, 3),
(default, '01-SUL', 'Recepção', 4, 3),
(default, '02-SUL', 'Recepção', 4, 3),
(default, '03-SUL', 'Recepção', 4, 3),
(default, '04-SUL', 'Recepção', 4, 3),
(default, '01-LES', 'Recepção', 4, 3),
(default, '02-LES', 'Recepção', 4, 3),
(default, '03-LES', 'Recepção', 4, 3),
(default, '04-LES', 'Recepção', 4, 3);

SELECT * FROM Sensor;

UPDATE Sensor SET fkEmpresa = 1 WHERE idSensor = 1;
UPDATE Sensor SET fkEmpresa = 2 WHERE idSensor = 2;
UPDATE Sensor SET fkEmpresa = 3 WHERE idSensor = 3;

SELECT e.razaoSocial AS 'Nome da Empresa',
e.cnpj AS 'CNPJ',
e.cep AS 'CEP',
e.responsavel AS 'Responsavel da empresa',
e.fone AS 'Telefone para contato',
e.dtCadastro AS 'Data de Cadastro',
e.senha AS 'Senha da Empresa',
s.tagSensor AS 'Tag do Sensor',
s.area AS 'Setor onde está localizado',
s.andar AS 'Andar onde está localizado'
FROM empresa e JOIN Sensor s
ON e.idCliente = s.fkEmpresa; 


CREATE TABLE regSensor (
    idRegSensor INT,
    intensidadeLuz DECIMAL(3,1),
    fkSensor INT,
    dtHora DATETIME,
    CONSTRAINT pkRegSensor PRIMARY KEY (idRegSensor, fkSensor),
    CONSTRAINT fkRegSensor FOREIGN KEY (fkSensor)
        REFERENCES Sensor(idSensor)
);

-- Empresa 1
INSERT INTO regSensor VALUES
(1, 38.0, 1, '2025-01-25 16:45:00'),
(2, 38.0, 1, '2025-01-25 16:50:00'),
(3, 36.0, 1, '2025-01-25 16:55:00'),
(4, 36.0, 1, '2025-01-25 17:00:00'),
(5, 35.0, 1, '2025-01-25 17:05:00'),
(6, 33.0, 1, '2025-01-25 17:10:00'),
(7, 33.0, 1, '2025-01-25 17:15:00'),
(8, 32.0, 1, '2025-01-25 17:20:00');

-- Empresa 1
INSERT INTO regSensor VALUES
(9,  38.0, 2, '2025-01-25 16:45:00'),
(10, 38.0, 2, '2025-01-25 16:50:00'),
(11, 36.0, 2, '2025-01-25 16:55:00'),
(12, 36.0, 2, '2025-01-25 17:00:00'),
(13, 35.0, 2, '2025-01-25 17:05:00'),
(14, 33.0, 2, '2025-01-25 17:10:00'),
(15, 33.0, 2, '2025-01-25 17:15:00'),
(16, 32.0, 2, '2025-01-25 17:20:00');

-- Empresa 1
INSERT INTO regSensor VALUES
(17, 37.0, 3, '2025-01-25 16:45:00'),
(18, 37.0, 3, '2025-01-25 16:50:00'),
(19, 35.0, 3, '2025-01-25 16:55:00'),
(20, 35.0, 3, '2025-01-25 17:00:00'),
(21, 34.0, 3, '2025-01-25 17:05:00'),
(22, 32.0, 3, '2025-01-25 17:10:00'),
(23, 32.0, 3, '2025-01-25 17:15:00'),
(24, 31.0, 3, '2025-01-25 17:20:00'),

(25, 37.0, 4, '2025-01-25 16:45:00'),
(26, 37.0, 4, '2025-01-25 16:50:00'),
(27, 35.0, 4, '2025-01-25 16:55:00'),
(28, 35.0, 4, '2025-01-25 17:00:00'),
(29, 34.0, 4, '2025-01-25 17:05:00'),
(30, 32.0, 4, '2025-01-25 17:10:00'),
(31, 32.0, 4, '2025-01-25 17:15:00'),
(32, 31.0, 4, '2025-01-25 17:20:00'),

(33, 33.0, 5, '2025-01-25 16:45:00'),
(34, 33.0, 5, '2025-01-25 16:50:00'),
(35, 32.0, 5, '2025-01-25 16:55:00'),
(36, 32.0, 5, '2025-01-25 17:00:00'),
(37, 31.0, 5, '2025-01-25 17:05:00'),
(38, 30.0, 5, '2025-01-25 17:10:00'),
(39, 29.0, 5, '2025-01-25 17:15:00'),
(40, 29.0, 5, '2025-01-25 17:20:00'),

(41, 33.0, 6, '2025-01-25 16:45:00'),
(42, 33.0, 6, '2025-01-25 16:50:00'),
(43, 32.0, 6, '2025-01-25 16:55:00'),
(44, 32.0, 6, '2025-01-25 17:00:00'),
(45, 31.0, 6, '2025-01-25 17:05:00'),
(46, 30.0, 6, '2025-01-25 17:10:00'),
(47, 29.0, 6, '2025-01-25 17:15:00'),
(48, 29.0, 6, '2025-01-25 17:20:00'),

(49, 32.0, 7, '2025-01-25 16:45:00'),
(50, 32.0, 7, '2025-01-25 16:50:00'),
(51, 31.0, 7, '2025-01-25 16:55:00'),
(52, 31.0, 7, '2025-01-25 17:00:00'),
(53, 30.0, 7, '2025-01-25 17:05:00'),
(54, 29.0, 7, '2025-01-25 17:10:00'),
(55, 28.0, 7, '2025-01-25 17:15:00'),
(56, 28.0, 7, '2025-01-25 17:20:00'),

(57, 32.0, 8, '2025-01-25 16:45:00'),
(58, 32.0, 8, '2025-01-25 16:50:00'),
(59, 31.0, 8, '2025-01-25 16:55:00'),
(60, 31.0, 8, '2025-01-25 17:00:00'),
(61, 30.0, 8, '2025-01-25 17:05:00'),
(62, 29.0, 8, '2025-01-25 17:10:00'),
(63, 28.0, 8, '2025-01-25 17:15:00'),
(64, 28.0, 8, '2025-01-25 17:20:00');


-- Empresa 2
INSERT INTO regSensor VALUES
(1, 45.0, 9, '2025-02-15 11:30:00'),
(2, 45.0, 9, '2025-02-15 11:35:00'),
(3, 46.0, 9, '2025-02-15 11:40:00'),
(4, 46.0, 9, '2025-02-15 11:45:00');

-- Empresa 2
INSERT INTO regSensor VALUES
(1, 45.0, 10, '2025-02-15 11:30:00'),
(2, 45.0, 10, '2025-02-15 11:35:00'),
(3, 46.0, 10, '2025-02-15 11:40:00'),
(4, 46.0, 10, '2025-02-15 11:45:00'),

(1, 44.0, 11, '2025-02-15 11:30:00'),
(2, 44.0, 11, '2025-02-15 11:35:00'),
(3, 45.0, 11, '2025-02-15 11:40:00'),
(4, 45.0, 11, '2025-02-15 11:45:00'),

(1, 44.0, 12, '2025-02-15 11:30:00'),
(2, 44.0, 12, '2025-02-15 11:35:00'),
(3, 45.0, 12, '2025-02-15 11:40:00'),
(4, 45.0, 12, '2025-02-15 11:45:00');

-- Empresa 2
INSERT INTO regSensor VALUES
(1, 40.0, 13, '2025-02-15 11:30:00'),
(2, 40.0, 13, '2025-02-15 11:35:00'),
(3, 39.0, 13, '2025-02-15 11:40:00'),
(4, 39.0, 13, '2025-02-15 11:45:00'),

(1, 40.0, 14, '2025-02-15 11:30:00'),
(2, 40.0, 14, '2025-02-15 11:35:00'),
(3, 39.0, 14, '2025-02-15 11:40:00'),
(4, 39.0, 14, '2025-02-15 11:45:00'),

(1, 39.0, 15, '2025-02-15 11:30:00'),
(2, 39.0, 15, '2025-02-15 11:35:00'),
(3, 38.0, 15, '2025-02-15 11:40:00'),
(4, 38.0, 15, '2025-02-15 11:45:00'),

(1, 39.0, 16, '2025-02-15 11:30:00'),
(2, 39.0, 16, '2025-02-15 11:35:00'),
(3, 38.0, 16, '2025-02-15 11:40:00'),
(4, 38.0, 16, '2025-02-15 11:45:00');


-- Empresa 3
INSERT INTO regSensor VALUES
(1, 37.0, 17, '2025-03-07 14:20'),
(2, 37.0, 17, '2025-03-07 14:25'),
(3, 39.0, 17, '2025-03-07 14:30'),

(1, 37.0, 18, '2025-03-07 14:20'),
(2, 37.0, 18, '2025-03-07 14:25'),
(3, 39.0, 18, '2025-03-07 14:30'),

(1, 38.0, 19, '2025-03-07 14:20'),
(2, 38.0, 19, '2025-03-07 14:25'),
(3, 40.0, 19, '2025-03-07 14:30'),

(1, 38.0, 20, '2025-03-07 14:20'),
(2, 38.0, 20, '2025-03-07 14:25'),
(3, 40.0, 20, '2025-03-07 14:30'),

(1, 41.0, 21, '2025-03-07 14:20'),
(2, 41.0, 21, '2025-03-07 14:25'),
(3, 41.0, 21, '2025-03-07 14:30'),

(1, 41.0, 22, '2025-03-07 14:20'),
(2, 41.0, 22, '2025-03-07 14:25'),
(3, 41.0, 22, '2025-03-07 14:30'),

(1, 41.0, 23, '2025-03-07 14:20'),
(2, 41.0, 23, '2025-03-07 14:25'),
(3, 41.0, 23, '2025-03-07 14:30'),

(1, 39.0, 24, '2025-03-07 14:20'),
(2, 39.0, 24, '2025-03-07 14:25'),
(3, 39.0, 24, '2025-03-07 14:30'),

(1, 37.0, 25, '2025-03-07 14:20'),
(2, 37.0, 25, '2025-03-07 14:25'),
(3, 36.0, 25, '2025-03-07 14:30'),

(1, 36.0, 26, '2025-03-07 14:20'),
(2, 36.0, 26, '2025-03-07 14:25'),
(3, 36.0, 26, '2025-03-07 14:30'),

(1, 36.0, 27, '2025-03-07 14:20'),
(2, 36.0, 27, '2025-03-07 14:25'),
(3, 36.0, 27, '2025-03-07 14:30'),

(1, 35.0, 28, '2025-03-07 14:20'),
(2, 35.0, 28, '2025-03-07 14:25'),
(3, 35.0, 28, '2025-03-07 14:30');

select * from regSensor;



SELECT e.razaoSocial AS 'Nome da Empresa',
e.responsavel AS 'Responsável',
u.areaEmpresa AS 'Função do Usuario',
u.email AS 'Email para contato',
s.tagSensor AS 'Tag do Sensor',
s.area AS 'Local do Sensor',
s.andar AS 'Andar',
s.idSensor AS 'ID Sensor'
FROM empresa e JOIN usuario u 
ON e.idCliente = u.fkEmpregado
JOIN Sensor s ON e.idCliente = s.fkEmpresa
ORDER BY e.idCliente;

SELECT e.razaoSocial AS 'Nome da Empresa',
e.cnpj AS 'CNPJ',
e.cep AS 'CEP',
e.responsavel AS 'Responsável',
e.fone AS 'Telefone',
e.dtCadastro AS 'Data de Cadastro',
u.areaEmpresa AS 'Área do Usuário',
u.email AS 'E-mail do Usuário',
u.senha AS 'Senha do Usuário',
s.tagSensor AS 'Tag do Sensor',
s.area AS 'Local do Sensor',
s.andar AS 'Andar do Sensor',
r.intensidadeLuz AS 'Intensidade da Luz',
r.dtHora AS 'Data e Hora da Leitura'
FROM empresa e JOIN usuario u 
ON e.idCliente = u.fkEmpregado
JOIN Sensor s ON e.idCliente = s.fkEmpresa
LEFT JOIN regSensor r ON s.idSensor = r.fkSensor
ORDER BY e.idCliente, s.idSensor, r.dtHora;
