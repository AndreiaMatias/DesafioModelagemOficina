/*Projeto lógico oficina*/

CREATE DATABASE oficina;

USE oficina;

CREATE TABLE CLIENTE
(
	idCliente int primary key auto_increment,
	nome varchar(45) not null,
    cpf varchar(11) not null,
    endereco varchar(100) not null,
    telefone varchar(11),
    constraint fk_cpf unique(cpf)
);

CREATE TABLE VEICULO
(
	idVeiculo int primary key auto_increment,
    tipo varchar(45) not null,
    marca varchar(45) not null,
    modelo varchar(45) not null,
    ano int not null,
    idCliente int not null,
    constraint fk_cliente_veiculo foreign key (idCliente) references Cliente(idCliente)
);

CREATE TABLE EQUIPE
(
	idequipe int primary key auto_increment,
    responsavel varchar(45) not null
);

CREATE TABLE MECANICO
(
	idMecanico int primary key auto_increment,
    nome varchar(45) not null,
    endereco varchar(45) not null,
    especialidade varchar(45) not null,
    idEquipe int not null,
    constraint fk_mecanico_equipe foreign key (idEquipe) references Equipe(idEquipe)
);

CREATE TABLE SERVICOS
(
	idServicos int primary key auto_increment,
    descricao varchar(45) not null,
    valor double not null
);

CREATE TABLE PECAS
(
	idPecas int primary key auto_increment,
    descricao varchar(45) not null,
    valor double not null
);

CREATE TABLE ORDEMSERVICO
(
	idOrdemServico int primary key auto_increment,
    idEquipe int not null, 
    status enum('Novo', 'Em avaliação', 'Aprovado pela Equipe. Aguarda aprovação do cliente', 'Aprovado pelo cliente', 'Em execução', 'Aguardando pagamento', 'Finalizado')  not null,
    dataEmissao date not null,
    dataConclusao date,
    idCliente int not null,
    constraint fk_ordemservico_equipe foreign key (idEquipe) references Equipe(idEquipe),
    constraint fk_ordemservico_cliente foreign key (idCliente) references Cliente(idCliente)
);

CREATE TABLE ORDEMSERVICOS_TEM_SERVICOS
(
    idOrdemServicos int not null,
    idServicos int not null,
    quantidade int not null default 1,
    idEquipe int not null,
    primary key(idOrdemServicos, idServicos),
    constraint fk_ordemServicos foreign key (idOrdemServicos) references OrdemServico(idOrdemServico),
    constraint fk_servicos foreign key (idServicos) references Servicos(idServicos),
    constraint fk_equipe foreign key (idEquipe) references Equipe(idEquipe)
);

CREATE TABLE ORDEMSERVICOS_TEM_PECAS
(
    idOrdemServicos int not null,
    idServicos int not null,
    quantidade int not null default 1,
    idEquipe int not null,
    primary key(idOrdemServicos, idServicos),
    constraint fk_ordemServicos_pecas foreign key (idOrdemServicos) references OrdemServico(idOrdemServico),
    constraint fk_servicos_pecas foreign key (idServicos) references Servicos(idServicos),
    constraint fk_equipe_pecas foreign key (idEquipe) references Equipe(idEquipe)
);

