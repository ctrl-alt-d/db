# Introduint la clàusula ORDER BY

La clàusula `ORDER BY` en SQL permet ordenar els resultats d'una consulta segons una o més columnes. És útil per presentar les dades de manera organitzada i facilitar la seva anàlisi.

## Sintaxi bàsica

```sql
SELECT columnes
FROM taula
ORDER BY columna [ASC|DESC];
```

- `ASC` (ascendent) és l'opció per defecte.
- `DESC` (descendent) ordena de major a menor.

## Exemple senzill

Suposem que tenim una taula `alumnes` amb les columnes `nom` i `edat`. Si volem obtenir la llista d'alumnes ordenada per edat de menor a major:

```sql
SELECT nom, edat
FROM alumnes
ORDER BY edat ASC;
```

Si volem la llista d'alumnes ordenada per edat de major a menor:

```sql
SELECT nom, edat
FROM alumnes
ORDER BY edat DESC;
```

## Ordenar per més d'una columna

Es pot ordenar per diverses columnes. Per exemple, primer per `curs` i després per `nom`:

```sql
SELECT nom, curs
FROM alumnes
ORDER BY curs ASC, nom ASC;
```

## Exemple amb WHERE i ORDER BY

```sql
SELECT nom, edat
FROM alumnes
WHERE edat > 18
ORDER BY nom;
```

Aquest exemple retorna els alumnes majors de 18 anys ordenats alfabèticament pel nom.

## Resum

La clàusula `ORDER BY` permet ordenar els resultats d'una consulta SQL de manera flexible, utilitzant una o diverses columnes i especificant l'ordre ascendent o descendent.