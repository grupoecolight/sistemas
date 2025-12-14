CREATE DATABASE Ecolight;

USE Ecolight;

CREATE TABLE empresa (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    razaoSocial VARCHAR(255),
    cnpj CHAR(14),
    cep CHAR(8),
    responsavel VARCHAR(255),
    telefone CHAR(11),
    dtCadastro DATETIME
);


CREATE TABLE mensagem (
    idMensagem INT PRIMARY KEY AUTO_INCREMENT,
    nomeEmpresa VARCHAR(45),
    emailEmpresa VARCHAR(255),
    nomeRepresentante VARCHAR(45),
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
    empresaAdmin INT,
    CONSTRAINT chkEmpresaAdmin CHECK (empresaAdmin IN (0,1)),
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
    tagSensor VARCHAR(20), -- Aumentado para caber '002-NOR-01' etc.
    area VARCHAR(25),
    descricao VARCHAR(255)
);


CREATE TABLE regSensor (
    idRegSensor INT AUTO_INCREMENT,
    intensidadeLuz INT,
    dtHora DATETIME DEFAULT CURRENT_TIMESTAMP,
    fkSensor INT,
    fkAmbiente INT, -- Nova coluna para vincular a leitura ao local
    
    CONSTRAINT pkRegSensor PRIMARY KEY (idRegSensor),
    CONSTRAINT fkRegSensor FOREIGN KEY (fkSensor)
        REFERENCES Sensor(idSensor),
    CONSTRAINT fkRegAmbiente FOREIGN KEY (fkAmbiente)
        REFERENCES ambiente(idAmbiente)
);

INSERT INTO empresa (razaoSocial, cnpj, cep, responsavel, telefone, dtCadastro) VALUES
('XPTO Technology LTDA', '10276849534012', '01310000', 'Maria Silva', 11987654321, '2025-01-15 10:30:00'),
('Eco Buzziness LTDA', '40345976786543', '01310940', 'João Pereira', 11956433478, '2025-02-10 14:00:00'),
('Seguradora de veículos LTDA', '54367891235409', '01310200', 'Ana Lima', 11956422465, '2025-03-05 09:15:00'),
('Ecolight', '01310200430006', '05594001', 'Eduardo Nascimento', 11925810212, '2025-03-10 09:00:00');

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


INSERT INTO usuario (areaEmpresa, email, senha, userAdmin, empresaAdmin, fkOrganizacao) VALUES
('Administração', 'admin@xptotech.com', 'Admin#123', 0, 1, 1),
('Recursos Humanos', 'rh@empresa1.com', 'Rh#02025', 0, 1, 2),
('Gerência', 'gerente@empresa2.com', 'Ger@XPTO', 0, 1, 3),
('Ecolight-n3', 'admin@ecolight.com', 'Urubu#100', 1, 1, 1); 

-- SENSORES:
INSERT INTO Sensor (tagSensor, area, descricao) VALUES
('A-02-BERLIM-01', 'Sala Berlim', 'Sensor instalado na esquadra norte, primeira secção envidraçada adjacente à coluna estrutural A1.'),
('A-02-BERLIM-02', 'Sala Berlim', 'Dispositivo fixado na segunda janela a partir do acesso principal, com monitoramento de incidência direta.'),
('A-02-BERLIM-03', 'Sala Berlim', 'Módulo posicionado na região central da parede envidraçada, equidistante das extremidades.'),
('A-02-BERLIM-04', 'Sala Berlim', 'Sensor localizado na quarta janela, próximo ao sistema de climatização VRF.'),
('A-02-BERLIM-05', 'Sala Berlim', 'Instalação realizada na primeira janela da sala, monitorando a luminosidade difusa refletida.'),
('A-02-BERLIM-06', 'Sala Berlim', 'Sensor fixado na segunda secção, posicionado para evitar sombreamento por mobiliário alto.'),
('A-02-BERLIM-07', 'Sala Berlim', 'Dispositivo na terceira janela, adjacente à saída de emergência secundária.'),
('A-02-BERLIM-08', 'Sala Berlim', 'Módulo monitorando a extremidade oposta ao hall, focado em compensação de luz artificial.');


