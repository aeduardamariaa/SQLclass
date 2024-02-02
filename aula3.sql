USE Aula

-- Buscando informações especificas e atribuindo apelidos
SELECT 
	E.IDEvento, 
	E.Descricao AS 'Descrição do Evento', 
	CONVERT(VARCHAR(10), E.DtHrIniciO, 103) AS 'Data Inicio',
	CONVERT(VARCHAR(5), E.DtHrInicio, 108) AS 'Hora Inicio' , 
	CONVERT(VARCHAR(10), E.DtHrFim, 103) AS 'Data Fim',
	CONVERT(VARCHAR(5), E.DtHrFim, 108) AS 'Hora Fim',
	S.Nome AS 'Nome da sala'
FROM Evento E
INNER JOIN Sala S
ON E.IDSala = S.IDSala
WHERE GETDATE() BETWEEN E.DtHrInicio AND E.DtHrFim


--************ ALTERANDO DADOS ************
UPDATE Evento 
SET DtHrInicio = '02/02/2024 13:00',
	DtHrFim = '02/02/2024 17:00'
WHERE IDEvento = '0C7P3SFZHMYR'


-- Exercício 1: Encontrar as 3 salas com maior capacidade.
SELECT * FROM Sala
ORDER BY Capacidade DESC

-- Exercício 2: Preciso controlar quem reservou cada sala, pois ele é responsável por deixar tudo no lugar ao sair. Encontre:
SELECT 
	S.Nome "Nome sala" , 
	E.DtHrInicio "Data de Inicio", 
	E.Descricao "Descrição do evento", 
	P.Nome "Nome responsável" 
FROM Evento E
INNER JOIN Sala S
ON E.IDSala = S.IDSala
INNER JOIN EventoPessoa EP
ON EP.IDEvento = E.IDEvento
INNER JOIN Pessoa P
ON P.IDPessoa = EP.IDPessoa
WHERE EP.PapelEvento = 'Responsavel'

-- Exercício 3: Preciso controlar qual dia e por quanto tempo cada sala foi utilizada por cada reunião. Dica: Use DateDiff
SELECT 
	S.Nome, 
	CONVERT(VARCHAR(10), E.DtHrIniciO, 103) AS 'Data Inicio',
	CONVERT(VARCHAR(10), E.DtHrFim, 103) AS 'Data Fim',
	DATEDIFF(HOUR, E.DtHrInicio, E.DtHrFim) AS "Horas usadas"
FROM Evento E
INNER JOIN Sala S
ON E.IDSala = S.IDSala

-- Exercício 4: Quanto tempo(Minutos) cada sala foi ou será utilizada no total?

SELECT 
	S.Nome,
	SUM(DATEDIFF(MINUTE, E.DtHrInicio, E.DtHrFim)) AS 'Minutos Totais'
FROM Evento E
INNER JOIN Sala S
ON E.IDSala = S.IDSala
GROUP BY S.Nome

-- Alteração de dados é UPDATE e alteração de tabela se usa ALTER TABLE

--************ JOINs ************
--INNER JOIN - só puxa os nomes que tem foreign key
--LEFT JOIN - puxa todo os dados da primeira tabela e só puxa o da direita se tiver foreign key
--RIGHT JOIN - puxa todos da direita e só puxa da esquerda se tiver foreign key
--FULL JOIN - puxa tudo de todas as tabelas

--COUNT(): conta quantidades
--GROUP BY: agrupa que tem HAVING
