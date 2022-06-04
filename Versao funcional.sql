drop database dbDistribuidora;
create database dbDistribuidora;
use dbDistribuidora;

create table tbCliente(
	IdCli int primary key auto_increment,
    NomeCli varchar(200) not null,
    NumEnd int(6) not null,
    CompEnd varchar(50),
    CepCli int(8) not null
);

create table tbClientePF(
	CPF int(11) primary key,
    RG int(9) not null,
    RG_Dig char(1) not null,
    Nasc date not null,
    IdCli int unique not null 
); 

create table tbClientePJ(
	CNPJ int(14) primary key,
    IE int(11) unique,
    IdCli int unique not null 
);

create table tbProduto(
	CodigoBarras int primary key,
    NomeProd varchar(200) not null,
    Valor decimal(5,2),
    Qtd int
);

create table tbCompra(
	CodigoCompra int(10) primary key,
    DataCompra datetime not null,
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
    CodigoBarras int(14),
    ValorItem decimal(5,2) not null,
    Qtd int not null,
    primary key(NotaFiscal,CodigoBarras)
);

create table tbFornecedor(
	IdFornecedor int auto_increment primary key,
    CNPJ int(11) not null,
    NomeFornecedor varchar(100) not null,
    telefone int(11) not null
);

create table tbPedido(
	NotaFiscalPedido int primary key,
    DataCompra date not null,
    ValorTotal decimal (6,2) not null,
    QtdTotal int not null
);

create table tbPedidoFornecedor(
	NotaFiscalPedido int,
    IdFornecedor int,
    primary key(NotaFiscalPedido,IdFornecedor)
);

create table tbPedidoProduto(
	NotaFiscalPedido int,
    CodigoBarras int,
    primary key(NotaFiscalPedido,CodigoBarras)
);

create table tbEndereco(
	CEP int primary key,
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

alter table tbPedidoFornecedor add foreign key (NotaFiscalPedido) references tbPedido(NotaFiscalPedido);
alter table tbPedidoFornecedor add foreign key (IdFornecedor) references tbFornecedor(IdFornecedor);

alter table tbPedidoProduto add foreign key (NotaFiscalPedido) references tbPedido(NotaFiscalPedido);
alter table tbPedidoProduto add foreign key (CodigoBarras) references tbProduto(CodigoBarras);

alter table tbEndereco add foreign key (IdBairro) references tbBairro(IdBairro);
alter table tbEndereco add foreign key (IdCidade) references tbCidade(IdCidade);
alter table tbEndereco add foreign key (IdUF) references tbUF(IdUF);






