drop database dbDistribuidora;
create database dbDistribuidora;
use dbDistribuidora;

create table tbCompra( -- Compra do fornecedor
	IdCompra int auto_increment primary key,
    DataCompra datetime not null
);
create table tbCompraProduto(
	IdCompra int,
    IdProd int,
    IdFornecedor int,
    QuantProd int not null,
    PrecoProd decimal(6,2) not null,
    primary key(IdCompra,IdProd,IdFornecedor)
);
create table tbProduto(
	IdProd int auto_increment primary key,
    NomeProd varchar(100) not null
);
create table tbFornecedor(
	IdFornecedor int auto_increment primary key,
	NomeFornecedor varchar(100) not null,
    Endereco varchar(200) not null
);
create table tbNotaFiscal(
	IdNf int auto_increment primary key,
    DataEmicao dateTime not null,
    Total decimal(7,2) not null,
    --  quantidade, marca, tipo, modelo, espécie, qualidade e demais elementos que permitam sua perfeita identificação;
    IdCliente int
);
create table tbPedido(
	IdNf int,
    IdProd int,
    primary key(IdNf,IdProd),
    QuantidadePedido int not null,
    PrecoPedido decimal(6,2) not null,
    HoraPedido time
);
create table tbCliente(
	IdCliente int auto_increment primary key,
    NomeCliente varchar(100) not null
);
create table tbClienteFis(
	CPF char(11) primary key
);
create table tbClienteJuri(
	CNPJ char(14) primary key
);

alter table tbCompraProduto add constraint FK_IdProd_tbCompraProduto foreign key (IdProd) references tbProduto(IdProd);
alter table tbCompraProduto add constraint FK_IdFornecedor_tbCompraProduto foreign key (IdFornecedor) references tbFornecedor(IdFornecedor);
alter table tbPedido add constraint FK_IdNF_tbPedido foreign key (IdNf) references tbNotaFiscal(IdNf);
alter table tbNotaFiscal add constraint FK_IdCliente_tbNotaFiscal foreign key (IdCliente) references tbCliente(IdCliente);
