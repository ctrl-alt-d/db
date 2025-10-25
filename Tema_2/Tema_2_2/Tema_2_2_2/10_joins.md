# Introduint Joins en SQL

Els joins permeten combinar dades de dues o més taules relacionades. Són fonamentals per treballar amb bases de dades relacionals i obtenir informació de diverses fonts.

## Tipus principals de JOIN

### 1. INNER JOIN

Retorna només les files que tenen coincidència a les dues taules.

```sql
SELECT a.nom, b.nom_curs
FROM alumnes a
INNER JOIN cursos b ON a.curs_id = b.id;
```

### 2. LEFT OUTER JOIN

Retorna totes les files de la taula de l'esquerra i les coincidències de la dreta. Si no hi ha coincidència, les columnes de la dreta seran NULL.

```sql
SELECT a.nom, b.nom_curs
FROM alumnes a
LEFT OUTER JOIN cursos b ON a.curs_id = b.id;
```

### 3. RIGHT OUTER JOIN

Retorna totes les files de la taula de la dreta i les coincidències de l'esquerra. Si no hi ha coincidència, les columnes de l'esquerra seran NULL.

```sql
SELECT a.nom, b.nom_curs
FROM alumnes a
RIGHT OUTER JOIN cursos b ON a.curs_id = b.id;
```


### 4. CROSS JOIN

Retorna el producte cartesià de les dues taules: totes les combinacions possibles de files.

```sql
SELECT a.nom, b.nom_curs
FROM alumnes a
CROSS JOIN cursos b;
```

## Exemples amb gossos i raça

Suposem les taules següents:

- `gossos(num_xip, nom, raça)`
- `raça(id, nom)`

La columna `raça` de `gossos` és una clau forana cap a `raça.id`.

### INNER JOIN
Obtenir el nom del gos i el nom de la raça (només gossos amb raça definida):

```sql
SELECT g.nom AS nom_gos, r.nom AS nom_raça
FROM gossos g
INNER JOIN raça r ON g.raça = r.id;
```

### LEFT OUTER JOIN
Obtenir tots els gossos, amb el nom de la raça si en tenen:

```sql
SELECT g.nom AS nom_gos, r.nom AS nom_raça
FROM gossos g
LEFT OUTER JOIN raça r ON g.raça = r.id;
```
Els gossos sense raça definida tindran `nom_raça` a NULL.

### RIGHT OUTER JOIN
Obtenir totes les races, amb el nom del gos si existeix:

```sql
SELECT g.nom AS nom_gos, r.nom AS nom_raça
FROM gossos g
RIGHT OUTER JOIN raça r ON g.raça = r.id;
```
Les races sense cap gos tindran `nom_gos` a NULL.


## Resum

- **INNER JOIN**: només coincidències a ambdues taules.
- **LEFT OUTER JOIN**: totes les files de l'esquerra, coincidències de la dreta.
- **RIGHT OUTER JOIN**: totes les files de la dreta, coincidències de l'esquerra.
- **CROSS JOIN**: totes les combinacions possibles.

Els joins són essencials per consultar dades relacionades i construir consultes avançades en SQL.