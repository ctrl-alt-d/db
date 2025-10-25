# Introduint funcions d'agregació en SQL

Les funcions d'agregació permeten realitzar càlculs sobre un conjunt de files i retornar un únic valor resum. Són molt útils per obtenir estadístiques i resums de dades.

## Principals funcions d'agregació

- `COUNT()`  Comptar el nombre de files
- `SUM()`    Sumar valors d'una columna
- `AVG()`    Calcular la mitjana
- `MIN()`    Trobar el valor mínim
- `MAX()`    Trobar el valor màxim

## Exemple amb COUNT

Comptar el nombre d'alumnes:

```sql
SELECT COUNT(*)
FROM alumnes;
```

## Exemple amb SUM

Sumar les edats de tots els alumnes:

```sql
SELECT SUM(edat)
FROM alumnes;
```

## Exemple amb AVG

Mitjana d'edat dels alumnes:

```sql
SELECT AVG(edat)
FROM alumnes;
```

## Exemple amb MIN i MAX

Trobar l'edat mínima i màxima:

```sql
SELECT MIN(edat), MAX(edat)
FROM alumnes;
```

## Utilització amb WHERE

Les funcions d'agregació es poden combinar amb la clàusula WHERE per filtrar les files abans de calcular l'agregat:

```sql
SELECT COUNT(*)
FROM alumnes
WHERE curs = '2n';
```

## Resum

Les funcions d'agregació són essencials per obtenir informació resumida de les dades. S'utilitzen sovint amb GROUP BY per agrupar resultats, que veurem en el següent apartat.