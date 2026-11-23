# DML - Consultes

## Introducció

Les consultes SQL són la base per a la recuperació d'informació de les bases de dades relacionals. En aquest tema aprendrem a utilitzar la sentència SELECT i les seves clàusules per extreure i analitzar dades de manera eficient.

Les consultes ens permeten:
- Recuperar dades específiques de les taules
- Filtrar informació segons criteris determinats
- Ordenar els resultats
- Agrupar i agregar dades
- Combinar informació de diverses fonts

## Exercicis

Cada apartat del tema es pot practicar amb dos jocs d'exercicis. Tots dos inclouen exemples resolts i exercicis sense solució, i cadascun té una pàgina amb les instruccions per instal·lar l'entorn i connectar-s'hi:

* [Exercicis amb Northwind](./Exercicis/Northwind/readme.md): empresa de comerç majorista.
* [Exercicis amb Sakila](./Exercicis/Sakila/readme.md): videoclub. Inclou també pràctiques d'àlgebra relacional.

Totes dues bases de dades utilitzen el port `5432`: atura'n una abans d'engegar l'altra.

## Altres entorns de proves

Aquests entorns es poden executar directament dins docker o dins docker compose:

### Pagila

* SGBD Base de dades: PostgreSQL
* Usuari: postgres
* Base de dades: pagila
* Password: 123456
* url: https://github.com/devrimgunduz/pagila
* Temàtica: Videoclub

Instruccions:

1. Clonar el repositori
2. A la carpeta fer `docker compose up`
3. Connectar-nos amb les credencials.

### Accidents amb víctimes

* SGBD Base de dades: PostgreSQL
* Usuari: postgres
* Base de dades: posgres
* Password: 123456
* url: https://github.com/ctrl-alt-d/AccidentsAmbVictimes
* Temàtica: Dataset d'accidents amb víctimes a Catalunya


Instruccions:

1. Clonar el repositori
2. A la carpeta fer executar el docker segons quina bd volguem:
   1. PostgreSQL `docker compose --profile postgres up --build`
   2. MySQL `docker compose --profile mysql up --build`
   3. SQL Server (Azure SQL Edge) `docker compose --profile sqlserver up --build`
3. Connectar-nos amb les credencials segons base de dades (consultar la web).

Nota: És només una taula


### Northwind i Sakila

Són les bases de dades dels exercicis d'aquest tema. Trobaràs les instruccions a les pàgines d'[exercicis amb Northwind](./Exercicis/Northwind/readme.md#entorn-de-treball) i d'[exercicis amb Sakila](./Exercicis/Sakila/readme.md#entorn-de-treball).


## Índex

* [Conceptes d'àlgebra relacional (selecció, projecció)](./01_algebra.md) | [Exercicis amb Sakila](./Exercicis/Sakila/01_algebra_exercicis.md)
* [Select senzilla](./02_intro_select.md) | [Exercicis amb Northwind](./Exercicis/Northwind/02_intro_select_exercicis.md) | [Exercicis amb Sakila](./Exercicis/Sakila/02_intro_select_exercicis.md)
* [Introduint Where](./03_where.md) | [Exercicis amb Northwind](./Exercicis/Northwind/03_where_exercicis.md) | [Exercicis amb Sakila](./Exercicis/Sakila/03_where_exercicis.md)
* [Introduint Order By](./04_order_by.md) | [Exercicis amb Northwind](./Exercicis/Northwind/04_order_by_exercicis.md) | [Exercicis amb Sakila](./Exercicis/Sakila/04_order_by_exercicis.md)
* [Introduint funcions d'agregació](./05_funcions_agregacio.md) | [Exercicis amb Northwind](./Exercicis/Northwind/05_funcions_agregacio_exercicis.md) | [Exercicis amb Sakila](./Exercicis/Sakila/05_funcions_agregacio_exercicis.md)
* [Introduint Group By](./06_group_by.md) | [Exercicis amb Northwind](./Exercicis/Northwind/06_group_by_exercicis.md) | [Exercicis amb Sakila](./Exercicis/Sakila/06_group_by_exercicis.md)
* [Introduint Having](./07_having.md) | [Exercicis amb Northwind](./Exercicis/Northwind/07_having_exercicis.md) | [Exercicis amb Sakila](./Exercicis/Sakila/07_having_exercicis.md)
* [Conceptes d'àlgebra relacional (producte cartesià)](./08_algebra_II.md) | [Exercicis amb Sakila](./Exercicis/Sakila/08_algebra_II_exercicis.md)
* [Introduint Joins](./09_joins.md) | [Exercicis amb Northwind](./Exercicis/Northwind/09_joins_exercicis.md) | [Exercicis amb Sakila](./Exercicis/Sakila/09_joins_exercicis.md)
* [Conceptes d'àlgebra relacional (unions, interseccions, diferències)](./10_algebra_III.md) | [Exercicis amb Sakila](./Exercicis/Sakila/10_algebra_III_exercicis.md)
* [Introduint Subconsultes](./11_subconsultes.md) | [Exercicis amb Northwind](./Exercicis/Northwind/11_subconsultes_exercicis.md) | [Exercicis amb Sakila](./Exercicis/Sakila/11_subconsultes_exercicis.md)
* [Introduint Unions i altres operacions avançades](./12_unions.md) | [Exercicis amb Northwind](./Exercicis/Northwind/12_unions_exercicis.md) | [Exercicis amb Sakila](./Exercicis/Sakila/12_unions_exercicis.md)
