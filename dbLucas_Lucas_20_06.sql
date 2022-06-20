-- set sql_set_updates = 0; -- Para poder excluir sem Where. 
drop database dbDistribuidora;
create database dbDistribuidora;
use dbDistribuidora;

create table tbCliente(
	IdCli int primary key auto_increment,
    NomeCli varchar(200) not null,
    NumEnd numeric(6) not null,
    CompEnd varchar(50),
    CepCli numeric(8) not null
);

create table tbClientePF(
	CPF numeric(11) primary key,
    RG numeric(9) not null,
    RG_Dig char(1) not null,
    Nasc date not null,
    IdCli int unique not null 
); 

create table tbClientePJ(
	CNPJ numeric(14) primary key,
    IE numeric(11) unique,
    IdCli int unique not null 
);

create table tbProduto(
    CodigoBarras numeric(14) primary key,
    NomeProd varchar(200) not null,
    Valor decimal(5,2) not null,
    Qtd int
);

create table tbCompra(
	CodigoCompra numeric(10) primary key,
    DataCompra date default(current_timestamp()),
    ValorTotal decimal(6,2) not null,
    QtdTotal int not null,
    NotaFiscal int,
    IdCli int
);

create table tbNotaFiscal(
	NotaFiscal int primary key,
    TotalNota decimal(5,2) not null,
    DataEmissao date not null
);

create table tbItemCompra(
	NotaFiscal int,
    CodigoBarras numeric(14),
    ValorItem decimal(5,2) not null,
    Qtd int not null,
    primary key(NotaFiscal,CodigoBarras)
);

create table tbFornecedor(
	IdFornecedor int auto_increment primary key,
    CNPJ numeric(13) not null unique,
    NomeFornecedor varchar(100) not null,
    telefone numeric(11)
);

create table tbPedido(
	NotaFiscalPedido int primary key,
    DataCompra date not null,
    ValorTotal decimal (6,2) not null,
    QtdTotal int not null,
    IdFornecedor int
);

create table tbPedidoProduto(
	NotaFiscalPedido int,
    CodigoBarras numeric(14),
    primary key(NotaFiscalPedido,CodigoBarras)
);

create table tbEndereco(
	CEP numeric(8) primary key,
    Logradouro varchar(200),
    IdBairro int not null,
    IdCidade int not null,
    IdUF int not null
);

create table tbBairro(
    IdBairro int primary key,
    Bairro varchar(200) not null
);

create table tbCidade(
    IdCidade int primary key,
    Cidade varchar(200) not null
);

create table tbUF(
    IdUF int primary key,
    UF varchar(200) not null
);

alter table tbCliente add foreign key (CepCli) references tbEndereco(CEP);

alter table tbClientePF add foreign key (IdCli) references tbCliente(IdCli);

alter table tbClientePJ add foreign key (IdCli) references tbCliente(IdCli);

alter table tbCompra add foreign key (NotaFiscal) references tbNotaFiscal(NotaFiscal);
alter table tbCompra add foreign key (IdCli) references tbCliente(IdCli);

alter table tbItemCompra add foreign key (NotaFiscal) references tbCompra(NotaFiscal);
alter table tbItemCompra add foreign key (CodigoBarras) references tbProduto(CodigoBarras);

alter table tbPedido add foreign key (IdFornecedor) references tbFornecedor(IdFornecedor);

alter table tbPedidoProduto add foreign key (NotaFiscalPedido) references tbPedido(NotaFiscalPedido);
alter table tbPedidoProduto add foreign key (CodigoBarras) references tbProduto(CodigoBarras);

alter table tbEndereco add foreign key (IdBairro) references tbBairro(IdBairro);
alter table tbEndereco add foreign key (IdCidade) references tbCidade(IdCidade);
alter table tbEndereco add foreign key (IdUF) references tbUF(IdUF);

 -- drop procedure spInsertCidade; -- Salvação

delimiter $$
create procedure spInsertFornecedor (vCNPJ numeric(13), vNomeFornecedor varchar(100) , vTelefone numeric(11))
begin
	insert into tbFornecedor(CNPJ, NomeFornecedor, telefone) values(vCNPJ, vNomeFornecedor, vTelefone);
end
$$

