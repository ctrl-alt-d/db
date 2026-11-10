# DML - Consultes

## Introducció

Les consultes SQL són la base per a la recuperació d'informació de les bases de dades relacionals. En aquest tema aprendrem a utilitzar la sentència SELECT i les seves clàusules per extreure i analitzar dades de manera eficient.

Les consultes ens permeten:
- Recuperar dades específiques de les taules
- Filtrar informació segons criteris determinats
- Ordenar els resultats
- Agrupar i agregar dades
- Combinar informació de diverses fonts

## Entorns de proves:

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


### NorthWind (postgres)

* SGBD Base de dades: PostgreSQL
* Usuari: northwind
* Base de dades: northwind
* Password: northwind
* url: https://github.com/bradymholt/docker-postgresql-northwind
* Temàtica: empresa de comerç majorista
* Engegar amb docker: `docker run --rm -it -p 5432:5432 --name postgres-northwind bradymholt/postgres-northwind:latest`


## Índex

* [Conceptes d'àlgebra relacional (selecció, projecció)](./01_algebra.md)
* [Select senzilla](./02_intro_select.md) | [Exercicis](./02_intro_select_exercicis.md)
* [Introduint Where](./03_where.md) | [Exercicis](./03_where_exercicis.md)
* [Introduint Order By](./04_order_by.md) | [Exercicis](./04_order_by_exercicis.md)
* [Introduint funcions d'agregació](./05_funcions_agregacio.md)
* [Introduint Group By](./06_group_by.md) | [Exercicis](./06_group_by_exercicis.md)
* [Introduint Having](./07_having.md) | [Exercicis](./07_having_exercicis.md)
* [Conceptes d'àlgebra relacional (producte cartesià)](./08_algebra_II.md)
* [Introduint Joins](./09_joins.md) | [Exercicis](./09_joins_exercicis.md)
* [Conceptes d'àlgebra relacional (unions, interseccions, diferències)](./10_algebra_III.md)
* [Introduint Subconsultes](./11_subconsultes.md)
* [Introduint Unions i altres operacions avançades](./12_unions.md)
