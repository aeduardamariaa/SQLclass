CREATE FUNCTION seiLa (@tipo VARCHAR(10))
RETURNS TABLE AS
RETURN(
	
)

SELECT * FROM Evento
SELECT * FROM Sala
SELECT * FROM EventoPessoa

SELECT 
	E.Descricao AS 'Nome evento',
	S.Nome AS 'Nome sala',
	SUM(CASE WHEN EP.Presenca = 1 THEN 1 ELSE 0 END) AS 'Presentes',
	CONVERT(VARCHAR(10), E.DtHrInicio, 103) AS 'Data Inicio',
	CONVERT(VARCHAR(10), E.DtHrFim, 103) AS 'Data Fim'
FROM Evento E
INNER JOIN Sala S
ON E.IDSala = S.IDSala
INNER JOIN EventoPessoa EP
ON EP.IDEvento = E.IDEvento
GROUP BY S.Nome, E.Descricao, S.Capacidade, E.IDEvento, E.DtHrInicio, E.DtHrFim
