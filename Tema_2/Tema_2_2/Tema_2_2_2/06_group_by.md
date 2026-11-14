# Introduint la clàusula GROUP BY en SQL

La clàusula `GROUP BY` permet agrupar files que tenen el mateix valor en una o més columnes. S'utilitza principalment amb funcions d'agregació per obtenir resultats resumits per grups.

## Sintaxi bàsica

```sql
SELECT columna, funció_agregació(columna)
FROM taula
GROUP BY columna;
```

## Exemple senzill

Suposem que tenim una taula `alumnes` amb les columnes `curs` i `edat`. Si volem saber quants alumnes hi ha per cada curs:

```sql
SELECT curs, COUNT(*)
FROM alumnes
GROUP BY curs;
```

## Exemple amb SUM

Sumar les edats dels alumnes per curs:

```sql
SELECT curs, SUM(edat)
FROM alumnes
GROUP BY curs;
```

## Exemple amb més d'una columna

Es pot agrupar per més d'una columna:

```sql
SELECT curs, edat, COUNT(*)
FROM alumnes
GROUP BY curs, edat;
```

## Utilització amb WHERE

La clàusula WHERE filtra les files abans d'agrupar-les:

```sql
SELECT curs, COUNT(*)
FROM alumnes
WHERE edat > 18
GROUP BY curs;
```

## Punt important: columnes i GROUP BY

Com a regla general, **les columnes que apareixen al SELECT i que no estan dins d'una funció d'agregació** (com COUNT, SUM, AVG, MIN, MAX...) **han d'aparèixer també al GROUP BY**. PostgreSQL admet algunes excepcions basades en la dependència funcional respecte d'una clau primària; a les pràctiques escriurem explícitament totes les columnes no agregades.

### Motiu

Quan utilitzem GROUP BY, SQL agrupa les files segons els valors de les columnes indicades. Si posem al SELECT una columna que no està agregada ni al GROUP BY, el sistema no sabrà com agrupar correctament aquests valors, ja que podrien ser diferents dins el mateix grup. Això genera un error perquè SQL no pot decidir quin valor mostrar per cada grup.

### Exemple incorrecte

```sql
SELECT curs, edat, COUNT(*)
FROM alumnes
GROUP BY curs;
```

En aquest cas, `edat` no està agregada ni al GROUP BY. Si hi ha diverses edats per cada curs, SQL no pot saber quina edat mostrar per cada grup de `curs`.

### Exemple correcte

```sql
SELECT curs, COUNT(*)
FROM alumnes
GROUP BY curs;
```

O bé, si volem agrupar per curs i edat:

```sql
SELECT curs, edat, COUNT(*)
FROM alumnes
GROUP BY curs, edat;
```

## Què representa cada fila de resum?

Abans d'escriure la consulta, decideix què ha de representar cada fila: un curs, una categoria o una combinació de botiga i pel·lícula. Afegir una columna al `GROUP BY` pot dividir un grup en diversos grups i canviar el significat del resum.

`GROUP BY` no garanteix l'ordre del resultat. Per ordenar els grups, afegeix `ORDER BY` després de l'agrupació; pots utilitzar-hi els àlies dels agregats.

Els valors `NULL` d'una columna d'agrupació es reuneixen en un mateix grup. Amb diverses columnes, cada combinació de valors defineix el seu grup. Dins de cada grup, `COUNT(*)`, `COUNT(columna)` i `COUNT(DISTINCT columna)` mantenen el tractament dels nuls explicat a les [funcions d'agregació](./05_funcions_agregacio.md).

Una agrupació només produeix els grups que tenen files després del `WHERE`. Si no hi ha cap fila d'un idioma a `film`, agrupar aquesta taula per `language_id` no crea una fila amb recompte zero per a aquell idioma. Per conservar també els idiomes sense pel·lícules caldrà un `LEFT JOIN`, que veurem al tema 09.

## Agrupar per una expressió o per mes

Podem agrupar per una expressió, no només per una columna. En PostgreSQL, `date_trunc('month', payment_date)` retorna l'inici del mes de cada data i hora, conservant-ne l'any:

```sql
SELECT date_trunc('month', payment_date) AS mes,
       COUNT(*) AS total_pagaments,
       SUM(amount) AS import_total
FROM payment
GROUP BY date_trunc('month', payment_date)
ORDER BY mes ASC;
```

Així, el gener del 2005 i el gener del 2006 formen grups diferents. Agrupar només pel número de mes els barrejaria. El `GROUP BY` repeteix l'expressió del `SELECT` per deixar explícit què defineix cada grup.

## Exercicis

Practica amb els [exercicis de GROUP BY amb Northwind](./06_group_by_exercicis.md), amb exemples resolts i activitats per resoldre.

## Resum

La clàusula `GROUP BY` és essencial per agrupar dades i aplicar funcions d'agregació sobre cada grup. Permet obtenir informació resumida i estadístiques per categories o grups dins les taules. A les pràctiques, inclou al `GROUP BY` totes les columnes del `SELECT` que no siguin agregades.