describe tbCidade;
delimiter $$
create procedure spInsertCidade(vIdCidade int, vCidade varchar(200))
begin
	insert into tbCidade(idCidade, Cidade) values (vIdCidade, vCidade);
end
$$

describe tbUF;
delimiter $$
create procedure spInsertUF(vIdUf int, vEstado varchar(200))
begin
	insert into tbUF(IdUf,UF) values (vIdUf,vEstado);
end
$$

describe tbBairro;
delimiter $$
create procedure spInsertBairro(vIdBairro int, vBairro varchar(200))
begin
	insert into tbBairro(IdBairro,Bairro) values (vIdBairro,vBairro);
end
$$

describe tbProduto;
delimiter $$
create procedure spInsertProduto(vCodigoBarras decimal(14,0), vNome varchar(200), vValor decimal(5,2), vQtd int)
begin
	insert into tbProduto(CodigoBarras,NomeProd,Valor,Qtd) values (vCodigoBarras,vNome,vValor,vQtd);
end
$$
/*
describe tbEndereco;
delimiter $$
create procedure spInsertEndereco(vCep decimal(8,0),vLogradouro varchar(200),vBairro int, vCidade int, vEstado int)
begin
if (true) then
	select "ok";
end if;
	insert into tbEndereco(CEP,Logradouro,IdBairro,IdCidade,IdUF) values (vCep,vLogradouro,vBairro,vCidade,vEstado);
end
$$*/

call spInsertFornecedor(1245678937123, "Revenda Chico Loco", 11934567897);
call spInsertFornecedor(1345678937123, "José Faz Tudo S/A", 11934567898);
call spInsertFornecedor(1445678937123, "Vadalto Entregas", 11934567899);
call spInsertFornecedor(1545678937123, "Astrogildo das Estrelas", 11934567800);
call spInsertFornecedor(1645678937123, "Amoroso e Doce", 11934567801);
call spInsertFornecedor(1745678937123, "Marcelo Dedal", 11934567802);
call spInsertFornecedor(1845678937123, "Franciscano Cachaça", 11934567803);
call spInsertFornecedor(1945678937123, "Joãozinho Chupeta", 11934567804);

select * from tbFornecedor;

call spInsertCidade(1, "Rio de Janeiro");
call spInsertCidade(2, "São Carlos");
call spInsertCidade(3, "Campinas");
call spInsertCidade(4, "Franco da Rocha");
call spInsertCidade(5, "Osasco");
call spInsertCidade(6, "Pirituba");
call spInsertCidade(7, "Lapa");
call spInsertCidade(8, "Ponta Grossa");

select * from tbCidade;

call spInsertUF(1, "SP");
call spInsertUF(2, "RJ");
call spInsertUF(3, "RS");

select * from tbUF;

call spInsertBairro(1, "Aclimação");
call spInsertBairro(2, "Capão Redondo");
call spInsertBairro(3, "Pirituba");
call spInsertBairro(4, "Liberdade");

select * from tbBairro;

call spInsertProduto(12345678910111,'Rei de Papel Mache',54.61,120);
call spInsertProduto(12345678910112,'Bolinha de Sabão',100.45,120);
call spInsertProduto(12345678910113,'Barro Bate Bate',44.00,120);
call spInsertProduto(12345678910114,'Bola Furada',10.00,120);
call spInsertProduto(12345678910115,'Maçã Laranja',99.44,120);
call spInsertProduto(12345678910116,'Boneco do Hitler',124.00,200);
call spInsertProduto(12345678910117,'Farinha de Surui',50.00,200);
call spInsertProduto(12345678910118,'Zelador de Cemitério',24.50,100);

select * from tbProduto;
/*
call spInsertProduto('cep,Lougradouro,Bairro,cidade,uf');
call spInsertProduto(12345054,'Lougra',,120);
call spInsertProduto(12345054,'Lougra',,120);
call spInsertProduto(12345054,'Lougra',,120);
call spInsertProduto(12345054,'Lougra',,120);
call spInsertProduto(12345054,'Lougra',,120);
call spInsertProduto(12345054,'Lougra',,120);
call spInsertProduto(12345054,'Lougra',,120);
call spInsertProduto(12345054,'Lougra',,120);

select * from tbEndereco;*/