-- SENSORES:
INSERT INTO Sensor (tagSensor, area, descricao) VALUES
('B-02-TOKYO-01', 'Sala Tokyo', 'Sensor posicionado na direita da sala a partir da porta, recebendo incidência solar matinal direta, próximo ao projetor.'),
('B-02-TOKYO-02', 'Sala Tokyo', 'Dispositivo na segunda folha de vidro, calibrado para alta intensidade de lux.'),
('B-02-TOKYO-03', 'Sala Tokyo', 'Módulo central da fachada esquerda da sala a partir da porta, monitorando a zona de reunião principal e mesa de conferência.'),
('B-02-TOKYO-04', 'Sala Tokyo', 'Instalação na extremidade direita da fachada, próximo ao painel de automação.'),
('B-02-TOKYO-05', 'Sala Tokyo', 'Sensor na fachada oeste, captando luminosidade vespertina, posicionado no canto superior esquerdo.'),
('B-02-TOKYO-06', 'Sala Tokyo', 'Dispositivo na zona intermediária, minimizando reflexos em monitores adjacentes.'),
('B-02-TOKYO-07', 'Sala Tokyo', 'Módulo na direita a partir da porta, alinhado com a segunda fileira de assentos da conferência.'),
('B-02-TOKYO-08', 'Sala Tokyo', 'Dispositivo fixado na segunda janela a partir do acesso principal, com monitoramento de incidência direta.'),
('B-02-TOKYO-09', 'Sala Tokyo', 'Dispositivo na terceira folha de vidro, calibrado para alta intensidade de lux.'),
('B-02-TOKYO-10', 'Sala Tokyo', 'Instalação realizada na primeira janela da sala, monitorando a luminosidade difusa refletida.'),
('B-02-TOKYO-11', 'Sala Tokyo', 'Módulo monitorando a extremidade oposta ao hall, focado em compensação de luz artificial.'),
('B-02-TOKYO-12', 'Sala Tokyo', 'Sensor localizado na quarta janela, próximo ao sistema de climatização VRF.');


-- SENSORES:
INSERT INTO Sensor (tagSensor, area, descricao) VALUES
('C-02-RIO-01', 'Sala Rio', 'Sensor fixado ao lado esquerdo da recepção a partir da entrada, primeira janela próxima ao balcão de atendimento.'),
('C-02-RIO-02', 'Sala Rio', 'Dispositivo na segunda janela da direita a partir da porta, monitorando a área de espera de visitantes.'),
('C-02-RIO-03', 'Sala Rio', 'Módulo na terceira janela da direita a partir da porta, posicionado acima das plantas ornamentais para evitar obstrução.'),
('C-02-RIO-04', 'Sala Rio', 'Instalação na quarta janela da direita a partir da porta, cobrindo o corredor de acesso aos elevadores.'),
('C-02-RIO-05', 'Sala Rio', 'Sensor nos fundos da sala, monitorando a iluminação indireta próxima à área do café.'),
('C-02-RIO-06', 'Sala Rio', 'Dispositivo na face sul, zona central da parede envidraçada, focado em luz natural constante.'),
('C-02-RIO-07', 'Sala Rio', 'Módulo na face sul, adjacente à porta de acesso à escada de incêndio.'),
('C-02-RIO-08', 'Sala Rio', 'Sensor na extremidade da face sul, calibrado para detectar variações bruscas de luminosidade.');


