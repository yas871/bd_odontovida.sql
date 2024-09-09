/*
SENAC DF - CEP Jessé Freire
2024.07.276 - Aprendizagem Profissional de Qualificação em Desenvolvimento de Softwares
Profª Hudson Neves
Projeto Final - Implementação de Banco de Dados Relacional com MySQL
Projeto - Clinica Odontológia OdontoVida */
 
-- 1. Criação do Arquivo/Banco de Dados
create database OdontoVida;
-- 2. Acessando Arquivo/Banco de Dados
use OdontoVida;

create table Paciente (
paciente_id int AUTO_INCREMENT primary key,
nome varchar(100) not null,
data_nascimento date not null,
telefone varchar(20),
endereco TEXT,
email varchar(100)
);

create table Dentista (
 dentista_id int auto_increment primary key,
nome varchar(100) not null,
especialidade varchar(50),
telefone varchar(20),
email varchar(100)
);

create table consulta (
 consulta_id int auto_increment primary key,
paciente_id int,
dentista_id int,
data_consulta datetime,
foreign key (paciente_id) references Paciente(paciente_id),
foreign key (denntista_id) references Dentista(dentista_id)
);

create table tratamento (
tratamento_id int auto_increment primary key,
consulta_id int,
descricao text,
data_inicio date,
data_fim date,
foreign key (consulta_id) references consulta(consulta_id)
);

create table procedimento (
procedimento_id int auto_increment primary key,
nome varchar(100) not null, 
custo decimal(10, 2) not null
);


create table Tratamento_Procedimento (
tratamento_id int,
procedimento_id int,
quantidade int default 1,
primary key (tratamento_id, procedimento_id),
foreign key (tratamento_id) references tratamento(tratamento_id),
foreign key (procedimento_id) references procedimento(procedimento_id)
);

create table pagamento (
 pagamento_id int auto_increment primary key,
tratamento_id int,
valor decimal(10, 2) not null,
data_pagamento date,
foreign key (tratamento_id) references tratamento(tratamento_id)
);