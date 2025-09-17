# Pràctica 1 - Creant una base de dades a supabase

## Antecedents

Estem a la introducció del mòdu formatiu. Per tal d'evitar complicacions, en comptes d'instal·lar en els nostre ordinador un sistema gestor de bases de dades com MySQL, PostgreSQL o Oracle, farem servir una eina anomenada [supabase](https://www.supabase.com/). Aquesta eina és gratuïta i ens permetrà crear una base de dades i practicar amb ella.

## Objectius

* Familiaritzar-nos amb els conceptes bàsics de les bases de dades i els sistemes gestors de bases de dades.
* Aprendre a crear una base de dades utilitzant supabase usant SQL.
* Aprendre a crear taules en una base de dades usant SQL.
* Aprendre a insertar dades en una base de dades usant SQL.
* Aprendre a realitzar consultes bàsiques a una base de dades usant SQL.
* Aprendre a modificar i eliminar dades en una base de dades usant SQL.


## Requisits previs

* Conèixer els conceptes bàsics de les bases de dades i els sistemes gestors de bases de dades.

## Desenvolupament de la pràctica

### Sign up a supabase

1. Accedeix a la pàgina web de supabase: [https://www.supabase.com/](https://www.supabase.com/).
2. Fes clic a "Sign in", si no tens compte, fes clic a "Sign up" per crear-ne un de nou.
3. Un cop registrat, verifica el teu correu electrònic i inicia sessió al teu compte.

### Crear un nou projecte

1. Un cop dins del teu compte, fes clic a "New Project".
2. Omple els camps necessaris:
   * **Project name**: Introdueix un nom per al teu projecte.
   * **Password**: Introdueix una contrasenya segura per a la base de dades. Assegura't de recordar-la, ja que la necessitaràs més endavant.
   * **Region**: Selecciona la regió més propera a tu (Paris és una bona opció per a Europa).
3. Fes clic a "Create new project". El procés de creació pot trigar uns minuts.
4. Un cop creat el projecte, accedeix a ell fent clic al nom del projecte.

### Crear i esborrar taules

1. A la barra lateral esquerra, fes clic a "SQL Editor".
2. A la finestra de l'editor SQL, introdueix la següent comanda:

```sql
create table autors (
  nom varchar(250),
  any_defuncio int
);
```

3. Fes clic a "Run" per executar la comanda i crear la taula "autors".
4. Per verificar que la taula s'ha creat correctament, fes clic a "Table Editor" a la barra lateral esquerra i comprova que la taula "autors" apareix a la llista de taules.
5. També pots anar a Database > Schema visualizer per veure la taula creada.
6. Anem a crear una segona taula on posar els llibres. Torna a l'editor SQL i pensa com serà la comanda per crear una taula "llibres" amb els següents camps:
   * titol: camp de tipus text.
   * any_publicacio: camp de tipus enter.
   * nom_autor: nom de l'autor a la nostra taula d'autors.
7. Esborra les taules amb la comanda sql `drop table nom_taula;`. I torna-les a crear. Practica de crear i esborrar taules tantes vegades com vulguis.

>Nota: Podíem haver creat també les taules des del `Table Editor`, t'animo a que facis proves per crear i esborrar les taules des d'allà.

### Inserir dades a les taules

1. Torna a l'editor SQL i introdueix la següent comanda per inserir un autor a la taula "autors":

```sql
insert into autors (nom, any_defuncio) values ('George Orwell', 1950);
```
2. Fes clic a "Run" per executar la comanda i inserir l'autor.
3. Repeteix el procés per inserir més autors a la taula "autors".
4. Ara insereix un llibre a la taula "llibres". Recorda que el camp `nom_autor` ha de coincidir amb un nom d'autor existent a la taula "autors". Per exemple:

```sql
insert into llibres (titol, any_publicacio, nom_autor) values ('1984', 1949, 'George Orwell');
```
5. Fes clic a "Run" per executar la comanda i inserir el llibre.
6. Repeteix el procés per inserir més llibres a la taula "llibres".

>Quan no sabem el valor d'una dada o no volem posar cap valor, podem utilitzar el valor `null`. Per exemple, si no sabem l'any de defunció d'un autor o encara és viu, la comanda seria:

```sql
insert into autors (nom, any_defuncio) values ('J.K. Rowling', null);
```

### Realitzar consultes a les taules

1. Torna a l'editor SQL i introdueix la següent comanda per consultar tots els autors de la taula "autors":

```sql
select * from autors;
```
2. Fes clic a "Run" per executar la comanda i veure els resultats.
3. Ara consulta tots els llibres de la taula "llibres". Pensa com serà la consulta.
4. La clùasula `where` et permet filtrar els resultats. Per exemple, per consultar els llibres publicats després de l'any 2000, la comanda seria:

```sql
select * from llibres where any_publicacio > 2000;
```
5. Fes clic a "Run" per executar la comanda i veure els resultats
6. Practica: consulta només els llibres d'un autor concret. Pensa com serà la comanda.

### Modificar i eliminar dades a les taules
1. Torna a l'editor SQL i introdueix la següent comanda per modificar l'any de defunció d'un autor a la taula "autors":

```sql
update autors set any_defuncio = 1951 where nom = 'George Orwell';
```
2. Fes clic a "Run" per executar la comanda i modificar l'autor.
3. Consulta la taula "autors" per verificar que l'any de defunció s'ha actualitzat correctament.
4. Ara elimina un llibre de la taula "llibres". Per exemple, per eliminar el llibre "1984", la comanda seria:
```sql
delete from llibres where titol = '1984';
```
5. Fes clic a "Run" per executar la comanda i eliminar el llibre.
6. Consulta la taula "llibres" per verificar que el llibre s'ha eliminat
7. Practica modificant i eliminant més dades de les taules.

## Reflexions

1. Que t'ha semblat el fet que poguem esborrar autors dels quals tenim llibres a la taula de llibres? Imagina que les taules són `comandes`(`orders` amb anglès) i `clients`(`customers` amb anglès), que et semblaria esborrar un client del qual tenim comandes a la taula de comandes?
2. Què t'ha semblat el fet que poguem insertar llibres amb autors que no existeixen a la taula d'autors? Fes el mateix exercici amb les taules `comandes` i `clients`.
3. Prova a posar fileres tot a `null`. Què et sembla el fet de poder posar nulls a tot arreu? Què passaria si posem `null` a la taula de comandes al camp `client_id`?