-- SENSORES:
INSERT INTO Sensor (tagSensor, area, descricao) VALUES
('D-02-SÃO_PAULO-01', 'Sala São Paulo', 'Sensor posicionado na direita da sala a partir da porta, recebendo incidência solar matinal direta, próximo ao projetor.'),
('D-02-SÃO_PAULO-02', 'Sala São Paulo', 'Dispositivo na segunda folha de vidro, calibrado para alta intensidade de lux.'),
('D-02-SÃO_PAULO-03', 'Sala São Paulo', 'Módulo central da fachada esquerda da sala a partir da porta, monitorando a zona de reunião principal e mesa de conferência.'),
('D-02-SÃO_PAULO-04', 'Sala São Paulo', 'Instalação na extremidade direita da fachada, próximo ao painel de automação.'),
('D-02-SÃO_PAULO-05', 'Sala São Paulo', 'Sensor na fachada oeste, captando luminosidade vespertina, posicionado no canto superior esquerdo.'),
('D-02-SÃO_PAULO-06', 'Sala São Paulo', 'Dispositivo na zona intermediária, minimizando reflexos em monitores adjacentes.'),
('D-02-SÃO_PAULO-07', 'Sala São Paulo', 'Módulo na direita a partir da porta, alinhado com a segunda fileira de assentos da conferência.'),
('D-02-SÃO_PAULO-08', 'Sala São Paulo', 'Sensor na extremidade inferior da direita a partir da porta, monitorando entrada de luz residual.');


-- SENSORES:
INSERT INTO Sensor (tagSensor, area, descricao) VALUES
('E-02-NOVA_YORK-01', 'Sala Nova York', 'Sensor instalado na esquadria norte, primeira secção envidraçada adjacente à coluna estrutural E1.'),
('E-02-NOVA_YORK-02', 'Sala Nova York', 'Dispositivo fixado na segunda janela a partir do acesso principal, com monitoramento de incidência direta.'),
('E-02-NOVA_YORK-03', 'Sala Nova York', 'Módulo posicionado na região central da parede envidraçada, equidistante das extremidades.'),
('E-02-NOVA_YORK-04', 'Sala Nova York', 'Sensor localizado na quarta janela, próximo ao sistema de climatização VRF.'),
('E-02-NOVA_YORK-05', 'Sala Nova York', 'Instalação realizada na primeira janela da sala, monitorando a luminosidade difusa refletida.'),
('E-02-NOVA_YORK-06', 'Sala Nova York', 'Sensor fixado na segunda secção, posicionado para evitar sombreamento por mobiliário alto.'),
('E-02-NOVA_YORK-07', 'Sala Nova York', 'Dispositivo na terceira janela, adjacente à saída de emergência secundária.'),
('E-02-NOVA_YORK-08', 'Sala Nova York', 'Módulo monitorando a extremidade oposta ao hall, focado em compensação de luz artificial.');


SELECT * FROM mensagem;


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
    a.nome AS 'Nome do Ambiente', 
    COUNT(DISTINCT r.fkSensor) AS 'Qtd. Sensores' 
FROM ambiente a 
LEFT JOIN regSensor r ON a.idAmbiente = r.fkAmbiente 
WHERE a.fkEmpresa = 1
GROUP BY a.idAmbiente, a.nome;

-- Hora dos Registros desse ambiente e últimos registros de cada sensor
SELECT reg.idRegSensor, reg.fkAmbiente, reg.fkSensor, ambiente.nome, Sensor.tagSensor, reg.intensidadeLuz, MAX(reg.dtHora) AS dtRegistro
FROM regSensor AS reg JOIN Sensor ON idSensor = fkSensor
JOIN ambiente ON idAmbiente = fkAmbiente
WHERE ambiente.fkEmpresa = 1
AND reg.dtHora = (SELECT MAX(reg2.dtHora) 
FROM regSensor AS reg2
WHERE reg.fkSensor = reg2.fkSensor)
GROUP BY reg.intensidadeLuz , reg.fkSensor , reg.idRegSensor , fkAmbiente;
            
-- Últimos 10 Registros de cada Sensor 
SELECT 
	ambiente.nome as ambiente,
    fkSensor, 
    intensidadeLuz, 
    dtHora 
FROM regSensor
JOIN Sensor ON idSensor = fkSensor 
JOIN ambiente ON idAmbiente = fkAmbiente 
WHERE dtHora > '2025-12-03 08:00:00' 
  AND dtHora <= '2025-12-03 10:00:00'  
  AND fkEmpresa = 1;
  
