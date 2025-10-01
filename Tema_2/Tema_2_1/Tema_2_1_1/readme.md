# Tema 2.1.1. Creació de taules (RA2)

## Objectius

En aquest apartat aprendràs a:

1. Crear taules en una base de dades.
2. Definir les columnes i els tipus de dades de les taules.
3. Establir claus primàries i foranes.
4. Utilitzar instruccions SQL per a la creació de taules.
5. Comprendre les restriccions i les propietats de les taules.

## Introducció

La creació de taules és una part fonamental de la gestió de bases de dades. Les taules són les estructures que emmagatzemen les dades en una base de dades relacional. Cada taula està composta per files i columnes, on les columnes representen els atributs dels registres i les files representen els registres en si.

Per crear una taula, s'utilitza l'instrucció SQL `CREATE TABLE`, que permet definir el nom de la taula, les columnes, els tipus de dades i les restriccions associades a cada columna. A més, es poden establir claus primàries i foranes per garantir la integritat de les dades.

## Conceptes bàsics

* Clau Primària (Primary Key): Una columna o un conjunt de columnes que identifica de manera única cada fila en una taula.
* Clau Forana (Foreign Key): Una columna o un conjunt de columnes que estableix una relació entre dues taules, referenciant la clau primària d'una altra taula.
* Tipus de Dades: Defineixen el tipus d'informació que es pot emmagatzemar en una columna (per exemple, INTEGER, VARCHAR, DATE, etc.).
* Restriccions: Regles que s'apliquen a les columnes per garantir la integritat de les dades (per exemple, NOT NULL, UNIQUE, CHECK, etc.).
* Taula: Una estructura que emmagatzema dades en files i columnes dins d'una base de dades.
* Fila (Row): Un registre individual dins d'una taula que conté dades per a cada columna.
* Columna (Column): Un atribut o camp dins d'una taula que defineix un tipus específic de dada.
* Atribut mutivaluat: Una columna que pot contenir múltiples valors per a un sol registre, com ara una llista de telèfons. Les bases de dades relacionals no permeten atributs multivaluats directament, però es poden gestionar mitjançant taules relacionals.

### Per a que serveix la clau primària?

La clau primària serveix per identificar de manera única cada fila en una taula. Això és essencial per garantir que no hi hagi duplicats i per establir relacions entre diferents taules en una base de dades relacional.

### Per a que serveix la clau foranea?

La clau forana serveix per establir una relació entre dues taules, referenciant la clau primària d'una altra taula. Per exemple, en una taula de comandes, la clau forana podria ser l'identificador del client que va fer la comanda, referenciant la clau primària de la taula de clients. A la taula de comandes només emmagatzemem l'identificador del client, no tota la informació del client.

### Per a que serveix la integritat referencial?

La integritat referencial és un conjunt de regles que garanteixen que les relacions entre les taules es mantinguin coherents. Això significa que una clau forana en una taula ha de correspondre sempre a una clau primària existent en la taula referenciada. Això ajuda a evitar errors com ara tenir registres orfes o dades inconsistents.

### Per a que serveix la restricció `not null` ?

La restricció `NOT NULL` s'utilitza per assegurar que una columna no pot contenir valors nuls. Això significa que cada vegada que s'insereix o actualitza un registre, aquesta columna ha de tenir un valor vàlid. Aquesta restricció és útil per garantir que certes dades essencials sempre estiguin presents en la taula.

### Per a que serveix la restricció `unique` ?

La restricció `UNIQUE` s'utilitza per assegurar que tots els valors en una columna o un conjunt de columnes siguin diferents entre si. Això significa que no es poden tenir valors duplicats en aquesta columna. Aquesta restricció és útil per garantir la singularitat de certs atributs, com ara adreces de correu electrònic o números d'identificació.

### Quan creem una taula, podem definir més d'una clau primària?

No, en una taula només es pot definir una clau primària. La clau primària pot estar composta per una sola columna o per un conjunt de columnes (clau primària composta), però només hi pot haver una clau primària per taula. Si necessites garantir la unicitat en altres columnes, pots utilitzar la restricció `UNIQUE`.

### Quan definim les columnes d'una taula, podem definir més d'una clau foranea?

Sí, una taula pot tenir múltiples claus foranes. Cada clau forana pot referenciar una clau primària diferent en altres taules. Això permet establir diverses relacions entre la taula actual i altres taules dins de la base de dades.

