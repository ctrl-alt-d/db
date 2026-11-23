# Pràctica 1 - Creant una base de dades a SQL Server

## Antecedents

Estem a la introducció del mòdul formatiu. Per practicar necessitem un sistema gestor de bases de dades (SGBD). En comptes d'instal·lar-lo directament al nostre ordinador, l'engegarem dins d'un contenidor (*container*) de Docker: així la instal·lació es redueix a una sola ordre i no deixa res configurat al sistema.

Farem servir **Microsoft SQL Server 2022**, un SGBD relacional molt estès a les empreses. Com a client utilitzarem **DBeaver**, una eina gràfica que permet connectar-se a molts SGBD diferents.

## Objectius

* Familiaritzar-nos amb els conceptes bàsics de les bases de dades i els sistemes gestors de bases de dades.
* Aprendre a engegar SQL Server dins de Docker i a connectar-nos-hi des de DBeaver.
* Aprendre a crear una base de dades usant SQL.
* Aprendre a crear taules en una base de dades usant SQL.
* Aprendre a inserir dades en una base de dades usant SQL.
* Aprendre a realitzar consultes bàsiques a una base de dades usant SQL.
* Aprendre a modificar i eliminar dades en una base de dades usant SQL.

## Requisits previs

* Conèixer els conceptes bàsics de les bases de dades i els sistemes gestors de bases de dades.
* Tenir Docker instal·lat i en funcionament. El pots obtenir des de la [guia oficial d'instal·lació](https://docs.docker.com/get-started/get-docker/).
* Tenir DBeaver instal·lat. Pots descarregar gratuïtament la versió Community des de [https://dbeaver.io/download/](https://dbeaver.io/download/).

## Desenvolupament de la pràctica

### Engegar SQL Server amb Docker

1. Obre un terminal i executa aquesta ordre:

```bash
docker run --platform linux/amd64 -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=yourStrong(!)Password' -p 1433:1433 --name sql1 -d mcr.microsoft.com/mssql/server:2022-latest
```

2. Què significa cada paràmetre?
   * `--platform linux/amd64`: indica que la imatge és per a l'arquitectura x64 (Intel/AMD), l'única per a la qual Microsoft publica SQL Server. En un Mac amb Apple Silicon (M1, M2... M5), Docker Desktop l'executa mitjançant emulació (Rosetta); en equips Intel/AMD aquest paràmetre no té cap efecte.
   * `-e 'ACCEPT_EULA=Y'`: accepta l'acord de llicència.
   * `-e 'MSSQL_SA_PASSWORD=yourStrong(!)Password'`: defineix la contrasenya de l'usuari administrador `sa`.
   * `-p 1433:1433`: mapeja el port 1433 del contenidor al port 1433 del teu ordinador.
   * `--name sql1`: assigna el nom `sql1` al contenidor.
   * `-d`: executa el contenidor en segon pla (*background*).
   * `mcr.microsoft.com/mssql/server:2022-latest`: indica la imatge que cal utilitzar. Si no la tens, Docker la baixa automàticament; la primera vegada pot trigar uns minuts.
3. Comprova amb `docker ps` que el contenidor `sql1` està en execució. Si no apareix a la llista, consulta'n els registres amb `docker logs sql1`.

Ordres útils per gestionar el contenidor:

* `docker stop sql1`: atura el contenidor. Les dades es conserven.
* `docker start sql1`: el torna a engegar. Fes servir aquesta ordre, i no `docker run`, els propers dies.
* `docker logs sql1`: en mostra els registres (*logs*).

### Connectar-nos a SQL Server des de DBeaver

1. Obre DBeaver.
2. Fes clic a `Database` > `New Database Connection`.
3. Selecciona `SQL Server` i fes clic a `Next`.
4. Introdueix les dades de connexió:
   * **Host**: `localhost`
   * **Port**: `1433`
   * **Database**: `master` (la base de dades per defecte)
   * **Username**: `sa`
   * **Password**: `yourStrong(!)Password`
5. Fes clic a `Test Connection` per verificar que la connexió és correcta. Si DBeaver ho demana, descarrega el controlador (*driver*).
6. Si la connexió és correcta, fes clic a `Finish` per crear-la.

>Nota: si la prova de connexió falla amb un error relacionat amb el certificat o amb SSL, marca l'opció `Trust server certificate` a la configuració de la connexió i torna-ho a provar.

### Crear la base de dades

1. Fes botó dret sobre la connexió i obre un editor SQL (`SQL Editor` > `New SQL script`).
2. Introdueix la comanda següent i executa-la:

```sql
create database biblioteca;
```

3. Indica que a partir d'ara vols treballar amb aquesta base de dades:

```sql
use biblioteca;
```

4. A l'arbre de l'esquerra, fes botó dret sobre la connexió i tria `Refresh`. Desplega `Databases` i comprova que hi apareix `biblioteca`.

>Nota: per executar la sentència on tens el cursor, prem `Ctrl+Enter` (`Cmd+Enter` en un Mac) o fes clic al botó d'executar de l'editor.

### Crear i esborrar taules

1. A l'editor SQL, introdueix la comanda següent:

```sql
create table autors (
  nom varchar(250),
  any_defuncio int
);
```

2. Executa la comanda per crear la taula "autors".
3. Per verificar que la taula s'ha creat correctament, desplega `Databases` > `biblioteca` > `Schemas` > `dbo` > `Tables` a l'arbre de l'esquerra. Si no hi apareix, fes botó dret i `Refresh`.
4. Anem a crear una segona taula on posar els llibres. Torna a l'editor SQL i pensa com serà la comanda per crear una taula "llibres" amb els camps següents:
   * titol: camp de tipus text.
   * any_publicacio: camp de tipus enter.
   * nom_autor: nom de l'autor a la nostra taula d'autors.
5. Esborra les taules amb la comanda SQL `drop table nom_taula;` i torna-les a crear. Practica de crear i esborrar taules tantes vegades com vulguis.

>Nota: també podíem haver creat les taules des de l'entorn gràfic de DBeaver. T'animo a fer proves per crear i esborrar taules des d'allà.

### Inserir dades a les taules

1. Torna a l'editor SQL i introdueix la comanda següent per inserir un autor a la taula "autors":

```sql
insert into autors (nom, any_defuncio) values ('George Orwell', 1950);
```

2. Executa la comanda per inserir l'autor.
3. Repeteix el procés per inserir més autors a la taula "autors".
4. Ara insereix un llibre a la taula "llibres". Recorda que el camp `nom_autor` ha de coincidir amb un nom d'autor existent a la taula "autors". Per exemple:

```sql
insert into llibres (titol, any_publicacio, nom_autor) values ('1984', 1949, 'George Orwell');
```

5. Executa la comanda per inserir el llibre.
6. Repeteix el procés per inserir més llibres a la taula "llibres".

>Quan no sabem el valor d'una dada o no volem posar cap valor, podem utilitzar el valor `null`. Per exemple, si no sabem l'any de defunció d'un autor o encara és viu, la comanda seria:

```sql
insert into autors (nom, any_defuncio) values ('J.K. Rowling', null);
```

### Realitzar consultes a les taules

1. Torna a l'editor SQL i introdueix la comanda següent per consultar tots els autors de la taula "autors":

```sql
select * from autors;
```

2. Executa la comanda i observa els resultats a la part inferior de l'editor.
3. Ara consulta tots els llibres de la taula "llibres". Pensa com serà la consulta.
4. La clàusula `where` et permet filtrar els resultats. Per exemple, per consultar els llibres publicats després de l'any 2000, la comanda seria:

```sql
select * from llibres where any_publicacio > 2000;
```

5. Executa la comanda i observa els resultats.
6. Practica: consulta només els llibres d'un autor concret. Pensa com serà la comanda.

### Modificar i eliminar dades a les taules

1. Torna a l'editor SQL i introdueix la comanda següent per modificar l'any de defunció d'un autor a la taula "autors":

```sql
update autors set any_defuncio = 1951 where nom = 'George Orwell';
```

2. Executa la comanda per modificar l'autor.
3. Consulta la taula "autors" per verificar que l'any de defunció s'ha actualitzat correctament.
4. Ara elimina un llibre de la taula "llibres". Per exemple, per eliminar el llibre "1984", la comanda seria:

```sql
delete from llibres where titol = '1984';
```

5. Executa la comanda per eliminar el llibre.
6. Consulta la taula "llibres" per verificar que el llibre s'ha eliminat.
7. Practica modificant i eliminant més dades de les taules.

## Reflexions

1. Què t'ha semblat el fet que puguem esborrar autors dels quals tenim llibres a la taula de llibres? Imagina que les taules són `comandes` (`orders` en anglès) i `clients` (`customers` en anglès): què et semblaria esborrar un client del qual tenim comandes a la taula de comandes?
2. Què t'ha semblat el fet que puguem inserir llibres amb autors que no existeixen a la taula d'autors? Fes el mateix exercici amb les taules `comandes` i `clients`.
3. Prova a posar files amb tots els valors a `null`. Què et sembla el fet de poder posar `null` a tot arreu? Què passaria si poséssim `null` a la taula de comandes al camp `client_id`?
