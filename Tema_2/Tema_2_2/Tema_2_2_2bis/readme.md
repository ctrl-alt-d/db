# Pràctiques de consultes amb Sakila (PostgreSQL)

## Objectiu

Aplicar tots els apartats de [Tema 2.2.2. Consultes](../Tema_2_2_2/readme.md) a una mateixa base de dades: **Sakila**, que representa un videoclub amb pel·lícules, actors, clients, còpies disponibles, lloguers i pagaments.

Utilitzarem la distribució [sakiladb/postgres](https://github.com/sakiladb/postgres). La imatge Docker ja inclou l'estructura i les dades. Les pràctiques estan preparades per a `sakiladb/postgres:18`.

## Abans de començar

1. Segueix la [guia d'instal·lació amb Docker Compose i connexió amb DBeaver](./compose.md).
2. Consulta les [taules, les columnes i les relacions de Sakila](./esquema.md).
3. Comprova que estàs connectat a la base de dades `sakila` i a l'esquema (*schema*) `public`.

## Pràctiques per tema

La numeració coincideix amb els 12 apartats del temari. Fes-los en aquest ordre: les primeres consultes utilitzen una sola taula; les composicions entre taules s'introdueixen als apartats 08 i 09.

| Apartat | Contingut del temari | Pràctica amb Sakila |
| --- | --- | --- |
| 01 | [Àlgebra relacional: selecció i projecció](../Tema_2_2_2/01_algebra.md) | [Selecció i projecció](./01_algebra_exercicis.md) |
| 02 | [SELECT](../Tema_2_2_2/02_intro_select.md) | [Columnes, àlies, expressions i DISTINCT](./02_intro_select_exercicis.md) |
| 03 | [WHERE](../Tema_2_2_2/03_where.md) | [Condicions, intervals, patrons i NULL](./03_where_exercicis.md) |
| 04 | [ORDER BY](../Tema_2_2_2/04_order_by.md) | [Ordenació, desempats i paginació](./04_order_by_exercicis.md) |
| 05 | [Funcions d'agregació](../Tema_2_2_2/05_funcions_agregacio.md) | [COUNT, SUM, AVG, MIN i MAX](./05_funcions_agregacio_exercicis.md) |
| 06 | [GROUP BY](../Tema_2_2_2/06_group_by.md) | [Resums per grup i agrupacions múltiples](./06_group_by_exercicis.md) |
| 07 | [HAVING](../Tema_2_2_2/07_having.md) | [Filtres sobre els grups](./07_having_exercicis.md) |
| 08 | [Àlgebra relacional: producte cartesià](../Tema_2_2_2/08_algebra_II.md) | [Producte cartesià i CROSS JOIN](./08_algebra_II_exercicis.md) |
| 09 | [JOIN](../Tema_2_2_2/09_joins.md) | [Composicions internes, externes i amb la mateixa taula](./09_joins_exercicis.md) |
| 10 | [Àlgebra relacional: operacions de conjunts](../Tema_2_2_2/10_algebra_III.md) | [Conjunts i INNER JOIN amb projecció, selecció i producte cartesià](./10_algebra_III_exercicis.md) |
| 11 | [Subconsultes](../Tema_2_2_2/11_subconsultes.md) | [Subconsultes escalars, IN, EXISTS i correlacionades](./11_subconsultes_exercicis.md) |
| 12 | [Operacions de conjunts en SQL](../Tema_2_2_2/12_unions.md) | [UNION, UNION ALL, INTERSECT i EXCEPT](./12_unions_exercicis.md) |

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
