# Tema 2: Bases de dades realacionals

## Contingut

+ Tema 2.1. [DDL I - Data Definition Language](./Tema_2_1/readme.md)
* Tema 2.2. [DML - Data Manipulation Language](./Tema_2_2/readme.md)
* Tema 2.3. [Transaccions (RA4)](./Tema_2_3/readme.md)
* Tema 2.4. [Procediments emmagatzemats (RA5)](./Tema_2_4/readme.md)
* Tema 2.5. [DDL II - Data Definition Language](./Tema_2_5/readme.md)

## Entorn

Per treballar amb bases de dades relacionals, inicialment, farem servir MS SQL Server dins docker i DBeaver com a client.

Un cop instal·lat Docker, podem baixar la imatge de MS SQL Server i crear un contenidor amb les següents comandes:

```bash
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=@DAW2025" -p 1433:1433 --name sql1 --hostname sql1 -d mcr.microsoft.com/mssql/server:2022-latest
```

Què significa cada paràmetre?
- `-e "ACCEPT_EULA=Y"`: Accepta l'acord de llicència.
- `-e "MSSQL_SA_PASSWORD=@DAW2025"`: Defineix la contrasenya per l'usuari `sa`.
- `-p 1433:1433`: Mapeja el port 1433 del contenidor al port 1433 de la màquina host.
- `--name sql1`: Assigna el nom `sql1` al contenidor.
- `--hostname sql1`: Defineix el nom de l'host dins del contenidor.
- `-d`: Executa el contenidor en mode desatès (background).
- `mcr.microsoft.com/mssql/server:2022-latest`: Especifica la imatge de MS SQL Server a utilitzar.

Un cop el contenidor està en funcionament, podem connectar-nos-hi utilitzant DBeaver.

Comprova que s'ha engegat correctament amb la comanda, si no és així, repassa els logs.

Comandes útils per gestionar el contenidor:
- `docker ps`: Llista els contenidors en execució.
- `docker stop sql1`: Atura el contenidor anomenat `sql1`.
- `docker start sql1`: Inicia el contenidor anomenat `sql1`.
- `docker logs sql1`: Mostra els logs del contenidor `sql1`.

## Creació de la base de dades

Un cop connectats a MS SQL Server amb DBeaver, podem crear una nova base de dades usant l'entorn gràfic.

Repeteix la pràctica d'introducció a SQL, però aquesta vegada utilitzant MS SQL Server. Pots trobar la pràctica [aquí](../Tema_1/Contingut/creant-una-base-de-dades-a-supabase.md)


## Entrega

Aquesta pràctica no cal que l'entreguis. Només cal que la facis servir per practicar i familiaritzar-te amb les bases de dades relacionals i SQL.

Crea i esborra la base de dades i les taules les vegades que vulguis. Fes tantes consultes com vulguis. Experimenta amb les diferents funcionalitats de SQL i DBeaver. Inserta dades, esborra-les, modifica-les, fes consultes complexes. L'objectiu és que et sentis còmode treballant amb bases de dades relacionals i SQL.