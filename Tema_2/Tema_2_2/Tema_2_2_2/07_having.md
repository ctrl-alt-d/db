# Introduint la clàusula HAVING en SQL

La clàusula `HAVING` permet filtrar els resultats després d'aplicar la clàusula `GROUP BY`. És similar a `WHERE`, però s'utilitza per posar condicions sobre els grups i els resultats de funcions d'agregació.

## Diferència entre WHERE i HAVING
- `WHERE` filtra les files abans d'agrupar-les.
- `HAVING` filtra els grups després d'aplicar `GROUP BY`.

## Sintaxi bàsica

```sql
SELECT columna, funció_agregació(columna)
FROM taula
GROUP BY columna
HAVING condició;
```

## Exemple senzill

Suposem que volem saber quins cursos tenen més de 5 alumnes:

```sql
SELECT curs, COUNT(*) AS num_alumnes
FROM alumnes
GROUP BY curs
HAVING COUNT(*) > 5;
```

## Exemple amb SUM

Cursos on la suma de les edats supera 100:

```sql
SELECT curs, SUM(edat) AS suma_edats
FROM alumnes
GROUP BY curs
HAVING SUM(edat) > 100;
```

## Exemple combinat amb WHERE

Primer filtrem alumnes majors de 18 anys, després agrupem i filtrem grups:

```sql
SELECT curs, COUNT(*)
FROM alumnes
WHERE edat > 18
GROUP BY curs
HAVING COUNT(*) > 2;
```

## Diverses condicions, àlies i ordre de les clàusules

Podem combinar condicions sobre agregats amb `AND` i `OR`. Per exemple, `HAVING COUNT(*) >= 3 AND AVG(preu) > 30` exigeix totes dues condicions sobre el mateix grup. També podem comparar expressions, com ara `HAVING COUNT(*) - COUNT(fax) > 0`, per detectar grups amb algun fax nul.

Si filtrem abans amb `WHERE fax IS NULL`, el recompte ja no representa totes les files originals del grup, sinó només les que tenen el fax nul. Cal distingir «comptar totes les files i detectar-hi una absència» de «comptar només les absències».

En PostgreSQL, un àlies definit al `SELECT` es pot utilitzar a l'`ORDER BY`, però no al `HAVING`: escriu `HAVING COUNT(*) >= 3`, no `HAVING total >= 3` si `total` és l'àlies d'aquell recompte.

L'ordre d'escriptura de les clàusules que utilitzem és:

```text
SELECT → FROM → WHERE → GROUP BY → HAVING → ORDER BY → LIMIT / OFFSET
```

Per interpretar-les, partim de les files del `FROM`, apliquem `WHERE`, formem els grups i els filtrem amb `HAVING`; finalment es projecten i s'ordenen els resultats. Una condició agregada no pot anar al `WHERE` del mateix nivell perquè aquell filtre s'aplica abans de formar els grups.

## Exercicis

Practica amb els [exercicis de HAVING amb Northwind](./Exercicis/Northwind/07_having_exercicis.md), amb exemples resolts i activitats per resoldre. També tens una [pràctica amb Sakila](./Exercicis/Sakila/07_having_exercicis.md).

## Resum

La clàusula `HAVING` permet posar condicions sobre grups i resultats agregats. Quan la consulta té `GROUP BY`, s'escriu després d'aquesta clàusula. També es pot utilitzar sense `GROUP BY`, tractant el conjunt de files com un únic grup.