-- Identificar quantos ambientes tem a empresa e a média de cada ambiente
-- SELECT ambiente.nome, Sensor.tagSensor, reg.intensidadeLuz, MAX(reg.dtHora) AS dtRegistro
-- 	FROM regSensor AS reg 
-- 	JOIN Sensor ON idSensor = fkSensor
-- 	JOIN ambiente ON idAmbiente = fkAmbiente
-- 		WHERE ambiente.fkEmpresa = 1
-- 			AND reg.dtHora = (SELECT MAX(reg2.dtHora) 
-- 				FROM regSensor AS reg2
-- 					WHERE reg.fkSensor = reg2.fkSensor)
-- 		GROUP BY reg.intensidadeLuz , reg.fkSensor , reg.idRegSensor , fkAmbiente;

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

-- SENSOR 17 (ambiente 3)
INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(2, 17, 580, '2025-12-03 08:00:00'),
(2, 17, 586, '2025-12-03 08:10:00'),
(2, 17, 593, '2025-12-03 08:20:00'),
(2, 17, 600, '2025-12-03 08:30:00'),
(2, 17, 597, '2025-12-03 08:40:00'),
(2, 17, 603, '2025-12-03 08:50:00'),
(2, 17, 609, '2025-12-03 09:00:00'),
(2, 17, 615, '2025-12-03 09:10:00'),
(2, 17, 621, '2025-12-03 09:20:00'),
(2, 17, 618, '2025-12-03 09:30:00'),
(2, 17, 624, '2025-12-03 09:40:00'),
(2, 17, 631, '2025-12-03 09:50:00');

-- SENSOR 18 (ambiente 3)
INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(2, 18, 460, '2025-12-03 08:00:00'),
(2, 18, 468, '2025-12-03 08:10:00'),
(2, 18, 474, '2025-12-03 08:20:00'),
(2, 18, 480, '2025-12-03 08:30:00'),
(2, 18, 476, '2025-12-03 08:40:00'),
(2, 18, 483, '2025-12-03 08:50:00'),
(2, 18, 490, '2025-12-03 09:00:00'),
(2, 18, 495, '2025-12-03 09:10:00'),
(2, 18, 502, '2025-12-03 09:20:00'),
(2, 18, 499, '2025-12-03 09:30:00'),
(2, 18, 505, '2025-12-03 09:40:00'),
(2, 18, 512, '2025-12-03 09:50:00');

-- SENSOR 19 (ambiente 3)
INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(2, 19, 350, '2025-12-03 08:00:00'),
(2, 19, 358, '2025-12-03 08:10:00'),
(2, 19, 365, '2025-12-03 08:20:00'),
(2, 19, 372, '2025-12-03 08:30:00'),
(2, 19, 368, '2025-12-03 08:40:00'),
(2, 19, 375, '2025-12-03 08:50:00'),
(2, 19, 381, '2025-12-03 09:00:00'),
(2, 19, 387, '2025-12-03 09:10:00'),
(2, 19, 393, '2025-12-03 09:20:00'),
(2, 19, 390, '2025-12-03 09:30:00'),
(2, 19, 396, '2025-12-03 09:40:00'),
(2, 19, 402, '2025-12-03 09:50:00');

-- SENSOR 20 (ambiente 3)
INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(2, 20, 490, '2025-12-03 08:00:00'),
(2, 20, 498, '2025-12-03 08:10:00'),
(2, 20, 505, '2025-12-03 08:20:00'),
(2, 20, 512, '2025-12-03 08:30:00'),
(2, 20, 509, '2025-12-03 08:40:00'),
(2, 20, 517, '2025-12-03 08:50:00'),
(2, 20, 523, '2025-12-03 09:00:00'),
(2, 20, 529, '2025-12-03 09:10:00'),
(2, 20, 536, '2025-12-03 09:20:00'),
(2, 20, 532, '2025-12-03 09:30:00'),
(2, 20, 538, '2025-12-03 09:40:00'),
(2, 20, 545, '2025-12-03 09:50:00');


---------------------------------------------------------
-- AMBIENTE 3 — Sensores 21 a 28
---------------------------------------------------------

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

-- AMBIENTE 4 — Sensores 29 a 36 (muito acima)

INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(4, 29, 880, '2025-12-03 08:00:00'),
(4, 29, 890, '2025-12-03 08:10:00'),
(4, 29, 905, '2025-12-03 08:20:00'),
(4, 29, 915, '2025-12-03 08:30:00'),
(4, 29, 908, '2025-12-03 08:40:00'),
(4, 29, 920, '2025-12-03 08:50:00'),
(4, 29, 930, '2025-12-03 09:00:00'),
(4, 29, 940, '2025-12-03 09:10:00'),
(4, 29, 950, '2025-12-03 09:20:00'),
(4, 29, 945, '2025-12-03 09:30:00'),
(4, 29, 960, '2025-12-03 09:40:00'),
(4, 29, 970, '2025-12-03 09:50:00'),

(4, 30, 860, '2025-12-03 08:00:00'),
(4, 30, 872, '2025-12-03 08:10:00'),
(4, 30, 885, '2025-12-03 08:20:00'),
(4, 30, 895, '2025-12-03 08:30:00'),
(4, 30, 888, '2025-12-03 08:40:00'),
(4, 30, 900, '2025-12-03 08:50:00'),
(4, 30, 910, '2025-12-03 09:00:00'),
(4, 30, 920, '2025-12-03 09:10:00'),
(4, 30, 930, '2025-12-03 09:20:00'),
(4, 30, 925, '2025-12-03 09:30:00'),
(4, 30, 940, '2025-12-03 09:40:00'),
(4, 30, 950, '2025-12-03 09:50:00'),

(4, 31, 900, '2025-12-03 08:00:00'),
(4, 31, 910, '2025-12-03 08:10:00'),
(4, 31, 925, '2025-12-03 08:20:00'),
(4, 31, 935, '2025-12-03 08:30:00'),
(4, 31, 928, '2025-12-03 08:40:00'),
(4, 31, 940, '2025-12-03 08:50:00'),
(4, 31, 950, '2025-12-03 09:00:00'),
(4, 31, 960, '2025-12-03 09:10:00'),
(4, 31, 970, '2025-12-03 09:20:00'),
(4, 31, 965, '2025-12-03 09:30:00'),
(4, 31, 980, '2025-12-03 09:40:00'),
(4, 31, 990, '2025-12-03 09:50:00'),

(4, 32, 870, '2025-12-03 08:00:00'),
(4, 32, 880, '2025-12-03 08:10:00'),
(4, 32, 895, '2025-12-03 08:20:00'),
(4, 32, 905, '2025-12-03 08:30:00'),
(4, 32, 898, '2025-12-03 08:40:00'),
(4, 32, 910, '2025-12-03 08:50:00'),
(4, 32, 920, '2025-12-03 09:00:00'),
(4, 32, 930, '2025-12-03 09:10:00'),
(4, 32, 940, '2025-12-03 09:20:00'),
(4, 32, 935, '2025-12-03 09:30:00'),
(4, 32, 950, '2025-12-03 09:40:00'),
(4, 32, 960, '2025-12-03 09:50:00'),

(4, 33, 910, '2025-12-03 08:00:00'),
(4, 33, 920, '2025-12-03 08:10:00'),
(4, 33, 935, '2025-12-03 08:20:00'),
(4, 33, 945, '2025-12-03 08:30:00'),
(4, 33, 938, '2025-12-03 08:40:00'),
(4, 33, 950, '2025-12-03 08:50:00'),
(4, 33, 960, '2025-12-03 09:00:00'),
(4, 33, 970, '2025-12-03 09:10:00'),
(4, 33, 980, '2025-12-03 09:20:00'),
(4, 33, 975, '2025-12-03 09:30:00'),
(4, 33, 990, '2025-12-03 09:40:00'),
(4, 33, 1000, '2025-12-03 09:50:00'),

