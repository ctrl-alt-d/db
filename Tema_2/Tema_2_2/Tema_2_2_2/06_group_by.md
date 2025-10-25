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

És molt important recordar que **totes les columnes que apareixen al SELECT i que no estan dins d'una funció d'agregació** (com COUNT, SUM, AVG, MIN, MAX...) **han d'aparèixer també al GROUP BY**.

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

## Resum

La clàusula `GROUP BY` és essencial per agrupar dades i aplicar funcions d'agregació sobre cada grup. Permet obtenir informació resumida i estadístiques per categories o grups dins les taules. Recorda: totes les columnes del SELECT que no són agregades han d'estar al GROUP BY.