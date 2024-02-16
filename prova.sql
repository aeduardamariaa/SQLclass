CREATE DATABASE Mundo
USE Mundo

-- Exercício 3: criar o banco e popular

CREATE TABLE PAIS(
	Pais VARCHAR(35) PRIMARY KEY NOT NULL,
	Continente VARCHAR(35),
	Populacao FLOAT,
	PIB FLOAT,
	Expect_Vida FLOAT
);

CREATE TABLE CIDADE(
	Cidade VARCHAR(35) PRIMARY KEY NOT NULL,
	Pais VARCHAR(35) FOREIGN KEY REFERENCES PAIS(Pais) NOT NULL,
	Populacao FLOAT,
	Capital BIT
);

CREATE TABLE RIO(
	Rio VARCHAR(35) PRIMARY KEY NOT NULL,
	Pais VARCHAR(35) FOREIGN KEY REFERENCES PAIS(Pais) NOT NULL,
	Nascente VARCHAR(35) FOREIGN KEY REFERENCES PAIS(Pais) NOT NULL,
	Comprimento FLOAT
);

INSERT INTO PAIS (Pais, Continente, Populacao, PIB, Expect_Vida) VALUES ('Canada', 'America do Norte', 38.25, 1.9, 82),
('Mexico', 'America do Norte', 126.7, 1.65, 75),
('Brasil', 'America do Sul', 214.3, 1.608, 75.5),
('USA', 'America do Norte', 331.9, 21.43, 76.1),
('China', 'Asia', 1444.2, 14.34, 83),
('Alemanha', 'Europa', 83.2, 4.1, 78.1)

INSERT INTO CIDADE (Cidade, Pais, Populacao, Capital) VALUES ('Washington', 'USA', 3.3, 1),
('Monterrey', 'Mexico', 2.0, 0),
('Brasilia', 'Brasil', 1.5, 1),
('São Paulo', 'Brasil', 15.0,0),
('Ottawa', 'Canada', 0.8, 1),
('Cid. Mexico', 'Mexico', 14.1, 1),
('Pequim', 'China', 21.5, 1)

INSERT INTO RIO (Rio, Nascente, Pais, Comprimento) VALUES ('St. Lawrence', 'USA', 'USA', 3.3),
('Grande', 'USA', 'Mexico', 2.0),
('Parana', 'Brasil', 'Brasil',1.5),
('Mississipi', 'USA', 'USA', 15.0)


-- Exercício 4: Para cada continente retorne o PIB médio de seus países.

SELECT 
	Continente,
	ROUND(AVG(PIB),2)  as 'Média PIB'
FROM PAIS 
GROUP BY Continente

-- Exercício 5: Mostre o continente no qual o rio mais extenso está localizado.

SELECT TOP 1
	P.Continente
FROM PAIS P
INNER JOIN CIDADE C
ON P.Pais = C.Pais
INNER JOIN RIO R
ON P.Pais = R.Pais
ORDER BY R.Comprimento DESC

-- Exercício 6: Crie uma trigger que seja ativada ao excluir um país. A trigger deve remover todas as cidades e rios relacionados com o país excluído.

CREATE TRIGGER ExclusaoPais
ON PAIS
INSTEAD OF DELETE
AS
BEGIN
	DECLARE @pais AS VARCHAR(35)
	SELECT @pais = (SELECT Pais FROM deleted)

	DELETE FROM CIDADE WHERE Pais = @pais
	DELETE FROM RIO WHERE Pais = @pais
	DELETE FROM PAIS WHERE Pais = @pais
END

DELETE FROM PAIS WHERE Pais = 'Brasil'

-- Exercício 7: Crie uma função chamada SearchPais que receberá como parâmetro uma palavra/letra que será utilizada como 
-- base para pesquisar no banco de dados um país que comece com o parâmetro inserido.

CREATE FUNCTION SearchPais (@element VARCHAR(35))
RETURNS TABLE AS 
RETURN(
	SELECT 
		Pais
	FROM PAIS
	WHERE Pais LIKE '%' + @element + '%'
)

SELECT * FROM SearchPais('A')

-- Exercício 8: PIB per capita é o indicador que representa o que cada pessoa do local analisado teria do total de riquezas 
-- que são produzidas no país. Sendo assim, o PIB é dividido pelo número de habitantes da área, indicando o que cada pessoa 
-- produziu. " Crie uma coluna na tabela Pais com o valor do PIB per capita.

ALTER TABLE PAIS ADD PerCapita FLOAT

UPDATE PAIS
SET PerCapita = ROUND(PIB / Populacao,3)
