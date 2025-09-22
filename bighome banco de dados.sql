/* comentario de varias linhas*/
-- comentario de uma linha só

-- criar o banco de dados
CREATE database bighome ;
-- excluir o banco de dados
drop database bighome;
-- comando para usar o banco de dados
use bighome;

-- criar tabelas

create table cliente(
idCliente int primary key auto_increment,
nome varchar(200) not null,
cpf int not null unique,
telefone varchar(20) not null,
email varchar(150) not null,
senha varchar(12) not null,
foto_perfil longblob
);

create table endereco(
idEndereco int primary key auto_increment,
cep int not null,
cidade varchar(150) not null,
estado varchar(100) not null,
numero varchar(100) not null,
complemento varchar(100),
logradouro varchar(100) not null,
bairro varchar(100) not null,
 tipo varchar(20) not null
);
-- tabela com chave estrangeira fk - foreing key
create table cliente_e_endereco(
cliente_idCliente int,
endereco_idEndereco int,

constraint foreign key (cliente_idCliente) references
Cliente(idCliente),
constraint foreign key (endereco_idEndereco) references 
endereco(idEndereco)
);

create table categoria_produtos(
idCategoria_produtos int primary key auto_increment,
nome varchar(50) not null,
desconto double
);

create table banners(
idBanners int primary key auto_increment,
imagem longblob not null,
data_validade date not null,
descricao varchar(50) not null,
link varchar(45),
categoriasprodutos_id int,
constraint foreign key(categoriasprodutos_id)references
categoria_produtos(idCategoria_produtos)
);

create table forma_pagamento(
idForma_pagamento int primary key auto_increment,
nome varchar(45)
);

create table frete(
idFrete int primary key auto_increment,
cidade varchar(45) not null,
valor double not null,
transportadora varchar(45)
);

create table cupom(
idCupom int primary key auto_increment,
nome varchar(50) not null,
valor double not null,
data_validade date not null,
quantidade int not null
);

create table marcas(
idMarcas int primary key auto_increment,
nome varchar(45) not null,
imagem longblob
);

create table imagens_produtos(
idImagem_produtos int primary key auto_increment,
foto longblob not null,
descricao  varchar(45) not null
);

create table vendas(
idVendas int primary key auto_increment,
datavenda datetime not null,
formadepagamento varchar(45) not null,
valor_frete double not null,
valor_produto double not null,
valor_total double not null,
data_entrega datetime not null,
situacao varchar(45) not null,
cod_pix varchar(45),
cod_barras varchar(45),
valor_total_desconto double,
cliente_idcliente int not null,
cupom_idcupom int,
forma_pagameto_idforma_pagamento int,
frete_idfrete int,
constraint foreign key(cliente_idcliente) references cliente(idcliente),
constraint foreign key(cupom_idcupom) references cupom(idcupom),
constraint foreign key(forma_pagameto_idforma_pagamento) references forma_pagamento(idforma_pagamento),
constraint foreign key(frete_idfrete) references frete(idfrete)
);

create table produtos(
idProdutos int primary key auto_increment,
nome varchar(100) not null,
descricao text(500) not null,
quantidade int not null,
preco double not null,
tamanho varchar(45),
codigo int not null ,
preco_promocional double,
marcas_idmarcas int not null,
constraint foreign key(marcas_idmarcas) references marcas(idmarcas)
); 
-- TABELA DE VENDAS E PRODUTOS
create table vendas_e_protudos(
vendas_idvendas int,
produtos_idprodutos int,

constraint foreign key(vendas_idvendas) references vendas(idvendas),
constraint foreign key(produtos_idprodutos) references produtos(idprodutos)
);

-- TABELA DE CATEGORIA PRODUTOS E PRODUTOS
create table categoria_produtos_e_produtos(
categoria_produtos_idcategoria_produtos int,
produtos_idprodutos int,
constraint foreign key(categoria_produtos_idcategoria_produtos) references categoria_produtos(idcategoria_produtos),
constraint foreign key(produtos_idprodutos) references produtos(idprodutos)
);

create table empresa(
idEmpresa int primary key auto_increment,
nome_fantasia varchar(100) not null,
cnpj_cpf varchar(45) not null,
telefone varchar(20) not null,
instagram varchar(100),
linkedin varchar(100),
facebook varchar(100),
whatsapp varchar(100),
logo longblob not null
);

create table loginfuncionario(
idloginfuncionario int primary key auto_increment,
usuario varchar(45) not null,
senha varchar(12) not null,
empresa_idempresa int,
constraint foreign key(empresa_idempresa) references empresa(idempresa)
);

show tables;

-- COMANDOS SQL

/*
create database - cria banco de dados
create table - cria tabelas
use - inicia a execução do banco de dados
*/

/* EXCLUSÃO:
drop database - serve para excluir banco de dados
drop table - exclui tabelas
*/

drop database nomeBancodedados;
drop table nometabela;

/* só é possivel excluir uma tabela caso não tenha nenhuma outra tabela conectada a ela*/

/* select- vizualizar/ listar os dados registrados dentro da tabela */
Select * from cliente;
select idcliente, nome, cpf from cliente;

/* insert - cadastrar dados dentro da tabelas */

insert into nometabela (campo1,campo2,campo3)
values ("",2.7,2);
insert into cliente(nome, cpf, email, telefone, senha)
values ("João Vitor Pinheiro", "07121940108", "joaovitorpinheiroveloso@gmail.com", "63 99219-8915", "jv201205");

/*COMANDO PARA ALTERARC CPF DE INT PARA VARCHAR */
alter table cliente modify cpf varchar(11);
alter table produtos modify tamanho varchar(100);
insert into endereco(cep,cidade,estado,numero,complemento,logradouro,bairro,tipo) values (77183390, "Araguaína","TO",
"2900","Q11 L9","Avenida Jk","setor sul","casa");

select * from endereco;

-- CONECTANDO O CLIENTE COM O SEU ENDEREÇO 
insert into cliente_e_endereco(cliente_idcliente,endereco_idendereco)
values (1,1);

-- inserindo dados para marcas
insert into marcas(nome,imagem) values("tigre","C:\Users\ALUNO\Pictures\tigre.png");

select * from marcas;

-- inserindo dados para a tabela produtos
insert into produtos(nome, descricao,quantidade,preco,tamanho,codigo,marcas_idmarcas) values
("porcelanato", "porcelanato revestimento",20, 199.90, "60x60", "por2200",1);

create table imagens_produtos_e_produtos(
imagens_produtos_idimagem_produtos int,
produtos_idprodutos int,
marcas_idmarcas int,
foreign key(imagens_produtos_idimagem_produtos) references imagens_produtos(idimagem_produtos),
foreign key(produtos_idprodutos) references produtos(idprodutos),
foreign key(marcas_idmarcas) references marcas(idmarcas)
);

insert into 
