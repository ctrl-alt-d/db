# Tema 2.1.2. Modificació i eliminació de taules (RA2)

## Objectius

En aquest apartat aprendràs a:

1. Modificar l'estructura d'una taula amb `ALTER TABLE`.
2. Afegir, eliminar i renombrar columnes.
3. Canviar tipus de dades i valors per defecte.
4. Afegir i eliminar restriccions (clau primària, únic, forana, check).
5. Eliminar o esborrar dades d'una taula amb `DROP TABLE` i `TRUNCATE` i entendre les diferències.


## Introducció

Modificar l'esquema d'una base de dades és una tasca habitual durant el cicle de vida d'una aplicació. SQL ofereix la instrucció `ALTER TABLE` per canviar l'estructura de les taules existents sense perdre (idealment) les dades. Tot i això, alguns canvis poden comportar pèrdua de dades o bloquejos, per això cal planificar i provar abans d'aplicar-los en producció.

Aquest document utilitza exemples en sintaxi SQL estàndard i T-SQL (SQL Server) quan cal puntualitzar comportaments específics.

Per conèixer la sintaxi i limitacions específiques d'altres SGBD (PostgreSQL, MySQL, Oracle, etc.) consulta la seva documentació oficial. Hi ha moltes més opcions i variants segons el SGBD, així que sempre és recomanable revisar la documentació oficial per a casos específics.


## Sintaxi i operacions comunes

### Afegir una columna

SQL estàndard / T-SQL:

```sql
ALTER TABLE nom_taula
	ADD nom_columna TIPUS [DEFAULT valor] [NOT NULL | NULL];
```

Exemple:

```sql
ALTER TABLE usuaris
	ADD telefon VARCHAR(20) NULL;
```

Si afegeixes una columna `NOT NULL` sense `DEFAULT` a una taula amb dades, dependrà del SGBD: pot fallar o demanar un valor per a cada fila. Recomanació: afegir primer la columna nullable o amb DEFAULT, omplir les dades i després posar `NOT NULL`.

### Eliminar una columna

```sql
ALTER TABLE nom_taula
	DROP COLUMN nom_columna;
```

Exemple:

```sql
ALTER TABLE usuaris
	DROP COLUMN telefon;
```

### Renombrar una columna

La sintaxi varia entre SGBD. En T-SQL (SQL Server) s'utilitza [`sp_rename`](https://learn.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-rename-transact-sql?view=sql-server-ver17):

```sql
EXEC sp_rename 'usuaris.telefon', 'telefon_principal', 'COLUMN';
```

En PostgreSQL:

```sql
ALTER TABLE usuaris RENAME COLUMN telefon TO telefon_principal;
```


### Canviar tipus de dada

```sql
ALTER TABLE nom_taula
	ALTER COLUMN nom_columna TIPUS;
```

Exemple T-SQL (canviar varchar a nvarchar):

```sql
ALTER TABLE productes
	ALTER COLUMN descripcio NVARCHAR(500) NULL;
```

Canviar tipus pot provocar errors si les dades existents no són compatibles. Habitualment cal:

- Crear una nova columna amb el tipus desitjat.
- Convertir/omplir dades de manera segura (UPDATE amb conversió explícita).
- Eliminar la columna antiga i renombrar la nova.

### Afegir i eliminar restriccions

Afegir una clau forana (exemple T-SQL):

```sql
ALTER TABLE comandes
	ADD CONSTRAINT fk_comandes_usuaris
	FOREIGN KEY (id_usuari) REFERENCES usuaris(id)
	ON DELETE CASCADE
	ON UPDATE NO ACTION;
```

Eliminar una restricció:

```sql
ALTER TABLE comandes
	DROP CONSTRAINT fk_comandes_usuaris;
```

Afegir una clau primària a una taula existent (primer assegurar unicitat/not null):

```sql
ALTER TABLE productes
	ADD CONSTRAINT pk_productes PRIMARY KEY (id);
```

Eliminar la clau primària:

```sql
ALTER TABLE productes
	DROP CONSTRAINT pk_productes;
```

Nota: El nom de la constraint pot haver estat generat automàticament pel SGBD; per això és pràctic establir noms explícits a l'hora de crear-les.

## Eliminar o esborrar dades i taules

### DROP TABLE

Elimina la definició de la taula i les dades. És irreversible (fora d'una còpia de seguretat).

```sql
DROP TABLE nom_taula;
```

Versió segura (només si existeix):

```sql
DROP TABLE IF EXISTS nom_taula;
```

### TRUNCATE TABLE

El buida la taula ràpidament (elimina totes les files). Sovint és més ràpid que `DELETE FROM` perquè no registra cada fila individualment. Pot tenir restriccions quan hi ha claus foranes apuntant a la taula.

```sql
TRUNCATE TABLE nom_taula;
```

Diferències clau:

- `DROP TABLE`: elimina l'estructura i les dades.
- `TRUNCATE TABLE`: elimina totes les dades però manté l'estructura. No es pot "desfer".
- `DELETE FROM`: elimina files i permet WHERE; més lent però transaccionable i pot disparar triggers.

## Consideracions sobre integritat i dependències

- Si una taula té claus foranes referenciant-la, `DROP TABLE` pot fallar o requerir `CASCADE` segons el SGBD.
- Eliminar columnes o restriccions pot trencar vistes, procediments emmagatzemats i aplicacions. Revisa referències.
- Canvis que impliquin conversió de tipus poden produir errors de conversió o truncaments.

## Recursos i documentació

- Documentació T-SQL (Microsoft): Primary and foreign key constraints, ALTER TABLE, DROP TABLE.
- Documentació PostgreSQL: ALTER TABLE.
- Documentació MySQL: ALTER TABLE (notes sobre bloqueigs i online DDL en versions modernes).

