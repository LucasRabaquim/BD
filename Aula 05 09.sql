drop database db_exemploo;
create database db_exemploo;
use db_exemploo;

create table tb_funcionario(
funcId int auto_increment primary key,
FuncNome varchar(150) not null,
funcEmail varchar (150) not null
);


create table tb_funcionario_historico like tb_funcionario;
/*
insert into tb_funcionario(*/

describe tb_funcionario_historico;
describe tb_funcionario;

insert into tb_funcionario(funcNome, funcEmail)
	values('Will Jr', 'willj@escola.com');
    
select *from tb_funcionario;

insert into tb_funcionario(funcNome, funcEmail)
	values('Antonio Pedro', 'willj@escola.com');
    
insert into tb_funcionario(funcNome, funcEmail)
	values('Monica Cascão', 'willj@escola.com');
    
alter table tb_funcionario_historico modify funcId int not null;
alter table tb_funcionario_historico drop primary key;
alter table tb_funcionario_historico add Atualizacao datetime;
alter table tb_funcionario_historico add Situacao varchar(20);

alter table tb_funcionario_historico 
add constraint pk_id_func primary key (funcId,Atualizacao,Situacao);

delimiter $$
create trigger TRG_FuncHistoricoInsert after insert on tb_funcionario
	for each row
begin
	insert into tb_funcionario_historico
    set funcId = new.funcId,
		funcNome = new.funcNome,
        funcEmail= new.funcEmail,
        atualizacao = current_timestamp(),
        situacao = "Novo";
end; $$

    
insert into tb_funcionario(funcNome, funcEmail)
	values('Will Jr', 'willj@escola.com');

delimiter $$
create trigger TRG_FuncHistoricoDelete before delete on tb_funcionario
	for each row
begin
	insert into tb_funcionario_historico
    set funcId = old.funcId,
		funcNome = old.funcNome,
        funcEmail= old.funcEmail,
        atualizacao = current_timestamp(),
        situacao = "Excluído";
end $$
set sql_safe_updates= 0;
delete from tb_funcionario;
select * from tb_funcionario;
select * from tb_funcionario_historico;

delimiter //
create trigger TRG_Atualizacao after update on tb_funcionario for each row
begin
	insert into tb_funcionario_historico
    set funcId = new.funcId,
		funcNome = new.funcNome,
        funcEmail= new.funcEmail,
        atualizacao = current_timestamp(),
        situacao = "Novo";
        insert into tb_funcionario_historico
    set funcId = old.funcId,
		funcNome = old.funcNome,
        funcEmail= old.funcEmail,
        atualizacao = current_timestamp(),
        situacao = "Velho";
	
end
//