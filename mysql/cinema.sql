create database db_cinema;

use db_cinema;

create table tb_estudio(
cod int not null primary key auto_increment,
nome varchar(45),
proprietario varchar(45),
faturamentoanoanterior decimal(10,2),
datafundacao date);

create table tb_filmes(
cod int not null primary key auto_increment,
meses int,
nome varchar(45),
anolancamento year(4),
custotoal decimal(10, 2),
codestudio int not null,
foreign key (codestudio) references tb_estudio(cod));

create table tb_atores(
cod int not null primary key auto_increment,
nome varchar(45),
nacionalidade varchar(45),
idade int,
sexo char(1));

create table tb_atuam(
cod int not null primary key auto_increment,
codatores int not null,
codfilme int not null,
caches decimal(10, 2),
personagem varchar(45),
foreign key (codatores) references tb_atores(cod),
foreign key (codfilme) references tb_filmes(cod));

INSERT INTO tb_estudio (nome, proprietario, faturamentoanoanterior, datafundacao) VALUES
('Warner Bros. Pictures', 'Kevin Tsujihara', 70000000.00, '1923-04-04'),
('Universal Pictures', 'Ron Meyer', 75000000.00, '1912-04-30'),
('20th Century Studios', 'Alan Horn', 80000000.00, '1935-05-31');

INSERT INTO tb_filmes (meses, nome, anolancamento, custotoal, codestudio) VALUES
(8, 'Harry Potter and the Philosopher''s Stone', 2001, 8000000.00, 1),
(7, 'Jurassic Park', 1993, 7000000.00, 2),
(9, 'Avatar', 2009, 10000000.00, 3);

INSERT INTO tb_atores (nome, nacionalidade, idade, sexo) VALUES
('Daniel Radcliffe', 'British', 32, 'M'),
('Emma Watson', 'British', 31, 'F'),
('Rupert Grint', 'British', 33, 'M'),
('Sam Neill', 'New Zealander', 74, 'M'),
('Laura Dern', 'American', 54, 'F'),
('Sigourney Weaver', 'American', 72, 'F'),
('Sam Worthington', 'Australian', 45, 'M');

INSERT INTO tb_atuam (codatores, codfilme, caches, personagem) VALUES
(1, 4, 15000000.00, 'Harry Potter'),
(2, 4, 12000000.00, 'Hermione Granger'),
(3, 4, 13000000.00, 'Ron Weasley'),
(4, 5, 10000000.00, 'Dr. Alan Grant'),
(5, 5, 9000000.00, 'Dr. Ellie Sattler'),
(6, 5, 9500000.00, 'Dr. Ian Malcolm'),
(7, 6, 20000000.00, 'Jake Sully');

INSERT INTO tb_estudio (nome, proprietario, faturamentoanoanterior, datafundacao) VALUES
('Paramount Pictures', 'Jim Gianopulos', 85000000.00, '1912-05-08'),
('Sony Pictures Entertainment', 'Tony Vinciquerra', 90000000.00, '1987-11-18'),
('Walt Disney Pictures', 'Bob Chapek', 95000000.00, '1923-10-16');

INSERT INTO tb_filmes (meses, nome, anolancamento, custotoal, codestudio) VALUES
(7, 'Inception', 2010, 9000000.00, 4),
(8, 'The Dark Knight', 2008, 9500000.00, 5),
(6, 'Titanic', 1997, 8000000.00, 6),
(7, 'The Avengers', 2012, 8500000.00, 1),
(9, 'Interstellar', 2014, 10000000.00, 2),
(8, 'Forrest Gump', 1994, 9000000.00, 3),
(6, 'Pirates of the Caribbean: The Curse of the Black Pearl', 2003, 85000000.00, 1);

INSERT INTO tb_atores (nome, nacionalidade, idade, sexo) VALUES
('Leonardo DiCaprio', 'American', 47, 'M'),
('Joseph Gordon-Levitt', 'American', 40, 'M'),
('Tom Hardy', 'British', 44, 'M'),
('Christian Bale', 'British', 48, 'M'),
('Heath Ledger', 'Australian', 43, 'M'),
('Kate Winslet', 'British', 46, 'F'),
('Robert Downey Jr.', 'American', 56, 'M'),
('Chris Evans', 'American', 40, 'M'),
('Matthew McConaughey', 'American', 52, 'M'),
('Tom Hanks', 'American', 65, 'M');

