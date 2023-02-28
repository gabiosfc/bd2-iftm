CREATE DATABASE exercicio1;
USE exercicio1;

CREATE TABLE editora(
	cod_editora INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(45) NOT NULL,
    endereco VARCHAR(45)
);

CREATE TABLE livro(
	cod_livro INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(45) NOT NULL,
    titulo VARCHAR(45) NOT NULL,
    num_edicao INT,
    preco FLOAT NOT NULL,
    cod_editora INT NOT NULL,
-- nome da coluna (nome da coluna que está sendo referenciada na tbela atual)
    FOREIGN KEY fk_cod_editora(cod_editora) 
-- nome da tabela da chave estrangeira (nome da coluna referenciada na tabela de origem)
		REFERENCES editora (cod_editora)
);

CREATE TABLE autor(
	cod_autor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    sexo CHAR,
    data_nascimento DATE
);

CREATE TABLE livro_autor(
	cod_livro INT NOT NULL,
    cod_autor INT NOT NULL,
    PRIMARY KEY (cod_livro, cod_autor),
	FOREIGN KEY fk_cod_livro(cod_livro) 
		REFERENCES livro (cod_livro), 
    FOREIGN KEY fk_cod_autor(cod_autor) 
		REFERENCES autor (cod_autor)
);


-- Numero 1
ALTER TABLE editora
	RENAME COLUMN descricao TO nome;
    
-- Numero 2
ALTER TABLE autor
	MODIFY COLUMN sexo VARCHAR(1);
    
-- Numero 3
ALTER TABLE livro
	ADD UNIQUE (isbn);
    
-- Numero 4
ALTER TABLE livro
	ALTER COLUMN preco SET DEFAULT 10.00;

-- Numero 5
ALTER TABLE livro
	DROP COLUMN num_edicao;

ALTER TABLE livro
	ADD COLUMN edicao INT AFTER titulo;

	
-- Numero 6
CREATE TABLE grupo(
	id_grupo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL
);

ALTER TABLE editora
	ADD COLUMN id_grupo INT;

ALTER TABLE editora
	ADD CONSTRAINT fk_id_grupo
    FOREIGN KEY (id_grupo) 
		REFERENCES grupo(id_grupo)
        ON UPDATE CASCADE
		ON DELETE SET NULL;
