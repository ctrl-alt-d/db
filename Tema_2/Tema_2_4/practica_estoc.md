# Pràctica comanda de producte

## Primera part:

Observa aquestes taules:

```sql
create table productes
(
    id int not null primary key,
    nom varchar(200) not null unique
);

create table variacio_stock
(
    id int identity(1,1) not null primary key,
    moment datetime default(getdate()),
    id_producte int not null references productes(id),
    quantitat int not null,
    motiu varchar(200)
)

create table comanda
(
    id int identity(1,1) not null primary key,
    moment datetime default(getdate()),
    client varchar(300) not null,
    id_producte int not null references productes(id),
    quantitat int not null
)

insert into productes values
(1, 'Patates'),
(2, 'Cebes');

insert into variacio_stock (id_producte, quantitat, motiu) values
(1, 100, 'Compra'),
(1, -10, 'Commanda'),
(1, -10, 'Caduca gènere'),
(2, 100, 'Compra');

```

Fes el procediment emmagatzemat `add_comanda`. El procediment rep els paràmetres `client`, `id_producte`i `quantitat`i inserta una `comanda` i la `variació d'estoc`.

Validacions:
- El producte existeix.
- El producte té prou stock (suma de l'stock del producte)

Accions:
- Insertar la comanda
- Insertar la variació d'stock

Provatures:
- Comprovar que si hi ha estoc pots fer comanda.
- Comprovar que si no hi ha estoc no pots fer comanda.

Argumenta el nivell d'isolació

## Segona part

Com et pots haver detectat, aquest sistema anirà cada cop més lent perquè cada cop haurà de sumar més variacions d'estoc. A banda, ens cal un nivell d'isolació molt alt. Canviant una mica l'estructura de taules pots optimitzar molt el procés, a cost de tenir informació 'redundant' (emmagatzemar informació que podríes tenir calculant).

Fes la proposta de canvi i proposa i argumenta el nou nivell d'isolació amb el que podem treballar:
- Alter tables
- Alter procedure
- Argumentar nivell d'isolació