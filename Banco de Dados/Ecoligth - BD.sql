/*
PROJETO ENTREGÁVEL SPRINT 1

Eduarda Kaori Nakandakari | 01252008
Larissa Lie Okamoto | 01252039
Nicolas Mazza | 0125200
Nicollas Almeida | 01252064
Miguel Igor | 01252122
Vitoria Ferreira | 01252130
Vitor Lima | 012520 
*/

-- TABELA COM DADOS DOS CADASTROS DOS CLIENTES
CREATE DATABASE ecolight;
USE ecolight;

CREATE TABLE cadastro(
id INT PRIMARY KEY AUTO_INCREMENT, 
nome VARCHAR(60) NOT NULL UNIQUE, 
email VARCHAR(60) NOT NULL UNIQUE, 
cnpj CHAR (18) NOT NULL UNIQUE,
cep CHAR (9) NOT NULL,
responsável VARCHAR(60) NOT NULL, 
telefone VARCHAR(20) NOT NULL, 
dtCadastro DATETIME DEFAULT current_timestamp,
senha VARCHAR(30)
); 

INSERT INTO cadastro VALUES 
(default, 'ABC Ltda','abc@gmail.com','82.132.889/0001-25','12441-211','Nicolas','(73)2424-1268', default, null),
(default, 'DEF Ltda','def@gmail.com','81.635.043/0001-45','03582-140','Vitoria','(88)2953-6666', default, null),
(default, 'GHI Ltda','ghi@gmail.com','04.404.111/0001-14','07262-190','Larissa','(81)2362-4820', default, null),
(default, 'JKL Ltda','jkl@gmail.com','06.718.816/0001-31','15042-000','Vitor','(81)2362-4820', default, null),
(default, 'MNO Ltda','mno@gmail.com','11.344.086/0001-96','05831-290','Miguel','(79)3279-5237', default, null);

DESCRIBE cadastro;
-- Exibir dados como gerente
SELECT * FROM cadastro;

-- Exibir dados como funcionário
SELECT nome AS 'Cliente', 
	 email AS 'Contato da Empresa', 
     cnpj AS 'CNPJ', 
     CONCAT(responsável, telefone) AS 'Contato Representante', 
     dtCadastro AS 'Data de Cadastro', 
     cep AS CEP
     FROM cadastro;	
     

-- TABELA COM DADOS DO ARDUINO
USE ecolight;

DROP TABLE dadoSensor;

CREATE TABLE dadoSensor (
id INT PRIMARY KEY AUTO_INCREMENT,
cliente VARCHAR(50),
dtHorario DATETIME DEFAULT CURRENT_TIMESTAMP,
intensidadeLuz DECIMAL (4,1),
CONSTRAINT chkIntensidadeLuz CHECK(intensidadeLuz  BETWEEN 0 AND 100)
);

INSERT INTO dadoSensor (cliente, dtHorario, intensidadeLuz) VALUES 
('ABC Ltda.', DEFAULT, 100.0),
('DEF Ltda.', DEFAULT, 65.2),
('GHI Ltda.', DEFAULT, 25.9),
('JKL Ltda.', DEFAULT, 14.3),
('MNO Ltda.', DEFAULT, 70.4);

SELECT * FROM dadoSensor;

SELECT cliente AS 'Cliente do Ecolight',
	dtHorario AS 'Horário do Dado',
	intensidadeLuz AS 'Intensidade da Luz Natural'
FROM dadoSensor;

-- Simulando um segundo registro do arduino após 30min
INSERT INTO dadoSensor (cliente, dtHorario, intensidadeLuz) VALUES
('ABC Ltda.', DEFAULT, 80.2),
('DEF Ltda.', DEFAULT, 60.8),
('GHI Ltda.', DEFAULT, 55.1),
('JKL Ltda.', DEFAULT, 35.0),
('MNO Ltda.', DEFAULT, 76.7);

-- Simulando um terceiro registro do arduino após 30min
INSERT INTO dadoSensor (cliente, dtHorario, intensidadeLuz) VALUES
('ABC Ltda.', DEFAULT, 82.2),
('DEF Ltda.', DEFAULT, 15.1),
('GHI Ltda.', DEFAULT, 60.9),
('JKL Ltda.', DEFAULT, 70.3),
('MNO Ltda.', DEFAULT, 50.2);

-- Dados do Arduino por empresa
SELECT * FROM dadoSensor
WHERE cliente = 'ABC Ltda.';

SELECT * FROM dadoSensor
WHERE cliente = 'DEF Ltda.';

SELECT * FROM dadoSensor
WHERE cliente = 'GHI Ltda.';

SELECT * FROM dadoSensor
WHERE cliente = 'JKL Ltda.';

SELECT * FROM dadoSensor
WHERE cliente = 'MNO Ltda.';

ALTER TABLE dadoSensor ADD COLUMN 
statusIntensidade VARCHAR (90);

ALTER TABLE dadoSensor ADD CONSTRAINT 
	checkIntensidade CHECK(statusIntensidade IN ('Alta Incidência de Luz', 'Média Incidência de Luz', 'Baixa Incidência de Luz'));
    
UPDATE dadoSensor SET statusIntensidade =
		CASE
		WHEN intensidadeLuz >70 THEN 'Alta incidência de Luz'
		WHEN intensidadeLuz BETWEEN 30 AND 70 THEN 'Média incidência de Luz'
		WHEN intensidadeLuz <30 THEN 'Baixa incidência de Luz'
        END
        WHERE id IN (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15);

SELECT cliente AS 'Cliente do Ecolight',
	dthorario AS 'Data e Horário do Dado',
    statusIntensidade AS 'Status Incidência',
    CONCAT (intensidadeLuz, '%') AS 'Intensidade da Luz Natural'
FROM dadoSensor;



-- TABELA DADOS PARA CLIENTES

USE ecolight;

CREATE TABLE Cliente (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
ambiente VARCHAR(50),
intensidadeLuz DECIMAL (4,1),
dtHorario DATETIME DEFAULT current_timestamp,
areaEmpresa VARCHAR (5)
);

DESC Cliente;

INSERT INTO Cliente VALUES 
(default, 'Sala de Reunião', 75.2, default, 1000),
(default, 'Copa', 25.7, default, 2080),
(default, 'Saguâo', 87.2, default, 560),
(default, 'Sala do RH', 100.0, default, 830),
(default, 'Sala do diretor', 35.9, default, 3920),
(default, 'Setor de produção', 63.1, default, 250);

SELECT * FROM Cliente;

-- Exibir apenas ambientes e luminosidade
SELECT ambiente, intensidadeLuz FROM Cliente;

-- Exibir tabela para visualização do cliente
SELECT idSensor, 
	ambiente AS 'Ambiente',
	dtHorario AS 'Data e Horário',
	CONCAT (areaEmpresa, 'm²')
	AS 'Área da Empresa (m²)' ,
    CONCAT (intensidadeLuz, '%')
    AS 'Intensidade da Luz Natural (%)'
    FROM Cliente;
