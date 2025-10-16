create table Clients (
	-- columnes
	nif varchar(100) not null,
	nom varchar(150) not null,
	email varchar(150) not null,
	-- restriccions
	constraint clients_pk
		primary key(nif),
	constraint client_nom_ak
		unique (nom)
)

insert into clients values
('1', 'dani', 'dani@pepe.com'),
('2', 'coral', 'coral@pepe.com')

drop table factures
create table Factures (
	anyfiscal int not null,
	serie varchar(10) not null,
	numero int not null,
	descripcio varchar(200) not null,
	total float not null,
	data datetime not null,
	cobrada bit not null,
	client_nif varchar(100) not null,
	-- restriccions
	constraint factures_pk
	 primary key (
	 	anyfiscal,
	 	serie,
	 	numero
	 ),
	constraint factures_a_clients_fk
	 foreign key (client_nif)
	 references clients (nif)
	 on update no action
	 on delete no action
)	
	
insert into factures values
(2025, 'A', 1, 'Carregador', 100, '2025-10-16 11:50:00 AM', 0, 1),
(2025, 'A', 2, 'PC i USB', 3000, '2025-10-16 11:50:00 AM', 0, 2)

create table Productes (
	codi varchar(5) not null,
	nom varchar(100) not null,
	refrigerat bit not null,
	preu_venda float not null,
	-- restriccions
	constraint productes_pk
	  primary key (codi)
)

insert into productes values 
('carr', 'carregador', 0, 100),
('pc', 'ordinador personal', 0, 900),
('usb', 'un usb con internet', 0, 100)

create table liniesdefactura (
	factura_anyfiscal int not null,
	factura_serie varchar(10) not null,
	factura_numero int not null,
	producte_codi varchar(5) not null,
	quantitat int,
	-- restriccions
	constraint liniesdefactura_pk
	 primary key (
	 	factura_anyfiscal,
	 	factura_serie,
	 	factura_numero,
	 	producte_codi
	 ),
	constraint liniesdefactura_a_factura_fk
	 foreign key (
	 	factura_anyfiscal,
	 	factura_serie,
	 	factura_numero
	 )
	 references Factures (
	 	anyfiscal,
	 	serie,
	 	numero
	 )
	 on delete CASCADE 
	 on update cascade,
	constraint liniesdefactura_a_producte_fk
	 foreign key (producte_codi)
	 references productes (codi)
	 on update no action
	 on delete no action
)

insert into liniesdefactura values
(2025, 'A', 1, 'carr', 1),
(2025, 'A', 2, 'pc', 3),
(2025, 'A', 2, 'usb', 3)

create table categories (
   nom varchar(100) not null primary key
)

alter table clients add telefon varchar(40) 

alter table productes add categoria_nom varchar(100);

alter table productes add constraint 
  productes_a_categories_fk
  foreign key (categoria_nom)
  references categories(nom)
  on delete set null
  on update cascade;

alter table productes
alter column preu_venda decimal(10,2)  not null;

alter table Factures 
  drop constraint factures_a_clients_fk

alter table Factures ADD 
   constraint factures_a_clients_fk
	 foreign key (client_nif)
	 references clients (nif)
	 on update no action
	 on delete no action
	 
alter table factures drop column cobrada

alter table clients add constraint clients_email_ak
   unique (email)
   
truncate table liniesdefactura;
alter table liniesdefactura drop constraint liniesdefactura_a_factura_fk;
truncate table factures;
delete from factures;
delete from productes;
delete from categories;
delete from clients;

drop table liniesdefactura;
drop table  factures;
drop table  productes;
drop table  categories;
drop table  clients;






