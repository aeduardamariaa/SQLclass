use Db_Silva

-- criação de tabelas
CREATE TABLE Sala (
  IDSala INT NOT NULL PRIMARY KEY,
  Nome VARCHAR(50) NOT NULL,
  Capacidade INT NOT NULL
);

CREATE TABLE Evento (
  IDEvento INT NOT NULL PRIMARY KEY,
  IDSala INT NOT NULL FOREIGN KEY REFERENCES Sala(IDSala),
  Descricao VARCHAR(100) NOT NULL,
  DtHrInicio DATETIME NOT NULL,
  DtHrFim DATETIME NOT NULL
);

CREATE TABLE Equipamento(
	IDEquipamento int PRIMARY KEY NOT NULL,
	Nome VARCHAR(50) NOT NULL,
	Tipo VARCHAR(100) NOT NULL,
	IDSala int FOREIGN KEY REFERENCES Sala(IDSala)
);

CREATE TABLE Pessoa (
	IDPessoa int PRIMARY KEY NOT NULL,
	Nome varchar(255) NOT NULL,
	CPF char(11) NOT NULL,
	Funcao varchar(50) NOT NULL
);

CREATE TABLE PessoaEvento(
	IDPessoaEvento int PRIMARY KEY NOT NULL,
	IDPessoa int FOREIGN KEY REFERENCES Pessoa(IDPessoa),
	IDEvento int FOREIGN KEY REFERENCES Evento(IDEvento)
); 

CREATE TABLE EventoEquipamento(
	IDEventoEquipamento int PRIMARY KEY NOT NULL,
	IDEvento int FOREIGN KEY REFERENCES Evento(IDEvento),
	IDEquipamento int FOREIGN KEY REFERENCES Equipamento(IDEquipamento)
);

-- Inserindo dados na tabela
INSERT INTO Sala (IDSala, Nome, Capacidade) VALUES (1, 'Sala de TI', 20);
INSERT INTO Sala VALUES (2, 'Sala de Reunião', 10);
INSERT INTO Sala VALUES (3, 'Sala de palestras 1', 30), (4, 'Sala de aula', 15);


-- Preenchendo a table
INSERT INTO Evento VALUES 
(
    (SELECT ISNULL(MAX(IDEvento),0) FROM Evento) + 1,
    1,
    'Aula de IoT',
    '2022-03-26 19:00',
    '2022-03-26 22:30'
);

INSERT INTO Equipamento VALUES
(
	(SELECT ISNULL(MAX(IDEquipamento), 0) FROM Equipamento) + 1,
	 'Computador','Eletronico', 2
);

select * from Equipamento
select * from Evento

-- Select com condições
SELECT
	Nome AS Sala, Capacidade 
FROM Sala
WHERE Capacidade > 22

--EXCLUIR: drop(tabela e dados), delete(exclui dados especificos) e trucante (limpa a tabela)

-- > TRUCATE TABLE NomeTabela  *** Mais rápido que o delete
-- > DROP TABLE NomeTabela
-- > DELETE FROM NomeTabela WHERE condições


-- Exemplo usando CHECK e IDENTITY
CREATE TABLE Aluno (
    IDAluno INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    Nome VARCHAR(255) NOT NULL,
    Idade INT,
    Nacionalidade VARCHAR(255) DEFAULT 'Brasil',
    CHECK (Idade>=18)
);
