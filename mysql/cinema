create database cinema;

use cinema;

create table estudio (
	cod int not null primary key auto_increment,
    nome varchar(45),
    proprietario varchar(45),
    faturamentoanterior decimal (10,2),
    datafundacao  date
)default charset utf8;

create table filmes (
	cod int not null primary key auto_increment, 
    meses int,
    nome varchar(45),
    anolancamento year,
    custototal decimal (10,2),
    codestudio int not null,
    foreign key(codestudio) references estudio(cod)
)default charset utf8;

create table atores (
	cod int not null primary key auto_increment,
    nome varchar(45),
    nacionalidade varchar(45),
    idade int,
    sexo char(1)
)default charset utf8;

create table atuam (
	cod int not null primary key auto_increment,
    cache decimal(10,2),
    personagem varchar(45),
    codatores int not null,
    codfilmes int not null,
    foreign key (codatores) references atores(cod),
    foreign key (codfilmes) references filmes(cod)
)default charset utf8;