(4, 34, 890, '2025-12-03 08:00:00'),
(4, 34, 900, '2025-12-03 08:10:00'),
(4, 34, 915, '2025-12-03 08:20:00'),
(4, 34, 925, '2025-12-03 08:30:00'),
(4, 34, 918, '2025-12-03 08:40:00'),
(4, 34, 930, '2025-12-03 08:50:00'),
(4, 34, 940, '2025-12-03 09:00:00'),
(4, 34, 950, '2025-12-03 09:10:00'),
(4, 34, 960, '2025-12-03 09:20:00'),
(4, 34, 955, '2025-12-03 09:30:00'),
(4, 34, 970, '2025-12-03 09:40:00'),
(4, 34, 980, '2025-12-03 09:50:00'),

(4, 35, 920, '2025-12-03 08:00:00'),
(4, 35, 930, '2025-12-03 08:10:00'),
(4, 35, 945, '2025-12-03 08:20:00'),
(4, 35, 955, '2025-12-03 08:30:00'),
(4, 35, 948, '2025-12-03 08:40:00'),
(4, 35, 960, '2025-12-03 08:50:00'),
(4, 35, 970, '2025-12-03 09:00:00'),
(4, 35, 980, '2025-12-03 09:10:00'),
(4, 35, 990, '2025-12-03 09:20:00'),
(4, 35, 985, '2025-12-03 09:30:00'),
(4, 35, 1000, '2025-12-03 09:40:00'),
(4, 35, 1010, '2025-12-03 09:50:00'),

(4, 36, 870, '2025-12-03 08:00:00'),
(4, 36, 880, '2025-12-03 08:10:00'),
(4, 36, 895, '2025-12-03 08:20:00'),
(4, 36, 905, '2025-12-03 08:30:00'),
(4, 36, 898, '2025-12-03 08:40:00'),
(4, 36, 910, '2025-12-03 08:50:00'),
(4, 36, 920, '2025-12-03 09:00:00'),
(4, 36, 930, '2025-12-03 09:10:00'),
(4, 36, 940, '2025-12-03 09:20:00'),
(4, 36, 935, '2025-12-03 09:30:00'),
(4, 36, 950, '2025-12-03 09:40:00'),
(4, 36, 960, '2025-12-03 09:50:00');


-- AMBIENTE 5 — Sensores 37 a 44 (muito abaixo)

INSERT INTO regSensor (fkAmbiente, fkSensor, intensidadeLuz, dtHora) VALUES
(5, 37, 40, '2025-12-03 08:00:00'),
(5, 37, 45, '2025-12-03 08:10:00'),
(5, 37, 50, '2025-12-03 08:20:00'),
(5, 37, 55, '2025-12-03 08:30:00'),
(5, 37, 52, '2025-12-03 08:40:00'),
(5, 37, 58, '2025-12-03 08:50:00'),
(5, 37, 60, '2025-12-03 09:00:00'),
(5, 37, 65, '2025-12-03 09:10:00'),
(5, 37, 70, '2025-12-03 09:20:00'),
(5, 37, 68, '2025-12-03 09:30:00'),
(5, 37, 72, '2025-12-03 09:40:00'),
(5, 37, 75, '2025-12-03 09:50:00'),

(5, 38, 30, '2025-12-03 08:00:00'),
(5, 38, 35, '2025-12-03 08:10:00'),
(5, 38, 40, '2025-12-03 08:20:00'),
(5, 38, 45, '2025-12-03 08:30:00'),
(5, 38, 42, '2025-12-03 08:40:00'),
(5, 38, 48, '2025-12-03 08:50:00'),
(5, 38, 50, '2025-12-03 09:00:00'),
(5, 38, 55, '2025-12-03 09:10:00'),
(5, 38, 60, '2025-12-03 09:20:00'),
(5, 38, 58, '2025-12-03 09:30:00'),
(5, 38, 62, '2025-12-03 09:40:00'),
(5, 38, 65, '2025-12-03 09:50:00'),

(5, 39, 80, '2025-12-03 08:00:00'),
(5, 39, 85, '2025-12-03 08:10:00'),
(5, 39, 90, '2025-12-03 08:20:00'),
(5, 39, 95, '2025-12-03 08:30:00'),
(5, 39, 92, '2025-12-03 08:40:00'),
(5, 39, 98, '2025-12-03 08:50:00'),
(5, 39, 100, '2025-12-03 09:00:00'),
(5, 39, 105, '2025-12-03 09:10:00'),
(5, 39, 110, '2025-12-03 09:20:00'),
(5, 39, 108, '2025-12-03 09:30:00'),
(5, 39, 112, '2025-12-03 09:40:00'),
(5, 39, 115, '2025-12-03 09:50:00'),

