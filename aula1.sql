CREATE DATABASE Db_ETS
-- GO pode ser usado para fazer com que o seja executado primeiro a criação do banco e depois o resto dos comandos 
USE Db_ETS
-- DROP DATABASE Db_ETS (excluí o banco de dados)

CREATE TABLE Colaborador(
	EDV int NOT NULL,
	Nome varchar(255) NOT NULL,
	Ativo bit
)

DROP TABLE Colaborador


-- CREATE SCHEMA [nome do schema] -> criação do schema, no banco em que está usando
-- CREATE TABLE [nome do schema].nomeTabela -> criação da tabela com schema
