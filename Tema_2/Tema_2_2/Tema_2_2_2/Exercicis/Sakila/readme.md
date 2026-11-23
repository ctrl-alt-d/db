# Pràctiques de consultes amb Sakila (PostgreSQL)

## Objectiu

Aplicar tots els apartats del [Tema 2.2.2. Consultes](../../readme.md) a una mateixa base de dades: **Sakila**, que representa un videoclub amb pel·lícules, actors, clients, còpies disponibles, lloguers i pagaments.

Utilitzarem la distribució [sakiladb/postgres](https://github.com/sakiladb/postgres). La imatge Docker ja inclou l'estructura i les dades.

## Entorn de treball

La imatge `sakiladb/postgres` ja porta les taules i les dades precarregades: no cal importar cap script SQL ni clonar el repositori de Sakila. Segons el [repositori original](https://github.com/sakiladb/postgres#available-versions), està disponible per a equips Intel/AMD i ARM, inclosos els Mac amb Apple Silicon.

Si ja tens el contenidor creat d'una sessió anterior, n'hi ha prou amb `docker start sakila`.

### 1. Preparar les eines

Necessites Docker en funcionament i un client SQL com ara DBeaver. Pots obtenir Docker des de la [guia oficial d'instal·lació](https://docs.docker.com/get-started/get-docker/) i DBeaver des de la seva [pàgina oficial](https://dbeaver.io/download/). Amb Docker Desktop, obre l'aplicació i espera que el motor estigui en funcionament.

Comprova-ho des d'un terminal:

```bash
docker version
```

L'ordre ha de mostrar informació tant del client com del servidor. Si només mostra el client i un error de connexió, el motor Docker encara no està disponible.

### 2. Baixar la imatge i engegar la base de dades

Executa aquesta ordre des de qualsevol carpeta:

```bash
docker run --name sakila -p 5432:5432 -d sakiladb/postgres:latest
```

Què significa cada paràmetre?

- `--name sakila`: assigna el nom `sakila` al contenidor (*container*), per poder-lo gestionar després còmodament.
- `-p 5432:5432`: mapeja el port 5432 del contenidor al port 5432 del teu ordinador.
- `-d`: executa el contenidor en segon pla (*background*).
- `sakiladb/postgres:latest`: indica la imatge que cal utilitzar. Si no la tens, Docker la baixa automàticament; la primera vegada pot trigar uns minuts.

Les credencials ja estan definides a la imatge; no cal afegir variables `POSTGRES_USER` ni `POSTGRES_PASSWORD`.

Comprova que el contenidor està en execució:

```bash
docker ps
```

La base de dades pot necessitar uns segons per estar disponible. Si el contenidor no apareix a la llista, consulta `docker logs sakila`.

### 3. Connectar-hi DBeaver

Crea una connexió nova i selecciona **PostgreSQL**. Introdueix els valors següents, que provenen de la [configuració de connexió del projecte](https://github.com/sakiladb/postgres#connection):

| Paràmetre | Valor |
| --- | --- |
| Host | `localhost` |
| Port | `5432` |
| Database | `sakila` |
| Username | `sakila` |
| Password | `p_ssW0rd` |
| Schema | `public` |

Prem **Test Connection** i, si DBeaver ho demana, descarrega el controlador (*driver*) de PostgreSQL. Desa la connexió i obre un editor SQL associat a `sakila`.

Comprova la connexió:

```sql
SELECT current_database() AS base_de_dades,
       current_user AS usuari;

SELECT COUNT(*) AS total_actors FROM actor;
SELECT COUNT(*) AS total_pellicules FROM film;
SELECT COUNT(*) AS total_clients FROM customer;
SELECT COUNT(*) AS total_lloguers FROM rental;
SELECT COUNT(*) AS total_pagaments FROM payment;
```

Amb les dades de referència de la imatge, els recomptes són:

| Taula | Files |
| --- | ---: |
| `actor` | 200 |
| `film` | 1000 |
| `customer` | 599 |
| `rental` | 16044 |
| `payment` | 16049 |

Si els recomptes no coincideixen, comprova la imatge utilitzada i si has modificat les dades.

### 4. Alternativa: consultar amb psql

No cal instal·lar `psql` a l'ordinador: pots utilitzar el que ja hi ha dins del contenidor.

```bash
docker exec -it sakila psql -U sakila -d sakila
```

A dins de `psql`, pots executar consultes SQL i aquestes ordres pròpies del client:

```text
\dt public.*
\d film
\q
```

Serveixen per llistar les taules, veure l'estructura de `film` i sortir. Les ordres que comencen amb `\` són de `psql`: no les executis com a SQL a DBeaver.

### 5. Aturar, reprendre i reiniciar la pràctica

Per aturar el contenidor i conservar-ne les dades:

```bash
docker stop sakila
```

Per reprendre'l:

```bash
docker start sakila
```

Per tornar a les dades originals, elimina el contenidor i crea'l de nou:

```bash
docker rm -f sakila
docker run --name sakila -p 5432:5432 -d sakiladb/postgres:latest
```

**Aquest últim procediment elimina els canvis fets a la base de dades de pràctiques.** Desa els fitxers `.sql` al teu ordinador.

### Problemes habituals

| Símptoma | Què cal comprovar |
| --- | --- |
| No es pot connectar al motor Docker | Obre Docker Desktop o inicia el servei Docker i repeteix `docker version`. |
| El port `5432` ja està ocupat | Atura l'altre PostgreSQL que l'utilitza (per exemple, `docker stop postgres1`) o canvia només el port de l'esquerra, per exemple `-p 5433:5432`, i utilitza `5433` a DBeaver. |
| El nom `sakila` ja està en ús | Ja havies creat el contenidor: reprèn-lo amb `docker start sakila` o elimina'l amb `docker rm -f sakila`. |
| DBeaver rebutja la connexió | Comprova `docker ps`, el port `5432` i les credencials exactes, inclòs el zero de `p_ssW0rd`. |
| No apareixen les taules | Comprova que has triat la base de dades `sakila`, desplega `Schemas > public > Tables` i actualitza la vista. |
| El contenidor s'atura tot sol | Consulta `docker logs sakila` per identificar l'error. |

Quan hagis comprovat la instal·lació, consulta les [taules, les columnes i les relacions de Sakila](./esquema.md) i continua amb les pràctiques.

## Pràctiques per tema

La numeració coincideix amb els 12 apartats del temari. Fes-los en aquest ordre: les primeres consultes utilitzen una sola taula; les composicions entre taules s'introdueixen als apartats 08 i 09.

| Apartat | Contingut del temari | Pràctica amb Sakila |
| --- | --- | --- |
| 01 | [Àlgebra relacional: selecció i projecció](../../01_algebra.md) | [Selecció i projecció](./01_algebra_exercicis.md) |
| 02 | [SELECT](../../02_intro_select.md) | [Columnes, àlies, expressions i DISTINCT](./02_intro_select_exercicis.md) |
| 03 | [WHERE](../../03_where.md) | [Condicions, intervals, patrons i NULL](./03_where_exercicis.md) |
| 04 | [ORDER BY](../../04_order_by.md) | [Ordenació, desempats i paginació](./04_order_by_exercicis.md) |
| 05 | [Funcions d'agregació](../../05_funcions_agregacio.md) | [COUNT, SUM, AVG, MIN i MAX](./05_funcions_agregacio_exercicis.md) |
| 06 | [GROUP BY](../../06_group_by.md) | [Resums per grup i agrupacions múltiples](./06_group_by_exercicis.md) |
| 07 | [HAVING](../../07_having.md) | [Filtres sobre els grups](./07_having_exercicis.md) |
| 08 | [Àlgebra relacional: producte cartesià](../../08_algebra_II.md) | [Producte cartesià i CROSS JOIN](./08_algebra_II_exercicis.md) |
| 09 | [JOIN](../../09_joins.md) | [Composicions internes, externes i amb la mateixa taula](./09_joins_exercicis.md) |
| 10 | [Àlgebra relacional: operacions de conjunts](../../10_algebra_III.md) | [Conjunts i INNER JOIN amb projecció, selecció i producte cartesià](./10_algebra_III_exercicis.md) |
| 11 | [Subconsultes](../../11_subconsultes.md) | [Subconsultes escalars, IN, EXISTS i correlacionades](./11_subconsultes_exercicis.md) |
| 12 | [Operacions de conjunts en SQL](../../12_unions.md) | [UNION, UNION ALL, INTERSECT i EXCEPT](./12_unions_exercicis.md) |

## Com treballarem

- Cada pràctica conté **dos exemples resolts** i **exercicis sense solució**. Intenta resoldre els exemples abans de desplegar-ne la solució.
- Desa les consultes en fitxers `.sql`, un per tema, amb un comentari que identifiqui cada exercici. Escriu les expressions d'àlgebra relacional en un document Markdown o en paper.
- Mantén els identificadors originals en anglès i utilitza els àlies en català que demani l'enunciat.
- Retorna només les columnes demanades. Quan es demani ordenació, respecta també els desempats.
- Al tema 01 i al bloc de composicions del tema 10 es demanen expressions d'àlgebra relacional. Als altres exercicis d'àlgebra, afegeix la consulta SQL equivalent quan s'indiqui.
- Explica breument els resultats que et sorprenguin: una resposta buida també pot ser correcta.
- Treballarem amb consultes de lectura; no cal modificar les dades per resoldre els exercicis.

## Comprovació del treball

Abans de donar una resposta per acabada, comprova quina informació representa cada fila, si hi pot haver duplicats, com es tracten els valors `NULL` i si els filtres s'apliquen abans o després de l'agrupació. Distingir una pel·lícula d'una còpia d'inventari o d'un lloguer és essencial per comptar correctament.