### Quan definim una columna, li podem posar un valor per defecte?

Sí, quan definim una columna en una taula, podem assignar-li un valor per defecte utilitzant la clàusula `DEFAULT`. Aquest valor serà utilitzat automàticament quan s'insereixi un nou registre i no es proporcioni un valor específic per a aquesta columna. Veurem exemples més endavant.


### Les columnes que formen la clau primària poden tenir valors nuls?

No, les columnes que formen la clau primària no poden tenir valors nuls. La clau primària ha de garantir la unicitat i la identificació única de cada fila en una taula, i permetre valors nuls violaria aquesta regla. Per tant, totes les columnes que formen part de la clau primària tenen implícitament la restricció `NOT NULL`.

### Les columnes que formen una clau foranea poden tenir valors nuls?

Sí, les columnes que formen una clau forana poden tenir valors nuls, sempre que la definició de la clau forana ho permeti. Si una columna de clau forana és `NULL`, això significa que no hi ha cap relació establerta amb la taula referenciada per a aquell registre específic. Això pot ser útil en situacions on la relació és opcional.


## Sintaxi bàsica

La sintaxi bàsica per crear una taula és la següent:

```sql
CREATE TABLE nom_taula (
    nom_columna1 tipus_dada1 restriccions1,
    nom_columna2 tipus_dada2 restriccions2,
    ...
    nom_columnaN tipus_dadaN restriccionsN,
    CONSTRAINT nom_clau_primaria 
      PRIMARY KEY (nom_columnes_clau_primaria_separades_per comes),
    CONSTRAINT nom_clau_foranea 
      FOREIGN KEY (nom_columna_clau_foranea) 
      REFERENCES nom_taula_referenciada(nom_columnes_referencien_separades_per comes),
    CONSTRAINT nom_restriccio 
      UNIQUE (nom_columnes_restriccio_separades_per comes),
    ...
);
```

### He vist que hi ha moltes paraules clau en majúscules. És obligatori?

No, no és obligatori. SQL no és sensible a majúscules i minúscules, així que pots escriure les paraules clau en majúscules, minúscules o una combinació de les dues segons la teva preferència. No obstant això, és una pràctica comuna escriure les paraules clau en majúscules per millorar la llegibilitat del codi.

### Cal posar `CONSTRAINT` a cada restricció?

No, no és obligatori posar `CONSTRAINT` a cada restricció. Pots definir les restriccions directament després de la definició de la columna sense utilitzar `CONSTRAINT`. Per exemple:

```sql
CREATE TABLE exemple (
    id INT NOT NULL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);
```

Tanmateix, per fer-ho tots igual i tractar totes les restriccions de la mateixa manera, a classe utilitzarem `CONSTRAINT` per a totes les restriccions.

## Tipus de dades

Els tipus de dades d'una base de dades defineixen la naturalesa de les dades que es poden emmagatzemar en una columna. Cada sistema gestor de base de dades pot tenir els seus propis tipus de dades específics, però hi ha alguns tipus comuns que es troben en la majoria dels sistemes. A continuació es presenten alguns dels tipus de dades més utilitzats:

- **INT**: S'utilitza per emmagatzemar nombres enters.
- **FLOAT**: S'utilitza per emmagatzemar nombres decimals.
- **VARCHAR(n)**: S'utilitza per emmagatzemar cadenes de text de longitud variable, amb una longitud màxima de `n` caràcters.
- **TEXT**: S'utilitza per emmagatzemar cadenes de text de longitud variable sense una longitud màxima definida.
- **DATE**: S'utilitza per emmagatzemar dates.
- **TIME**: S'utilitza per emmagatzemar hores.
- **DATETIME**: S'utilitza per emmagatzemar dates i hores.
- **BOOLEAN**: S'utilitza per emmagatzemar valors veritable/fals (true/false).
- **BLOB**: S'utilitza per emmagatzemar dades binàries, com ara imatges o fitxers.
- **JSON**: S'utilitza per emmagatzemar dades en format JSON.
- **XML**: S'utilitza per emmagatzemar dades en format XML.
- **GUID**: S'utilitza per emmagatzemar identificadors únics globals (UUID). Exemple: `123e4567-e89b-12d3-a456-426614174000`.

