CREATE DATABASE Db_ETS
-- GO pode ser usado para fazer com que o seja executado primeiro a criação do banco e depois o resto dos comandos 
USE Db_ETS
-- DROP DATABASE Db_ETS (excluí o banco de dados)

-- CREATE SCHEMA [nome do schema] -> criação do schema, no banco em que está usando
-- CREATE TABLE [nome do schema].nomeTabela -> criação da tabela com schema

CREATE TABLE Sala (
	IDSala int PRIMARY KEY NOT NULL,
	Nome varchar(50) NOT NULL,
	Capacidade int NOT NULL
)
CREATE TABLE Pessoa (
	IDPessoa int PRIMARY KEY NOT NULL,
	Nome varchar(255) NOT NULL,
	CPF char(11) NOT NULL,
	Funcao varchar(50) NOT NULL
)
CREATE TABLE Equipamento(
	IDEquipamento int PRIMARY KEY NOT NULL,
	Nome VARCHAR(50) NOT NULL,
	Tipo VARCHAR(50) NOT NULL,
	IDSala int FOREIGN KEY REFERENCES Sala(IDSala)
)
CREATE TABLE Evento(
	IDEvento int PRIMARY KEY NOT NULL,
	Descricao varchar(100) NOT NULL,
	DataIni date NOT NULL,
	DataFinal date NOT NULL,
	IDSala int FOREIGN KEY REFERENCES Sala(IDSala)
)

CREATE TABLE PessoaEvento(
	IDPessoaEvento int PRIMARY KEY NOT NULL,
	IDPessoa int FOREIGN KEY REFERENCES Pessoa(IDPessoa),
	IDEvento int FOREIGN KEY REFERENCES Evento(IDEvento)
)

CREATE TABLE EventoEquipamento(
	IDEventoEquipamento int PRIMARY KEY NOT NULL,
	IDEvento int FOREIGN KEY REFERENCES Evento(IDEvento),
	IDEquipamento int FOREIGN KEY REFERENCES Equipamento(IDEquipamento)
)


INSERT INTO Sala (IDSala, Nome, Capacidade) VALUES (1,'ETs', 21)
INSERT INTO Sala VALUES (2, 'BDO', 45), (3,'ICO',69)

-- SELECT * FROM Sala ORDER BY Capacidade DESC, Nome ASC   -> para ordenar em ordem crescente ou decrescente, nessa caso ele desempata usando o campo nome

SELECT * FROM Sala
SELECT * FROM Evento
