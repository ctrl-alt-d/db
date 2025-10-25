# Introduint la clàusula WHERE

La clàusula `WHERE` en SQL permet filtrar les files que compleixen una condició determinada. És fonamental per recuperar només les dades que ens interessen d'una taula.

## Sintaxi bàsica

```sql
SELECT columnes
FROM taula
WHERE condició;
```

## Exemple senzill

Suposem que tenim una taula `alumnes` amb les columnes `nom`, `edat` i `curs`. Si volem obtenir els alumnes que tenen més de 18 anys:

```sql
SELECT nom, edat
FROM alumnes
WHERE edat > 18;
```

## Operadors comuns en WHERE

- `=`   Igualtat
- `<>`  Diferent
- `>`   Major que
- `<`   Menor que
- `>=`  Major o igual que
- `<=`  Menor o igual que
- `BETWEEN`  Entre dos valors
- `IN`  Dins d'un conjunt de valors
- `LIKE`  Cerca per patró
- `IS NULL`  Valor nul

## Exemple amb LIKE

```sql
SELECT nom
FROM alumnes
WHERE nom LIKE 'A%';
```

Aquest exemple retorna els noms dels alumnes que comencen per la lletra 'A'.

## Exemple amb IN

```sql
SELECT nom, curs
FROM alumnes
WHERE curs IN ('1r', '2n');
```

Retorna els alumnes que estan als cursos '1r' o '2n'.

## Exemple amb BETWEEN

```sql
SELECT nom, edat
FROM alumnes
WHERE edat BETWEEN 16 AND 18;
```

Retorna els alumnes amb edat entre 16 i 18 anys (inclosos).

## Exemple amb IS NULL

```sql
SELECT nom
FROM alumnes
WHERE curs IS NULL;
```

Retorna els alumnes que no tenen curs assignat.

## Combinació de condicions

Es poden combinar condicions amb `AND` i `OR`:

```sql
SELECT nom, edat
FROM alumnes
WHERE edat > 18 AND curs = '2n';
```

## Resum

La clàusula `WHERE` és essencial per filtrar dades en les consultes SQL. Permet utilitzar una gran varietat d'operadors i combinar condicions per obtenir resultats precisos.