Pots consultar els tipus de dades de MS SQLServer a la documentació del fabricant: [Tipos de datos (Transact-SQL)
](https://learn.microsoft.com/es-es/sql/t-sql/data-types/data-types-transact-sql?view=sql-server-ver17).

### Els autoincrementals

Els autoincrementals són un tipus especial de columna que s'utilitza per generar valors únics de manera automàtica cada vegada que s'insereix un nou registre en una taula. Aquest tipus de columna és especialment útil per a claus primàries, ja que garanteix que cada registre tingui un identificador únic sense necessitat que l'usuari especifiqui aquest valor manualment.

A MS SQLServer s'utilitza la paraula clau [`IDENTITY`](https://learn.microsoft.com/es-es/sql/t-sql/statements/create-table-transact-sql-identity-property?view=sql-server-ver17) per definir una columna autoincremental. La sintaxi bàsica és la següent:

```sql
CREATE TABLE nom_taula (
    nom_columna INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    nom_columna2 tipus_dada2 restriccions2,
    ...
);
``` 

En aquest exemple, la columna `nom_columna` és una columna autoincremental que començarà en 1 i s'incrementarà en 1 per a cada nou registre inserit. Això significa que el primer registre tindrà un valor de 1, el segon un valor de 2, i així successivament.

## Exemples pràctics

A continuació es mostren alguns exemples pràctics de com crear taules amb diferents tipus de dades i restriccions.

### Exemple 1: Crear una taula bàsica

```sql
CREATE TABLE usuaris (
    id INT IDENTITY(1,1) NOT NULL,
    nom VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    data_registre DATETIME DEFAULT GETDATE(),
    CONSTRAINT pk_usuaris PRIMARY KEY (id)
);
```

Estem creant una taula anomenada `usuaris` amb quatre columnes: `id`, `nom`, `email` i `data_registre`. La columna `id` és una clau primària autoincremental, la columna `email` té una restricció de unicitat, i la columna `data_registre` té un valor per defecte que és la data i hora actuals.

### Exemple 2: Crear una taula amb una clau forana

```sql
CREATE TABLE comandes (
    id INT IDENTITY(1,1) NOT NULL,
    id_usuari INT NOT NULL,  -- usuari que ha preparat la comanda és clau forana
    data_comanda DATETIME DEFAULT GETDATE(),
    total FLOAT NOT NULL,
    CONSTRAINT pk_comandes PRIMARY KEY (id),
    CONSTRAINT fk_comandes_usuaris FOREIGN KEY (id_usuari) REFERENCES usuaris(id)
);
```

### Exemple 3: Crear una taula amb restricció UNIQUE

```sql
CREATE TABLE productes (
    id INT IDENTITY(1,1) NOT NULL,
    nom VARCHAR(100) NOT NULL,
    codi_barras VARCHAR(50) NOT NULL,
    preu FLOAT NOT NULL,
    CONSTRAINT pk_productes PRIMARY KEY (id),
    CONSTRAINT uq_productes_codi_barras UNIQUE (codi_barras)
);
```

En aquest exemple, la columna `codi_barras` té una restricció de unicitat, assegurant que no hi hagi dos productes amb el mateix codi de barres.

### Exemple 4: Crear una taula amb diverses claus foranes

```sql
CREATE TABLE ressenyes (
    id INT IDENTITY(1,1) NOT NULL,
    id_usuari INT NOT NULL,
    id_producte INT NOT NULL,
    puntuacio INT NOT NULL,
    comentari TEXT,
    CONSTRAINT pk_ressenyes 
       PRIMARY KEY (id),
    CONSTRAINT fk_ressenyes_usuaris 
       FOREIGN KEY (id_usuari)
       REFERENCES usuaris(id),
    CONSTRAINT fk_ressenyes_productes
       FOREIGN KEY (id_producte)
       REFERENCES productes(id)
);
```

En aquest exemple, la taula `ressenyes` té dues claus foranes: `id_usuari` que referència la taula `usuaris` i `id_producte` que referència la taula `productes`. Això permet establir relacions entre les ressenyes, els usuaris i els productes.

### Exemple 5: Crear una taula amb una clau primària composta

```sql
CREATE TABLE inscripcions (
    id_curs INT NOT NULL,
    id_usuari INT NOT NULL,
    data_inscripcio DATETIME DEFAULT GETDATE(),
    CONSTRAINT pk_inscripcions
       PRIMARY KEY (id_curs, id_usuari),
    CONSTRAINT fk_inscripcions_cursos
       FOREIGN KEY (id_curs)
       REFERENCES cursos(id),
    CONSTRAINT fk_inscripcions_usuaris
       FOREIGN KEY (id_usuari)
       REFERENCES usuaris(id)
);
```

### Exemple 6: Crear una clau taula amb una clau forana composta

```sql
CREATE TABLE pagaments_inscripcions (
    id_curs INT NOT NULL,
    id_usuari INT NOT NULL,
    data_pagament DATETIME DEFAULT GETDATE(),
    import FLOAT NOT NULL,
    CONSTRAINT pk_pagaments_inscripcions
       PRIMARY KEY (id_curs, id_usuari, data_pagament),
    CONSTRAINT fk_pagaments_inscripcions_inscripcions
       FOREIGN KEY (id_curs, id_usuari)
       REFERENCES inscripcions(id_curs, id_usuari)
);
```

## Les claus foranes

## Accions referencials en SQL (SQL:2011)

Quan definim una clau forana (`FOREIGN KEY`), podem especificar què passa quan 
una fila de la taula referenciada és **eliminada (`ON DELETE`)** o **actualitzada (`ON UPDATE`)**.  
Les opcions disponibles segons l’estàndard **SQL:2011** són:

## Opcions

- **CASCADE**  
  Si s’elimina/actualitza una fila de la taula pare, totes les files dependents de la taula filla també s’eliminen o actualitzen.

- **SET NULL**  
  Els valors de les columnes que apunten a la fila eliminada/actualitzada es posen a `NULL`.

- **SET DEFAULT**  
  Els valors de les columnes es posen al valor per defecte definit en l’esquema.

- **RESTRICT**  
  Prohibeix eliminar/actualitzar una fila si té files relacionades.  
  La comprovació es fa **immediatament**.

- **NO ACTION** *(per defecte)*  
  No s’aplica cap acció automàtica.  
  La integritat es comprova al final de l’operació o de la transacció.  
  (En molts SGBD es comporta igual que `RESTRICT`.)

## Resum

| Opció        | Efecte quan s’elimina/actualitza la fila pare |
|--------------|-----------------------------------------------|
| CASCADE      | Esborra/actualitza també les files filles     |
| SET NULL     | Posa a `NULL` les referències                 |
| SET DEFAULT  | Posa el valor per defecte                     |
| RESTRICT     | Prohibeix l’operació (comprovació immediata)  |
| NO ACTION    | Comprovació al final (per defecte)            |

---

📌 **Nota:** Cada sistema gestor (MySQL, PostgreSQL, SQL Server, Oracle, etc.) 
pot implementar matisos, però aquestes són les accions oficials de l’estàndard.

### Accions referencials en T-SQL (SQL Server)

En SQL Server (T-SQL) també podem usar les accions **ON DELETE** i **ON UPDATE** en les claus foranes (`FOREIGN KEY`) per especificar què ha de passar quan es modifica o elimina una fila en la taula “pare”.

Microsoft té una [pàgina oficial sobre claus primàries i foranes](https://learn.microsoft.com/en-us/sql/relational-databases/tables/primary-and-foreign-key-constraints?view=sql-server-ver17) on s’explica el concepte de “cascading referential integrity” amb les opcions `CASCADE`, `SET NULL`, `SET DEFAULT`, `NO ACTION`.  

---

### Sintaxi general (T-SQL)

Al crear la taula (CREATE TABLE)

```sql
CREATE TABLE Parent (
    Id INT PRIMARY KEY,
    -- altres columnes
);

CREATE TABLE Child (
    Id INT PRIMARY KEY,
    ParentId INT NULL,  -- o NOT NULL, segons el model
    CONSTRAINT FK_Child_Parent
      FOREIGN KEY (ParentId)
      REFERENCES Parent(Id)
      ON DELETE CASCADE
      ON UPDATE NO ACTION
);
```

- Quan s’elimina una fila de **Parent**, les files de **Child** que la referencien s’eliminaran automàticament (`ON DELETE CASCADE`).  

- Si s’actualitza `Id` de **Parent** (cas poc freqüent, ja que una clau primària normalment és immutable), l’`ON UPDATE NO ACTION` impedirà l’actualització si hi ha files dependents.  

- Totes les opcions possibles (`CASCADE`, `SET NULL`, `SET DEFAULT`, `NO ACTION`) són acceptades segons les restriccions de les columnes i el disseny de les taules.  

