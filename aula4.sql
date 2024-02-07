-- Encontre a quantidade de eventos que cada pessoa participou, os que mais participaram aparecem por primeiro e quem nunca participou deve aparecer 0.
SELECT P.Nome, COUNT(EP.IDEventoPessoa) AS "Qtde de eventos" FROM Pessoa P
LEFT JOIN EventoPessoa EP
ON P.IDPessoa = EP.IDPessoa
GROUP BY P.Nome
ORDER BY COUNT(EP.IDEventoPessoa) DESC



--5. Preciso controlar se as reuniões estão sendo realizadas nas salas com a capacidade correta.
--Liste as Salas, Eventos, Capacidade das salas e Quantidade de Participantes.
--Crie uma coluna chamada "Avaliação da Capacidade" com dados como: "Ultrapassou o limite", "Limite ok".
--Dica: Use "Case When"

SELECT S.Nome, E.Descricao, S.Capacidade, COUNT(EP.PapelEvento) AS 'Participantes',
	CASE
		WHEN S.Capacidade >= COUNT(EP.IDPessoa) THEN 'Limite OK'
		WHEN S.Capacidade < COUNT(EP.IDPessoa) THEN 'Ultrapassou o limite'
	END AS 'Avaliação da capacidade'
FROM Evento E
INNER JOIN Sala S
ON S.IDSala = E.IDSala
INNER JOIN EventoPessoa EP
ON E.IDEvento = EP.IDEvento
GROUP BY S.Nome, E.Descricao, S.Capacidade, E.IDEvento

--Encontre com sub-select, os eventos que iriam ter um limite ultrapassado, mas que não tiverasm 
--por causa de algumas pessoas que faltaram no dia,
--criei uma VIEW para esse select

--*** GRPUP BY: precisa chamar os campos no group by ou colocar count no select SEMPRE!

SELECT
	S.Nome, 
	E.Descricao,
	S.Capacidade,
	COUNT(EP.PapelEvento) AS 'Convidados',
	SUM(CASE WHEN EP.Presenca = 1 THEN 1 ELSE 0 END) AS 'Presentes'
FROM Evento E
INNER JOIN Sala S
ON S.IDSala = E.IDSala
INNER JOIN EventoPessoa EP
ON E.IDEvento = EP.IDEvento
GROUP BY S.Nome, E.Descricao, S.Capacidade, E.IDEvento
HAVING S.Capacidade < COUNT(EP.IDPessoa) AND S.Capacidade >= SUM(CASE WHEN EP.Presenca = 1 THEN 1 ELSE 0 END)

-- OUTRA RESOLUÇÃO USANDO IN
SELECT -- selecionou os eventos que haviam excedido a capacidade somente com os convidados, porém os presentes não excederam aquele valor
	S.Nome as Sala,
	E.Descricao as Evento,
	S.Capacidade as CapacidadeSala,
	COUNT(EP.IDEventoPessoa) as Presentes

FROM Evento as E

INNER JOIN Sala as S
ON S.IDSala = E.IDSala

INNER JOIN EventoPessoa as EP
ON  EP.IDEvento = E.IDEvento

GROUP BY EP.Presenca, E.IDEvento, S.Nome, S.Capacidade, E.Descricao
HAVING EP.Presenca = 1 AND S.Capacidade >= COUNT(EP.IDEventoPessoa) AND E.IDEvento IN (

	SELECT 
		E.IDEvento
	FROM Evento as E

	INNER JOIN Sala as S
	ON S.IDSala = E.IDSala

	INNER JOIN EventoPessoa as EP
	ON  EP.IDEvento = E.IDEvento

	GROUP BY E.IDEvento, S.Capacidade
	HAVING COUNT(EP.IDEventoPessoa) > S.Capacidade)

--SUB-SELECT e IN:
SELECT * FROM Evento E
INNER JOIN EventoEquipamento EQ
ON E.IDEvento = EQ.IDEvento
WHERE EQ.IDEquipamento IN (SELECT IDEquipamento FROM Equipamento WHERE Tipo IN ('Informática','Multimidia'))
