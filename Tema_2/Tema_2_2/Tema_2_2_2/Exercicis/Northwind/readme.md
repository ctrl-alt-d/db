# Exercicis de consultes amb Northwind (PostgreSQL)

## Objectiu

Practicar els apartats del [Tema 2.2.2. Consultes](../../readme.md) amb una mateixa base de dades: **Northwind**, que representa una empresa de comerç majorista amb productes, categories, proveïdors, clients, empleats i comandes.

Utilitzarem la imatge Docker [bradymholt/postgres-northwind](https://github.com/bradymholt/docker-postgresql-northwind), que ja inclou l'estructura i les dades.

## Entorn de treball

### 1. Preparar les eines

Necessites Docker en funcionament i un client SQL com ara DBeaver. Pots obtenir Docker des de la [guia oficial d'instal·lació](https://docs.docker.com/get-started/get-docker/) i DBeaver des de la seva [pàgina oficial](https://dbeaver.io/download/). Amb Docker Desktop, obre l'aplicació i espera que el motor estigui en funcionament.

### 2. Engegar la base de dades

Executa aquesta ordre des de qualsevol carpeta:

```bash
docker run --rm -it -p 5432:5432 --name postgres-northwind bradymholt/postgres-northwind:latest
```

Què significa cada paràmetre?

- `--rm`: elimina el contenidor (*container*) quan s'atura. Cada vegada que l'engeguis tindràs les dades originals.
- `-it`: manté el contenidor associat al terminal. Deixa aquest terminal obert mentre treballes; per aturar la base de dades, prem `Ctrl+C`.
- `-p 5432:5432`: mapeja el port 5432 del contenidor al port 5432 del teu ordinador.
- `--name postgres-northwind`: assigna un nom al contenidor.
- `bradymholt/postgres-northwind:latest`: indica la imatge que cal utilitzar. Si no la tens, Docker la baixa automàticament; la primera vegada pot trigar uns minuts.

### 3. Connectar-hi DBeaver

Crea una connexió nova, selecciona **PostgreSQL** i introdueix aquests valors:

| Paràmetre | Valor |
| --- | --- |
| Host | `localhost` |
| Port | `5432` |
| Database | `northwind` |
| Username | `northwind` |
| Password | `northwind` |

Prem **Test Connection** i, si DBeaver ho demana, descarrega el controlador (*driver*) de PostgreSQL. Desa la connexió i obre un editor SQL associat a `northwind`.

Comprova la connexió:

```sql
SELECT current_database() AS base_de_dades,
       current_user AS usuari;

SELECT COUNT(*) AS total_productes FROM products;
```

### Problemes habituals

| Símptoma | Què cal comprovar |
| --- | --- |
| No es pot connectar al motor Docker | Obre Docker Desktop o inicia el servei Docker i comprova-ho amb `docker version`. |
| El port `5432` ja està ocupat | Atura l'altre PostgreSQL que l'utilitza (per exemple, `docker stop sakila`) o canvia només el port de l'esquerra, per exemple `-p 5433:5432`, i utilitza `5433` a DBeaver. |
| DBeaver rebutja la connexió | Comprova amb `docker ps` que el contenidor està en execució i revisa el port i les credencials. |
| No apareixen les taules | Comprova que has triat la base de dades `northwind`, desplega `Schemas > public > Tables` i actualitza la vista. |

## Exercicis per tema

La numeració coincideix amb la dels apartats del temari. Els apartats d'àlgebra relacional (01, 08 i 10) no tenen exercicis amb Northwind; els pots practicar amb [Sakila](../Sakila/readme.md).

| Apartat | Contingut del temari | Exercicis amb Northwind |
| --- | --- | --- |
| 02 | [SELECT](../../02_intro_select.md) | [Exercicis de SELECT](./02_intro_select_exercicis.md) |
| 03 | [WHERE](../../03_where.md) | [Exercicis de WHERE](./03_where_exercicis.md) |
| 04 | [ORDER BY](../../04_order_by.md) | [Exercicis d'ORDER BY](./04_order_by_exercicis.md) |
| 05 | [Funcions d'agregació](../../05_funcions_agregacio.md) | [Exercicis de funcions d'agregació](./05_funcions_agregacio_exercicis.md) |
| 06 | [GROUP BY](../../06_group_by.md) | [Exercicis de GROUP BY](./06_group_by_exercicis.md) |
| 07 | [HAVING](../../07_having.md) | [Exercicis de HAVING](./07_having_exercicis.md) |
| 09 | [JOIN](../../09_joins.md) | [Exercicis de JOIN](./09_joins_exercicis.md) |
| 11 | [Subconsultes](../../11_subconsultes.md) | [Exercicis de subconsultes](./11_subconsultes_exercicis.md) |
| 12 | [Operacions de conjunts en SQL](../../12_unions.md) | [Exercicis d'operacions de conjunts](./12_unions_exercicis.md) |

## Com treballarem

- Cada pràctica conté **exemples resolts** i **exercicis sense solució**. Intenta resoldre els exemples abans de desplegar-ne la solució.
- Desa les consultes en fitxers `.sql`, un per tema, amb un comentari que identifiqui cada exercici.
- Mantén els identificadors originals en anglès i utilitza els àlies en català que demani l'enunciat.
- Treballarem amb consultes de lectura; no cal modificar les dades per resoldre els exercicis.
