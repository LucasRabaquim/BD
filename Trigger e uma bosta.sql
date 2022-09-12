drop database db_Escola;
create database db_Escola;
use db_escola;

create table tb_Cliente(
 ClienteId int primary key auto_increment,
 cliNome varchar(150) not null, 
 cliEmail varchar(150) not null
);

delimiter $$
create procedure spCadastro(vcliNome varchar(150), vcliEmail varchar(150)) 
begin 
	insert into tb_cliente(cliNome, cliEmail) values(vcliNome, vcliEmail);
end $$



call spCadastro("Carlos", "cc@escola.com");
call spCadastro("Davizinho", "zinho@escola.com");
call spCadastro("Lindinha", "lindi@escola.com");

create table tb_ClienteHistorico like tb_Cliente;


alter table tb_ClienteHistorico modify ClienteId int not null;
alter table tb_ClienteHistorico drop primary key;


alter table tb_ClienteHistorico add Momento datetime;
alter table tb_ClienteHistorico add Situacao varchar(100);

alter table tb_ClienteHistorico 
add constraint pk_ClienteId primary key (ClienteId,Momento,Situacao);

delimiter // 
create trigger TGR_InsertCliHistorico after insert on tb_ClienteHistorico
for each row
begin

	insert into tb_ClienteHistorico
    set cliNome = new.cliNome,
    cliEmail = new.cliEmail,
    Momento = current_timestamp(),
	Situacao = "Novo";

end//
insert into tb_Cliente(cliNome, cliEmail) values ("Tontinho", "tonti@escola.com");

delimiter //
create trigger TRG_Atualizacao after update on tb_Cliente for each row
begin
	insert into tb_ClienteHistorico
    set cliNome = new.cliNome,
    cliEmail = new.cliEmail,
    Momento = current_timestamp(),
	Situacao = "Novo";

	insert into tb_funcionario_historico
    set cliNome = old.cliNome,
	cliEmail= old.cliEmail,
	Momento = current_timestamp(),
	Situacao = "Velho";
	
end
//

drop procedure spUpdateCli;

delimiter $$
create procedure spUpdateCli(vcliId int, vcliNome varchar(150), vcliEmail varchar(150)) 
begin 
	update tb_cliente set cliNome = vcliNome, cliEmail = vcliEmail where ClienteId = vcliId;
end $$

call spUpdateCli(4, "Muito Tontinho", "tonti@escola.com");



select * from tb_Cliente;




