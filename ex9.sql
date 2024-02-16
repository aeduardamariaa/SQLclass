create database teste

use teste

CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY,
    Nome VARCHAR(50),
    Cidade VARCHAR(50),
    Estado VARCHAR(2)
);

INSERT INTO Clientes VALUES (1, 'João', 'São Paulo', 'SP');
INSERT INTO Clientes VALUES (2, 'Maria', 'Rio de Janeiro', 'RJ');
INSERT INTO Clientes VALUES (3, 'Carlos', 'Belo Horizonte', 'MG');
INSERT INTO Clientes VALUES (4, 'Ana', 'Porto Alegre', 'RS');
INSERT INTO Clientes VALUES (5, 'Pedro', 'Salvador', 'BA');

CREATE TABLE Pedidos (
    PedidoID INT PRIMARY KEY,
    ClienteID INT FOREIGN KEY REFERENCES Clientes (ClienteID),
    DataPedido DATE,
    ValorTotal DECIMAL(10, 2)
);

INSERT INTO Pedidos VALUES (1, 1, '2024-01-10', 150.00);
INSERT INTO Pedidos VALUES (2, 2, '2024-01-15', 200.50);
INSERT INTO Pedidos VALUES (3, 1, '2024-02-01', 120.75);
INSERT INTO Pedidos VALUES (4, 3, '2024-02-10', 300.25);
INSERT INTO Pedidos VALUES (5, 4, '2024-03-05', 75.50);
INSERT INTO Pedidos VALUES (6, 5, '2024-03-15', 180.00);

Select * FROM Clientes
select * from Pedidos

-- Crie uma consulta que retorne o número total de pedidos feitos por cada cliente.

SELECT 
	C.Nome AS 'Nome cliente',
	SUM(P.ValorTotal) AS 'Pedido total',
	COUNT(P.ClienteID) AS 'Qtde de pedido'
FROM Clientes C
INNER JOIN Pedidos P
ON C.ClienteID = P.ClienteID
GROUP BY C.Nome

-- Liste os clientes que fizeram pelo menos dois pedidos com um valor total superior a 200.

SELECT 
    C.Nome AS 'Nome Cliente',
    COUNT(P.PedidoID) AS QuantidadePedidos,
    SUM(P.ValorTotal) AS TotalPedidos
FROM 
    Clientes C
INNER JOIN 
    Pedidos P ON C.ClienteID = P.ClienteID
GROUP BY 
    C.Nome
HAVING 
    COUNT(P.PedidoID) >= 2 AND SUM(P.ValorTotal) > 200;

-- Encontre clientes que fizeram pedidos acima da média de valor total de todos os pedidos.

SELECT 
    C.Nome AS 'Nome Cliente',
    P.PedidoID,
    P.ValorTotal,
    (SELECT AVG(ValorTotal) FROM Pedidos) AS MediaValorTotalPedidos
FROM 
    Clientes C
INNER JOIN 
    Pedidos P ON C.ClienteID = P.ClienteID
WHERE 
    P.ValorTotal > (SELECT AVG(ValorTotal) FROM Pedidos);

-------------------------------------------------------


-- Encontre clientes que fizeram mais pedidos do que a média, considerando apenas clientes com pelo menos dois pedidos.

SELECT 
    C.Nome AS 'Nome Cliente',
    Cidade,
    QuantidadePedidos,
    (SELECT AVG(QuantidadePedidos) FROM (SELECT ClienteID, COUNT(*) AS QuantidadePedidos FROM Pedidos GROUP BY ClienteID HAVING COUNT(*) >= 2) AS PedidosPorCliente) AS MediaPedidosPorCliente
FROM 
    Clientes C
INNER JOIN 
    (SELECT ClienteID, COUNT(*) AS QuantidadePedidos FROM Pedidos GROUP BY ClienteID HAVING COUNT(*) >= 2) AS PedidosPorCliente
ON 
    C.ClienteID = PedidosPorCliente.ClienteID
WHERE 
    PedidosPorCliente.QuantidadePedidos > (SELECT AVG(QuantidadePedidos) FROM (SELECT ClienteID, COUNT(*) AS QuantidadePedidos FROM Pedidos GROUP BY ClienteID HAVING COUNT(*) >= 2) AS PedidosPorCliente);
