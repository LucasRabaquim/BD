drop database dbDistribuidora;
create database dbDistribuidora;
use dbDistribuidora;

create table tbCompra(
	IdCompra int primary key,
    QuantProd int not null,
    PrecoProd decimal(6,2) not null,
    DataCompra datetime not null
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
	IdPedido int primary key,
    QuantidadePedido int not null,
    PrecoPedido decimal(6,2) not null,
    HoraPedido time
);
create table tbCliente(
	IdCliente int auto_increment primary key,
    NomeCliente varchar(200) not null,
    NumEnd int(6),
    ComEnd varchar(50),
    CepCli int(8)
);
create table tbClientePF(
	CPF char(11) primary key,
    RG int(9) not null,
    RG_Dig int(1) not null,
    Nasc date not null
);
create table tbClientePJ(
	CNPJ char(14) primary key,
    IE int(11) unique not null
);

create table tbCompra_tbProd(
	IdCompra int,
    IdProd int,
    primary key(IdCompra,IdProd)
);
alter table tbCompra_tbProd add constraint FK_IdProd_tbCompra_tbProd foreign key (IdProd) references tbProduto(IdProd);
alter table tbCompra_tbProd add constraint FK_IdCompra_tbCompra_tbProd foreign key (IdCompra) references tbCompra(IdCompra);

create table tbCompra_tbFornecedor(
	IdCompra int,
    IdFornecedor int,
    primary key(IdCompra,IdFornecedor)
);
alter table tbCompra_tbFornecedor add constraint FK_IdFornecedor_tbCompra_tbFornecedor foreign key (IdFornecedor) references tbFornecedor(IdFornecedor);
alter table tbCompra_tbFornecedor add constraint FK_IdCompra_tbCompra_tbFornecedor foreign key (IdCompra) references tbCompra(IdCompra);

create table tbPedido_Cliente(
	IdPedido int,
    IdCliente int,
    primary key(IdPedido,IdCliente)
);
alter table tbPedido_Cliente add constraint FK_IdPedido_tbPedido_Cliente foreign key (IdCliente) references tbCliente(IdCliente);
alter table tbPedido_Cliente add constraint FK_IdCliente_tbPedido_Cliente foreign key (IdPedido) references tbPedido(IdPedido);

create table tbPedido_NotaFiscal(
	IdPedido int,
    IdNf int,
    primary key(IdPedido,IdNf)
);
alter table tbPedido_NotaFiscal add constraint FK_IdPedido_tbPedido_NotaFiscal foreign key (IdNf) references tbNotaFiscal(IdNf);
alter table tbPedido_NotaFiscal add constraint FK_IdCliente_tbPedido_NotaFiscal foreign key (IdPedido) references tbPedido(IdPedido);

create table tbPedido_produto(
	IdPedido int,
    IdProd int,
    primary key(IdPedido, IdProd)
);
alter table tbPedido_produto add constraint FK_IdPedido_tbPedido_produto foreign key (IdPedido) references tbPedido(IdPedido);
alter table tbPedido_produto add constraint FK_IdProd_tbPedido_produto foreign key (IdProd) references tbProduto(IdProd);


create table tbEndereco(
	CEP int primary key,
    Logradouro varchar(200),
    IdBairro int not null,
    IdCidade int not null,
    IdUF int not null
);

create table tbCliente_endereco(
	IdCliente int,
    CEP int,
    primary key(IdCliente,CEP)
);
alter table tbCliente_endereco add constraint FK_IdCliente_tbCliente_endereco foreign key (IdCliente) references tbCliente(IdCliente);
alter table tbCliente_endereco add constraint FK_CEP_tbCliente_endereco foreign key (CEP) references tbEndereco(CEP);

create table tbBairro(
    IdBairro int primary key,
    Bairro varchar(200) not null
);
create table tbCidade(
    IdCidade int primary key
);
create table tbUF(
    IdUF int primary key
);
alter table tbEndereco add constraint FK_IdBairro_tbEndereco foreign key (IdBairro) references tbBairro(IdBairro);
alter table tbEndereco add constraint FK_IdCidade_tbEndereco foreign key (IdCidade) references tbCidade(IdCidade);
alter table tbEndereco add constraint FK_IdUF_tbEndereco foreign key (IdUF) references tbUF(IdUF);

