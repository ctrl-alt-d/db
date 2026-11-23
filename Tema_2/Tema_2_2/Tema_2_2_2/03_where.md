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

- `%` representa qualsevol seqüència de caràcters, inclosa la seqüència buida.
- `_` representa exactament un caràcter. Per exemple, `LIKE 'A_'` selecciona textos de dos caràcters que comencen per A.
- En PostgreSQL, `LIKE` distingeix majúscules de minúscules en les configuracions habituals. `ILIKE` permet cercar sense aquesta distinció, per exemple `nom ILIKE '%mar%'`.

## Exemple amb IN

```sql
SELECT nom, curs
FROM alumnes
WHERE curs IN ('1r', '2n');
```

Retorna els alumnes que estan als cursos '1r' o '2n'.

`NOT IN ('1r', '2n')` comprova que el valor no sigui cap dels indicats. Si el valor comprovat és `NULL`, la condició no és certa i la fila no supera el filtre. Cal evitar també valors nuls a la llista de `NOT IN`; al tema de [subconsultes](./11_subconsultes.md#not-in-i-els-valors-null) veurem aquest cas amb detall.

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

Amb `IS NOT NULL` seleccionem els valors informats. No utilitzem `= NULL` ni `<> NULL`: una comparació ordinària amb `NULL` dona un resultat desconegut. `WHERE` només conserva les files en què la condició és `TRUE`; descarta les condicions falses i les desconegudes. Una cadena buida (`''`) és un valor de text i no és el mateix que `NULL`.

## Combinació de condicions

Es poden combinar condicions amb `AND` i `OR`:

```sql
SELECT nom, edat
FROM alumnes
WHERE edat > 18 AND curs = '2n';
```

`NOT` té prioritat sobre `AND`, i `AND` sobre `OR`. Utilitza parèntesis quan vulguis agrupar alternatives:

```sql
SELECT nom, edat, curs
FROM alumnes
WHERE (curs = '1r' OR curs = '2n')
  AND edat >= 18;
```

Sense els parèntesis, `curs = '1r' OR curs = '2n' AND edat >= 18` també acceptaria els alumnes de primer que no compleixen el requisit d'edat.

## Dates, booleans i expressions calculades

Un literal de data s'escriu `DATE '1997-01-01'`. Per seleccionar un any o un mes complet, és útil incloure el límit inicial i excloure el següent:

```sql
SELECT order_id, order_date
FROM orders
WHERE order_date >= DATE '1997-01-01'
  AND order_date < DATE '1998-01-01';
```

Aquest interval també inclou totes les hores de l'últim dia si la columna conté data i hora. Un límit superior com `<= '1997-12-31'` podria deixar fora hores d'aquell dia.

Si una columna és de tipus booleà, compara-la amb `TRUE` o `FALSE`, per exemple `active = TRUE`. Un identificador numèric, un booleà i una cadena de text són tipus diferents.

També podem filtrar per un càlcul, com ara `unit_price * units_in_stock > 1000`. Un àlies definit al `SELECT` no està disponible al `WHERE` del mateix nivell: cal repetir-hi l'expressió. Per exemple, no podem definir `valor_estoc` al `SELECT` i utilitzar directament `WHERE valor_estoc > 1000` en aquella mateixa consulta.

## Exercicis

Practica amb els [exercicis de WHERE amb Northwind](./Exercicis/Northwind/03_where_exercicis.md), amb exemples resolts i activitats per resoldre. També tens una [pràctica amb Sakila](./Exercicis/Sakila/03_where_exercicis.md).

## Resum

La clàusula `WHERE` és essencial per filtrar dades en les consultes SQL. Permet utilitzar una gran varietat d'operadors i combinar condicions per obtenir resultats precisos.
