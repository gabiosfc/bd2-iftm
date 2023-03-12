CREATE DATABASE exercicio2;
USE exercicio2;

CREATE TABLE banco(
	codigo INT NOT NULL PRIMARY KEY,
    nome VARCHAR(45) NOT NULL
);

CREATE TABLE cliente(
	cpf VARCHAR(45) NOT NULL PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    sexo CHAR(1) NOT NULL,
    endereco VARCHAR(45) NOT NULL
);

CREATE TABLE conta(
	numero_conta VARCHAR(45) NOT NULL PRIMARY KEY,
    saldo DOUBLE NOT NULL,
    tipo_conta INT NOT NULL,
    numero_agencia INT NOT NULL,
    FOREIGN KEY fk_numero_agencia(numero_agencia) 
		REFERENCES agencia (numero_agencia)
);

CREATE TABLE agencia(
	codigo_banco INT NOT NULL,
    numero_agencia INT NOT NULL,
    endereco VARCHAR(45) NOT NULL,
    PRIMARY KEY (numero_agencia, codigo_banco),
	FOREIGN KEY fk_codigo_banco(codigo_banco) 
		REFERENCES banco (codigo)
);

CREATE TABLE historico(
	cpf_cliente VARCHAR(45) NOT NULL,
    numero_conta VARCHAR(45) NOT NULL,
    data_inicio DATE NOT NULL,
    PRIMARY KEY (cpf_cliente, numero_conta),
	FOREIGN KEY fk_cpf_cliente(cpf_cliente) 
		REFERENCES cliente (cpf), 
    FOREIGN KEY fk_numero_conta(numero_conta) 
		REFERENCES conta (numero_conta)
);

CREATE TABLE telefone_cliente(
	cpf_cliente VARCHAR(45) NOT NULL,
    telefone VARCHAR(45),
    PRIMARY KEY (telefone, cpf_cliente),
	FOREIGN KEY fk_cpf_cliente(cpf_cliente) 
		REFERENCES cliente (cpf)
);


INSERT INTO banco (codigo, nome)
	VALUES (1, 'Banco do Brasil'),
	(4, 'CEF');
    
INSERT INTO agencia (numero_agencia, endereco, codigo_banco)
	VALUES (0562, 'Rua Joaquim Teixeira Alves, 1555', 4),
    (3153, 'Av. Marcelino Pires, 1960', 1);

INSERT INTO cliente (cpf, nome, sexo, endereco)
	VALUES ('111.222.333-44', 'Jennifer B Souza', 'F', 'Rua Cuiabá, 1050'),
	('666.777.888-99', 'Caetano K Lima', 'M', 'Rua Ivinhema, 879'),
    ('555.444.777-33', 'Silvia Macedo', 'F', 'Rua Estados Unidos, 735');
    
INSERT INTO conta (numero_conta, saldo, tipo_conta, numero_agencia)
	VALUES ('86340-2', 736.05, 2, 3153),
    ('23584-7', 3879.12, 1, 0562);
    
INSERT INTO historico (cpf_cliente, numero_conta, data_inicio)
	VALUES ('111.222.333-44', '23584-7', '1997-12-17'),
    ('666.777.888-99', '23584-7', '1997-12-17'),
    ('555.444.777-33', '86340-2', '2012-11-29');
    
INSERT INTO telefone_cliente (cpf_cliente, telefone)
	VALUES ('111.222.333-44', '(67)3422-7788'),
    ('666.777.888-99', '(67)3422-9900'),
    ('666.777.888-99', '(67)8121-8833');


-- 1
-- Altere a tabela cliente e crie um novo atributo chamado e-mail para armazenar os emails dos clientes.
ALTER TABLE cliente
	ADD COLUMN email VARCHAR(45) AFTER endereco;
    
SELECT * FROM cliente;
    
-- 2 
-- Recupere o cpf e o endereço do(s) cliente(s) cujo primeiro nome seja ‘c’.
SELECT cpf, endereco FROM cliente
	WHERE nome LIKE 'C%';
    
-- 3
-- Altere o número da agência 0562 para 6342.
INSERT INTO agencia (numero_agencia, endereco, codigo_banco)
	VALUES (6342, 'Rua Joaquim Teixeira Alves, 1555', 4);

UPDATE conta SET numero_agencia = 6342 
	WHERE numero_agencia = 0562;

DELETE FROM agencia
	WHERE numero_agencia = 0562;

SELECT * FROM agencia a, conta c
	WHERE a.numero_agencia = 6342
    AND c.numero_agencia = 6342;
    
-- 4
-- Altere o registro do cliente Caetano K Lima acrescentando o email caetanolima@gmail.com.
UPDATE cliente SET email = 'caetanolima@gmail.com'
	WHERE nome LIKE 'Caetano%';

SELECT * FROM cliente
	WHERE nome LIKE 'Caetano%';
    
-- 5
-- Conceda à conta 23584-7 um aumento de 10 por cento no saldo.
UPDATE conta SET saldo = (saldo + (saldo * (10/100)))
	WHERE numero_conta LIKE '23584-7';
    
SELECT * FROM conta
	WHERE numero_conta LIKE '23584-7';

-- 6
-- Insira na tabela de Agência os seguintes dados:
-- Numero: 1333
-- Endereço: Rua João José da Silva, 486
-- Banco do Brasil
INSERT INTO agencia (numero_agencia, endereco, codigo_banco)
	VALUES (1333, 'Rua João José da Silva, 486', 1);

SELECT * FROM agencia
	WHERE numero_agencia = 1333;
    
-- 7
-- Recupere todos os atributos de uma agência e os atributos do banco ao qual ela pertence. Busque para a agência de número 0562.
SELECT * FROM agencia a, banco b
	WHERE a.numero_agencia = 0562 -- No item 3 esse numero da agência foi alterado para 6342
    AND b.codigo = a.codigo_banco;
    
SELECT * FROM agencia a, banco b
	WHERE a.numero_agencia = 6342
    AND b.codigo = a.codigo_banco;
    
-- 8 
-- Recupere o número e o endereço de todas as agências do Banco do Brasil.
SELECT numero_agencia, endereco FROM agencia a, banco b
	WHERE b.nome = 'Banco do Brasil'
    AND b.codigo = a.codigo_banco;

-- 9
-- Para cada cliente, liste o número da sua conta, o número da agência que a controla.
SELECT cl.cpf, cl.nome, cl.sexo, cl.endereco, co.numero_conta, co.numero_agencia FROM conta co, historico h, cliente cl
	WHERE h.cpf_cliente = cl.cpf
    AND h.numero_conta = co.numero_conta;
    
-- 10
-- Recupere todos os valores de atributo de qualquer cliente que é do sexo masculino.
SELECT * FROM cliente cl, telefone_cliente t, conta co 
	WHERE cl.sexo = 'M';
    
-- 11
-- Exclua a conta 86340-2
DELETE FROM historico
	WHERE numero_conta = '86340-2';

DELETE FROM conta
	WHERE numero_conta = '86340-2';
    
    
COMMIT;

SELECT cpf_cliente, COUNT(*) FROM telefone_cliente
GROUP BY cpf_cliente
HAVING COUNT(*) > 1;




