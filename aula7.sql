--TRANSATION
--TRIGGER: inserção, exclusão, atualizar.
---for(jundo à ação), after(após), instead of (no lugar)

use Aula

CREATE TRIGGER excluirPessoa
ON Pessoa
INSTEAD OF DELETE
AS
BEGIN
	DECLARE @pessoa AS INT
	SELECT @pessoa = (SELECT IDPessoa FROM DELETED) -- Pega a pessoa que foi deletada

	DELETE FROM EventoPessoa WHERE IDPessoa = @pessoa
	DELETE FROM Pessoa WHERE IDPessoa = @pessoa
END

DELETE FROM Pessoa WHERE IDPessoa = 'id qualquer'

-- poderia ser 

CREATE TRIGGER excluirPessoa
ON Pessoa
INSTEAD OF DELETE
AS
BEGIN
	DELETE FROM EventoPessoa WHERE IDPessoa = (SELECT IDPessoa FROM DELETED)
	DELETE FROM Pessoa WHERE IDPessoa = (SELECT IDPessoa FROM DELETED)
END


CREATE TABLE Log(
	Data DATETIME,
	Operacao VARCHAR(50),
	Observacao VARCHAR(50),
	PRIMARY KEY(Data, Operacao)
)

CREATE TRIGGER operacao
ON Pessoa
AFTER INSERT
AS 
BEGIN
	DECLARE @categoria VARCHAR(50)
	DECLARE @nome VARCHAR(255)
	SET @categoria = (SELECT Categoria FROM INSERTED)
	SET @nome = (SELECT Nome FROM INSERTED)

	INSERT INTO Log VALUES (GETDATE(), 'Inserção', 'Inserido ' + @categoria + ' ' + @nome)
END

insert into Pessoa values ('vr5fchrftv','Maria Duda', 'Aluno')

select * from log

SELECT * FROM Pessoa
