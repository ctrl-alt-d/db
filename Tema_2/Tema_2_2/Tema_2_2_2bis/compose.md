# Instal·lar Sakila per a PostgreSQL

## Què instal·larem?

[Sakila per a PostgreSQL](https://github.com/sakiladb/postgres) és una base de dades d'exemple sobre un videoclub. La imatge `sakiladb/postgres` ja porta les taules i les dades precarregades: no cal importar cap script SQL ni clonar el repositori de Sakila.

Aquesta guia utilitza `sakiladb/postgres:18`, que selecciona PostgreSQL 18. Evitem `latest` perquè pot passar a una altra versió principal. Segons el [repositori original](https://github.com/sakiladb/postgres#available-versions), la imatge està disponible per a equips Intel/AMD i ARM, inclosos els Mac amb Apple Silicon.

## 1. Preparar les eines

Necessites Docker en funcionament, Docker Compose v2 i un client SQL com ara DBeaver. Pots obtenir Docker des de la [guia oficial d'instal·lació](https://docs.docker.com/get-started/get-docker/) i DBeaver des de la seva [pàgina oficial](https://dbeaver.io/download/). Amb Docker Desktop, obre l'aplicació i espera que el motor estigui en funcionament.

Comprova les eines des d'un terminal:

```bash
docker version
docker compose version
```

`docker version` ha de mostrar informació tant del client com del servidor. Si només mostra el client i un error de connexió, el motor Docker encara no està disponible.

## 2. Preparar la carpeta de treball

Si ja tens aquest repositori al teu equip, obre un terminal a la carpeta `Tema_2/Tema_2_2/Tema_2_2_2bis`. El fitxer [compose.yaml](./compose.yaml) ja hi és.

Si vols treballar en una carpeta independent, crea una carpeta anomenada `sakila-practiques` i desa-hi un fitxer `compose.yaml` amb aquest contingut:

```yaml
name: daw-sakila

services:
  sakila:
    image: sakiladb/postgres:18
    ports:
      - "127.0.0.1:5433:5432"
```

- `sakila` és el nom del servei que utilitzarem a les ordres de Compose.
- `5433` és el port al teu ordinador; `5432` és el port de PostgreSQL dins del contenidor. Així es pot mantenir una altra instal·lació de PostgreSQL al port local `5432`.
- `127.0.0.1` limita la connexió a aquest ordinador.
- Les credencials ja estan definides a la imatge; no cal afegir variables `POSTGRES_USER`, `POSTGRES_PASSWORD` ni scripts d'inicialització.

## 3. Baixar la imatge i engegar la base de dades

Executa les ordres següents des de la carpeta que conté `compose.yaml`:

```bash
docker compose pull
docker compose up -d --wait
docker compose ps
```

La primera baixada pot trigar uns minuts. `-d` deixa el servei en segon pla (*background*) i `--wait` espera que superi la comprovació de salut (*health check*) inclosa a la imatge. A `docker compose ps`, comprova que el servei està en execució i mostra l'estat `healthy`.

## 4. Connectar-hi DBeaver

Crea una connexió nova i selecciona **PostgreSQL**. Introdueix els valors següents, que provenen de la [configuració de connexió del projecte](https://github.com/sakiladb/postgres#connection), amb el port local adaptat al nostre fitxer Compose:

| Paràmetre | Valor |
| --- | --- |
| Host | `localhost` |
| Port | `5433` |
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

Si els recomptes no coincideixen, comprova la imatge utilitzada i si has modificat les dades. Pots consultar l'[esquema de treball](./esquema.md) abans de començar els exercicis.

## 5. Alternativa: consultar amb psql

No cal instal·lar `psql` a l'ordinador: pots utilitzar el que ja hi ha dins del contenidor.

```bash
docker compose exec sakila psql -U sakila -d sakila
```

A dins de `psql`, pots executar consultes SQL i aquestes ordres pròpies del client:

```text
\dt public.*
\d film
\q
```

Serveixen per llistar les taules, veure l'estructura de `film` i sortir. Les ordres que comencen amb `\` són de `psql`: no les executis com a SQL a DBeaver.

## 6. Aturar, reprendre i reiniciar la pràctica

Executa aquestes ordres des de la carpeta del fitxer Compose.

Per aturar el servei i conservar el contenidor i les dades:

```bash
docker compose stop
```

Per reprendre'l:

```bash
docker compose start
```

Per tornar a les dades originals, elimina el contenidor i els volums anònims d'aquest projecte i crea'l de nou:

```bash
docker compose down --volumes
docker compose up -d --wait
```

**Aquest últim procediment elimina els canvis fets a la base de dades de pràctiques.** Desa els fitxers `.sql` al teu ordinador. Aquesta configuració utilitza la còpia precarregada de la imatge i no defineix cap volum amb nom per conservar canvis entre recreacions del contenidor.

## Problemes habituals

| Símptoma | Què cal comprovar |
| --- | --- |
| No es pot connectar al motor Docker | Obre Docker Desktop o inicia el servei Docker i repeteix `docker version`. |
| El port `5433` ja està ocupat | Canvia només el port de l'esquerra, per exemple a `127.0.0.1:5434:5432`, i utilitza `5434` a DBeaver. |
| `--wait` no és una opció reconeguda | Actualitza Docker Compose v2. |
| DBeaver rebutja la connexió | Comprova `docker compose ps`, el port `5433` i les credencials exactes, inclòs el zero de `p_ssW0rd`. |
| No apareixen les taules | Comprova que has triat la base de dades `sakila`, desplega `Schemas > public > Tables` i actualitza la vista. |
| El servei no arriba a `healthy` | Consulta `docker compose logs sakila` per identificar l'error. |

Quan hagis comprovat la instal·lació, continua amb les [pràctiques per tema](./readme.md#pràctiques-per-tema).
