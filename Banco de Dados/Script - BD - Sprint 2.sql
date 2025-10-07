CREATE DATABASE Ecolight;

USE Ecolight;

CREATE TABLE empresa (
    idCliente INT PRIMARY KEY AUTO_INCREMENT,
    razaoSocial VARCHAR(255),
    cnpj CHAR(14),
    cep CHAR(8),
    responsavel VARCHAR(255),
    fone INT,
    dtCadastro DATETIME,
    senha VARCHAR(45)
);

INSERT INTO empresa (razaoSocial, cnpj, cep, responsavel, fone, dtCadastro, senha) VALUES
('XPTOtech', '12345678000190', '01001000', 'Maria Silva', '1198765432', '2025-01-15 10:30:00', 'senha123'),
('EcoBuzziness', '98765432000177', '04567890', 'João Pereira', '21999998888', '2025-02-10 14:00:00', 'empresa2025'),
('SeguroSP', '11223344000155', '30140071', 'Ana Lima', '31988887777', '2025-03-05 09:15:00', 'segura@456');






CREATE TABLE usuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    areaEmpresa VARCHAR(45),
    email VARCHAR(255),
    senha VARCHAR(45),
    fkEmpregado INT,
    CONSTRAINT fkUsuarioEmpresa FOREIGN KEY (fkEmpregado)
        REFERENCES empresa(idCliente)
);

INSERT INTO usuario (areaEmpresa, email, senha) VALUES
('Administração', 'admin@empresa1.com', 'admin123'),
('Recursos Humanos', 'rh@empresa1.com', 'rh2025'),
('Gerência', 'gerente@empresa2.com', 'ger@XPTO');






CREATE TABLE regSensor (
    idRegSensor INT PRIMARY KEY AUTO_INCREMENT,
    intensidadeLuz DECIMAL(4,1),
    fkSensor INT,
    CONSTRAINT fkRegSensor FOREIGN KEY (fkSensor)
        REFERENCES sensor(idSensor)
);





CREATE TABLE Sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    codSensor CHAR(4),
    area VARCHAR(25),
    andar INT,
    fkEmpresa INT,
    CONSTRAINT fkSensorEmpresa FOREIGN KEY (fkEmpresa)
        REFERENCES empresa(idCliente)
);

INSERT INTO sensor (codSensor, area, andar) VALUES
('AA01', 'Recepção', 1),
('BB01', 'Sala de Reuniões', 2),
('CC01', 'Sala de Projetos', 1),
('EE01', 'Escritório Principal', 3);