(5, 40, 25, '2025-12-03 08:00:00'),
(5, 40, 30, '2025-12-03 08:10:00'),
(5, 40, 35, '2025-12-03 08:20:00'),
(5, 40, 40, '2025-12-03 08:30:00'),
(5, 40, 38, '2025-12-03 08:40:00'),
(5, 40, 42, '2025-12-03 08:50:00'),
(5, 40, 45, '2025-12-03 09:00:00'),
(5, 40, 50, '2025-12-03 09:10:00'),
(5, 40, 55, '2025-12-03 09:20:00'),
(5, 40, 52, '2025-12-03 09:30:00'),
(5, 40, 58, '2025-12-03 09:40:00'),
(5, 40, 60, '2025-12-03 09:50:00'),

(5, 41, 90, '2025-12-03 08:00:00'),
(5, 41, 95, '2025-12-03 08:10:00'),
(5, 41, 100, '2025-12-03 08:20:00'),
(5, 41, 105, '2025-12-03 08:30:00'),
(5, 41, 102, '2025-12-03 08:40:00'),
(5, 41, 108, '2025-12-03 08:50:00'),
(5, 41, 110, '2025-12-03 09:00:00'),
(5, 41, 115, '2025-12-03 09:10:00'),
(5, 41, 120, '2025-12-03 09:20:00'),
(5, 41, 118, '2025-12-03 09:30:00'),
(5, 41, 122, '2025-12-03 09:40:00'),
(5, 41, 125, '2025-12-03 09:50:00'),

(5, 42, 20, '2025-12-03 08:00:00'),
(5, 42, 25, '2025-12-03 08:10:00'),
(5, 42, 30, '2025-12-03 08:20:00'),
(5, 42, 35, '2025-12-03 08:30:00'),
(5, 42, 32, '2025-12-03 08:40:00'),
(5, 42, 38, '2025-12-03 08:50:00'),
(5, 42, 40, '2025-12-03 09:00:00'),
(5, 42, 45, '2025-12-03 09:10:00'),
(5, 42, 50, '2025-12-03 09:20:00'),
(5, 42, 48, '2025-12-03 09:30:00'),
(5, 42, 52, '2025-12-03 09:40:00'),
(5, 42, 55, '2025-12-03 09:50:00'),

(5, 43, 70, '2025-12-03 08:00:00'),
(5, 43, 75, '2025-12-03 08:10:00'),
(5, 43, 80, '2025-12-03 08:20:00'),
(5, 43, 85, '2025-12-03 08:30:00'),
(5, 43, 82, '2025-12-03 08:40:00'),
(5, 43, 88, '2025-12-03 08:50:00'),
(5, 43, 90, '2025-12-03 09:00:00'),
(5, 43, 95, '2025-12-03 09:10:00'),
(5, 43, 100, '2025-12-03 09:20:00'),
(5, 43, 98, '2025-12-03 09:30:00'),
(5, 43, 102, '2025-12-03 09:40:00'),
(5, 43, 105, '2025-12-03 09:50:00'),

(5, 44, 50, '2025-12-03 08:00:00'),
(5, 44, 55, '2025-12-03 08:10:00'),
(5, 44, 60, '2025-12-03 08:20:00'),
(5, 44, 65, '2025-12-03 08:30:00'),
(5, 44, 62, '2025-12-03 08:40:00'),
(5, 44, 68, '2025-12-03 08:50:00'),
(5, 44, 70, '2025-12-03 09:00:00'),
(5, 44, 75, '2025-12-03 09:10:00'),
(5, 44, 80, '2025-12-03 09:20:00'),
(5, 44, 78, '2025-12-03 09:30:00'),
(5, 44, 82, '2025-12-03 09:40:00'),
(5, 44, 85, '2025-12-03 09:50:00');
