drop database dbBanco;
create database dbBanco;
use dbBanco;

create table tbHistorico (
CPF bigint,
NumeroConta int,
DataInicio date,
primary key(CPF,NumeroConta)
);

create table tbConta(
Numeroconta int primary key,
Saldo decimal(7,2),
TipoConta smallint,
NumAgencia int not null
);

create table tbAgencia(
NumAgencia int primary key,
CodBanco int,
Endereco varchar(50)
);

create table tbCliente(
CPF bigint primary key,
Nome varchar(50) not null,
Sexo char(1) not null,
Endereco varchar(50) not null
);

create table tbTelefone(
Telefone int primary key,
CPF bigint
);

create table tbBanco(
Codigo int primary key,
Nome varchar(50) not null
);

alter table tbConta add constraint FK_NumAgencia_tbConta foreign key (NumAgencia) references tbAgencia(NumAgencia);

alter table tbAgencia add constraint FK_CodBanco_tbAgencia foreign key (CodBanco) references tbBanco(Codigo);

alter table tbHistorico add constraint FK_NumeroConta_tbHistorico foreign key (NumeroConta) references tbConta(NumeroConta);

alter table tbHistorico add constraint FK_CPF_tbHistorico foreign key (CPF) references tbCliente(CPF); 

alter table tbTelefone add constraint FK_CPF_tbTelefone foreign key (CPF) references tbCliente(CPF);

alter table tbCliente add E_mail varchar(100);
alter table tbCliente drop E_mail;

-- chave primária composta --> primary key (primeira-chave, segunda-chave)

insert into tbBanco (Codigo,Nome) values (1,'Banco do Brasil');
insert into tbBanco (Codigo, Nome) values (104, 'Caixa Economica Federal');
insert into tbBanco (Codigo, Nome) values (801, 'Banco Escola');
select * from tbBanco;

insert into tbAgencia (NumAgencia, CodBanco, Endereco) values (123, 1, 'Av Paulista, 78');
insert into tbAgencia (NumAgencia, CodBanco, Endereco) values (159, 104, 'Rua Liberdade, 124');
insert into tbAgencia (NumAgencia, CodBanco, Endereco) values (401, 801, 'Rua Vinte três, 23');
insert into tbAgencia (NumAgencia, CodBanco, Endereco) values (485, 801, 'Av Marechal, 68');
Select * from tbAgencia;

insert into tbCliente (CPF,Nome,Sexo,Endereco) values (12345678910,'Enildo','M','Rua Grande, 75');
insert into tbCliente (CPF,Nome,Sexo,Endereco) values (12345678911,'Astrogildo','M','Rua Pequena, 789');
insert into tbCliente (CPF,Nome,Sexo,Endereco) values (12345678912,'Monica','F','Av Larga, 148');
insert into tbCliente (CPF,Nome,Sexo,Endereco) values (12345678913,'Cascão','M','Av Principal, 369');
select * from tbCliente;

insert into tbConta (NumeroConta, Saldo, TipoConta, NumAgencia) values (9876, 501.66, 1, 123);
insert into tbConta (NumeroConta, Saldo, TipoConta, NumAgencia) values (9877, 321.00, 1, 123);
insert into tbConta (NumeroConta, Saldo, TipoConta, NumAgencia) values (9878, 100.00, 2, 485);
insert into tbConta (NumeroConta, Saldo, TipoConta, NumAgencia) values (9879, 5589.48, 1, 401);
select * from tbConta;

insert into tbHistorico (CPF, NumeroConta, DataInicio) values (12345678910, 9876, '2001-04-15');
insert into tbHistorico (CPF, NumeroConta, DataInicio) values (12345678911, 9877, '2011-03-10');
insert into tbHistorico (CPF,NumeroConta,DataInicio)  values (12345678912, 9878, '2021-03-11');
insert into tbHistorico (CPF,NumeroConta,DataInicio) values (12345678913,9879, '2000-07-05');
select * from tbHistorico;

insert into tbTelefone (Telefone,CPF) values (912345678,12345678910);
insert into tbTelefone (Telefone,CPF) values (912345679,12345678911);
insert into tbTelefone (Telefone, CPF) values (912345680, 12345678912);
insert into tbTelefone (Telefone, CPF) values (912345681, 12345678913);
select * from tbTelefone;

alter table tbCliente add email varchar(60); 

-- 5.
select CPF, Endereco from tbCliente where Nome='Monica'; 

-- 6.
select NumAgencia, Endereco from tbAgencia where CodBanco = 801;

-- 7.
select * from tbCliente where Sexo='M';


-- Exercício IX

-- 1.
delete from tbTelefone where CPF=12345678911;
select * from tbTelefone;

-- 2.
update tbConta set TipoConta=2 where NumeroConta= 9879;
select * from tbConta;

-- 3.
update tbCliente set email='Astro@escola.com' where Nome='Monica';
select * from tbCliente;


-- 4.
update tbConta set saldo=saldo*1.1 where  NumeroConta=9879;
select * from tbConta;

-- 5.
select Nome, email, Endereco from tbCliente where Nome='Monica';

-- 6.
update tbCliente set Nome="Enildo Candido" where Nome="Enildo";
select * from tbCliente;

-- 7.
update tbConta set Saldo = Saldo-30;
-- OBS: o valor de 9879 está diferente por causa do aumento de 10% do salário
select * from tbConta; 

-- 8
delete from tbConta where NumeroConta = 9878;
-- Não é possível atualizar a linha devido a chave estrangeira com tbHistórico.
select * from tbConta;