INSERT INTO tb_atuam (codatores, codfilme, caches, personagem) VALUES
(1, 10, 18000000.00, 'Dom Cobb'),
(2, 10, 15000000.00, 'Arthur'),
(3, 10, 16000000.00, 'Eames'),
(4, 10, 20000000.00, 'Bruce Wayne / Batman'),
(5, 9, 17000000.00, 'Bane'),
(6, 9, 18000000.00, 'Alfred'),
(7, 9, 25000000.00, 'Jack Dawson'),
(8, 6, 22000000.00, 'Rose DeWitt Bukater'),
(9, 6, 30000000.00, 'Tony Stark / Iron Man'),
(10, 7, 27000000.00, 'Steve Rogers / Captain America'),
(1, 7, 20000000.00, 'Cooper'),
(2, 8, 18000000.00, 'Ariadne'),
(9, 8, 28000000.00, 'Forrest Gump');

/*Quais são os estúdios cadastrados no banco de dados?*/

select nome as "Estúdios" from tb_estudio;

/*Quantos filmes foram lançados em cada ano?*/

select anolancamento, count(*) as qtde from tb_filmes
group by anolancamento;

/*Quais são os atores estrangeiros no banco de dados e quantos são?*/
select nome as "Estrangeiros" from tb_atores
where nacionalidade not like 'brasilian';

select count(nome) as "Total estrangeiros" from tb_atores
where nacionalidade not like 'brasilian';

/*Qual é o filme mais recente lançado?*/
select nome, anolancamento as "Lançamento"  
from tb_filmes order by anolancamento limit 1;

/*Quais são os estúdios que tiveram um faturamento superior a 1 milhão no ano anterior?*/
select nome from tb_estudio
where faturamentoanoanterior >= 1000000;

/*Quantos atores têm menos de 30 anos?*/
select count(*) as "Menores de 30" from tb_atores
where idade < 30;

/*Qual é a média de meses de produção dos filmes?*/
select round(avg(meses),0) as "Média" from tb_filmes;

/*Qual é o filme em que um ator recebeu o maior cache?*/
select tb_filmes.nome from tb_atores
inner join tb_atuam on tb_atores.cod = tb_atuam.codatores
inner join tb_filmes on tb_atuam.codfilme = tb_filmes.cod
order by tb_atuam.caches desc
LIMIT 1;

/*Quais são os filmes que foram lançados nos últimos 14 anos?*/
select nome from tb_filmes
where anolancamento >= (year(now()) - 14);

/*Qual é o estúdio com a data de fundação mais recente?*/
select nome from tb_estudio
order by datediff(now(), datafundacao) desc
limit 1;

/*Quais são os atores que já atuaram em mais de 2 filmes?*/
select tb_atores.nome from tb_atores
inner join tb_atuam 
on tb_atores.cod = tb_atuam.codatores
inner join tb_filmes 
on tb_atuam.codfilme = tb_filmes.cod
group by tb_atores.nome
having COUNT(tb_filmes.cod) > 2;

/*Qual é o custo médio total dos filmes produzidos por cada estúdio?*/
select tb_estudio.nome, avg(tb_filmes.custotoal) from tb_estudio
inner join tb_filmes
on tb_estudio.cod = tb_filmes.codestudio
group by tb_estudio.nome;

/*Quais são os atores americanos que têm mais de 40 anos?*/
select nome from tb_atores
where nacionalidade like "American"
and idade > 40;

/*Quais são os filmes e seus custos totais, ordenados pelo custo total em ordem crescente?*/
select nome, custotoal from tb_filmes
order by custotoal asc;

/*Quantos atores tem a letra inicial do seu nome entre K e W ?*/
select nome, count(*) as "qtde" from tb_atores
where nome like 'K%'
or nome like 'W%';

/*Quantos filmes têm custo total entre $100.00 e $500.00?*/
select count(*) from tb_filmes
where custotoal >= 100
and custotoal <= 500; 

/*Quantos estúdios têm um faturamento no ano anterior superior a $1 milhão e uma data de fundação anterior a 2000?*/
select count(*) as "Qtde menor que 2000" from tb_estudio
where faturamentoanoanterior >= 1000000
and year(datafundacao) < 2000;
