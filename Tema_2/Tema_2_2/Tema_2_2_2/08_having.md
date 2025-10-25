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

## Resum

La clàusula `HAVING` és imprescindible per posar condicions sobre grups i resultats agregats. S'utilitza sempre després de `GROUP BY` i permet obtenir resultats més precisos en consultes amb agregacions.