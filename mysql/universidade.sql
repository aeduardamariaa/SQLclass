create database universidade;

use universidade;

create table aluno (
	matricula int not null primary key auto_increment,
    nome_aluno varchar(45),
    nome_responsavel varchar(45)
)default charset utf8;

create table professor (
	id_professor int not null primary key auto_increment, 
    nome_professor varchar(45),
    email varchar(45)
)default charset utf8;

create table disciplina(
	id_disc int not null primary key auto_increment,
    nome_disc varchar(45),
    carga_hor varchar(45)
)default charset utf8;

create table turma (
	id_turma int not null primary key auto_increment,
    ano year,
    horario varchar(10),
    id_disc int not null,
    id_prof int not null,
    foreign key (id_disc) references disciplina(id_disc),
    foreign key (id_prof) references professor(id_professor)
)default charset utf8;

create table historico (
	id_historico int not null primary key auto_increment,
    frequencia smallint,
    nota decimal(2,1),
    matricula int not null,
    id_disc int  not null,
    id_turma int not null,
    id_prof int not null,
    foreign key (id_disc) references disciplina(id_disc),
    foreign key (id_prof) references professor(id_professor),
    foreign key (matricula) references aluno(matricula),
    foreign key (id_turma) references turma(id_turma)
)default charset utf8;

INSERT INTO aluno (matricula, nome_aluno, nome_responsavel) VALUES
(20220101, 'Jose de Alencar', 'Maria de Alencar'),
(default, 'Machado de Assis', 'Maria José'),
(default, 'Guimarães Rosa', 'Rosinha');

INSERT INTO professor (id_professor, nome_professor, email) VALUES
(1111, 'Cesar Stati', 'cesar@gmail.com'),
(DEFAULT, 'Luiz Cesar', 'lc@gmail.com');

INSERT INTO disciplina (id_disc, nome_disc, carga_hor) VALUES
(1, 'Banco de Dados', '120'),
(2, 'IoT', '120'),
(3, 'C#', '120'),
(4, 'Lógica de Programação', '220'),
(5, 'Fundamentos de Eletroeletrônica', '120'),
(6, 'Desenvolvimento de Sistemas', '220');

INSERT INTO turma (id_turma, ano, horario, id_disc, id_prof) VALUES
(100, 2021, '13:30 às 17:30', 1, 1111);

INSERT INTO historico (id_turma, id_disc, id_prof, matricula, frequencia, nota) VALUES
(100, 1, 1111, 20220101, 10, 9.8);







