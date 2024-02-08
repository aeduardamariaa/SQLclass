CREATE FUNCTION fnProcurarEventoAntigo (@tipo VARCHAR(10))
RETURNS TABLE AS
RETURN
(
	SELECT TOP 1
		E.Descricao AS 'Nome evento',
		S.Nome AS 'Nome sala',
		COUNT(CASE WHEN EP.Presenca = 1 THEN 1 END) AS 'Presentes',
		CONVERT(VARCHAR(10), E.DtHrInicio, 103) AS 'Data Inicio',
		CONVERT(VARCHAR(5), E.DtHrInicio, 108) AS 'Data Fim'
	FROM Evento E
	INNER JOIN Sala S
	ON E.IDSala = S.IDSala
	INNER JOIN EventoPessoa EP
	ON EP.IDEvento = E.IDEvento
	WHERE E.Descricao LIKE CONCAT('%', @tipo, '%')
	GROUP BY
		E.IDEvento,
		E.Descricao,
		S.Nome,
		E.DtHrInicio
	ORDER BY E.DtHrInicio
)

SELECT * FROM dbo.fnProcurarEventoAntigo('Reuniao')
