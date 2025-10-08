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
(1, 'XPTOtech', '12345678000190', '01001000', 'Maria Silva', '11987654321', '2025-01-15 10:30:00', 'senha123'),
(2, 'EcoBuzziness', '98765432000177', '04567890', 'João Pereira', '21999998888', '2025-02-10 14:00:00', 'empresa2025'),
(3, 'SeguroSP', '11223344000155', '30140071', 'Ana Lima', '31988887777', '2025-03-05 09:15:00', 'segura@456');


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
    codSensor CHAR(4),
    area VARCHAR(25),
    andar INT,
    fkEmpresa INT,
    CONSTRAINT fkSensorEmpresa FOREIGN KEY (fkEmpresa)
        REFERENCES empresa(idCliente)
);

INSERT INTO Sensor (codSensor, area, andar) VALUES
('AA01', 'Recepção', 1),
('BB01', 'Sala de Reuniões', 2),
('CC01', 'Sala de Projetos', 1),
('EE01', 'Escritório Principal', 3);

SELECT * FROM ensor;

UPDATE Sensor SET idCliente = 1 WHERE fkEmpresa = 1;
UPDATE Sensor SET idCliente = 2 WHERE fkEmpresa = 2;
UPDATE Sensor SET idCliente = 3 WHERE fkEmpresa = 3;


CREATE TABLE regSensor (
    idRegSensor INT,
    intensidadeLuz DECIMAL(4,1),
    fkSensor INT,
    CONSTRAINT pkRegSensor PRIMARY KEY (idRegSensor, fkSensor),
    CONSTRAINT fkRegSensor FOREIGN KEY (fkSensor)
        REFERENCES sensor(idSensor)
);


SELECT 
    e.razaoSocial AS 'Empresa',
    e.responsavel AS 'Responsável',
    u.areaEmpresa AS 'Área do Usuário',
    u.email AS 'Email do Usuário',
    s.codSensor AS 'Código do Sensor',
    s.area AS 'Local do Sensor',
    s.andar AS 'Andar',
    s.idSensor AS 'ID Sensor'
FROM empresa e
JOIN usuario u ON e.idCliente = u.fkEmpregado
JOIN sensor s ON e.idCliente = s.fkEmpresa
ORDER BY e.idCliente;





