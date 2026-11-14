# Introduint funcions d'agregació en SQL

Les funcions d'agregació permeten realitzar càlculs sobre un conjunt de files i retornar un únic valor resum. Són molt útils per obtenir estadístiques i resums de dades.

## Principals funcions d'agregació

- `COUNT()`  Comptar files o valors no nuls, segons l'argument
- `SUM()`    Sumar valors d'una columna
- `AVG()`    Calcular la mitjana
- `MIN()`    Trobar el valor mínim
- `MAX()`    Trobar el valor màxim

## Comptar amb COUNT(*), COUNT(expressió) i COUNT(DISTINCT expressió)

Aquestes tres formes de `COUNT` responen a preguntes diferents:

| Forma | Què compta? | Tractament de `NULL` i dels duplicats |
| --- | --- | --- |
| `COUNT(*)` | Totes les files que arriben a l'agregació. | Compta cada fila, encara que contingui valors `NULL`. |
| `COUNT(expressió)` | Les files en què l'expressió dona un resultat no nul. | Ignora els resultats `NULL`, però compta els valors repetits. |
| `COUNT(DISTINCT expressió)` | Els valors diferents i no nuls de l'expressió. | Ignora els resultats `NULL` i compta cada valor diferent una sola vegada. |

Una **expressió** pot ser una columna, com ara `edat`, o un càlcul. El criteri és si el resultat de l'expressió és nul. Els espais dins dels parèntesis no canvien el significat: `COUNT( edat )` equival a `COUNT(edat)`.

Suposem que la taula `alumnes` conté aquestes dades fictícies. Farem servir les mateixes dades en els exemples de tractament de `NULL`:

| id | edat |
| --- | --- |
| 1 | 18 |
| 2 | 21 |
| 3 | 21 |
| 4 | `NULL` |
| 5 | `NULL` |

```sql
SELECT COUNT(*) AS total_alumnes,
       COUNT(edat) AS alumnes_amb_edat,
       COUNT(DISTINCT edat) AS edats_diferents
FROM alumnes;
```

| total_alumnes | alumnes_amb_edat | edats_diferents |
| --- | --- | --- |
| 5 | 3 | 2 |

Hi ha cinc alumnes, però només tres tenen l'edat informada. Les edats diferents conegudes són dues: `18` i `21`. `NULL` no es compta com una tercera edat diferent.

> `COUNT(*)` compta files, no columnes. A més, `COUNT(1)` també compta totes les files perquè la constant `1` mai no és nul·la; no significa «comptar la primera columna».

## Exemple amb SUM

Sumar les edats de tots els alumnes:

```sql
SELECT SUM(edat)
FROM alumnes;
```

## Agregar expressions calculades per fila

L'argument d'un agregat també pot ser una expressió calculada per fila. Per exemple, per sumar l'import brut de totes les línies de comanda registrades:

```sql
SELECT SUM(unit_price * quantity) AS import_brut
FROM order_details;
```

En aquest exemple es resumeixen totes les línies de la taula; per obtenir un import per comanda caldrà agrupar per `order_id`. `SUM(unit_price * quantity)` no equival, en general, a `SUM(unit_price) * SUM(quantity)`: primer cal calcular l'import de cada línia i després sumar-lo.

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

## Combinar columnes i funcions d'agregació al SELECT

No podem combinar lliurement columnes individuals i resultats agregats en un mateix `SELECT`. Sense `GROUP BY`, l'agregació resumeix totes les files en una sola fila de resultat. Si també seleccionem una columna sense agregar-la, quina de les seves files hauria d'aportar el valor?

Per exemple, aquesta consulta **dona error en PostgreSQL**:

```sql
-- Incorrecte: edat no està agregada ni apareix en un GROUP BY.
SELECT edat, COUNT(*) AS total_alumnes
FROM alumnes;
```

`COUNT(*)` retorna un únic recompte de tots els alumnes, però `edat` pot tenir valors diferents. La consulta no especifica quina edat hauria d'acompanyar aquest recompte.

**Com a regla general, cada columna del `SELECT` ha d'estar dins d'una funció d'agregació o inclosa al `GROUP BY` quan la consulta conté agregacions.** Podem corregir la consulta de dues maneres, segons la informació que vulguem obtenir:

### Agregar també la columna

Si volem un resum global amb l'edat mínima i el total d'alumnes:

```sql
SELECT MIN(edat) AS edat_minima,
       COUNT(*) AS total_alumnes
FROM alumnes;
```

Amb les dades fictícies anteriors, obtenim una sola fila amb `18` i `5`. Cal triar una funció d'agregació que tingui sentit per a la pregunta que volem respondre.

### Incloure la columna al GROUP BY

Si volem comptar els alumnes de cada edat:

```sql
SELECT edat, COUNT(*) AS total_alumnes
FROM alumnes
GROUP BY edat;
```

Ara obtenim una fila per cada grup d'edat, amb el seu recompte. **Veurem el funcionament de `GROUP BY` en el següent apartat.**

### Una funció no agregada no resol el problema

Aplicar una funció com `ROUND` (arrodoniment) a una columna no l'agrega: `SELECT ROUND(edat), COUNT(*) FROM alumnes;` també dona error en PostgreSQL sense un `GROUP BY` que inclogui `edat`.

En canvi, podem aplicar una funció al resultat d'una agregació:

```sql
SELECT ROUND(AVG(edat), 1) AS mitjana_arrodonida
FROM alumnes;
```

Aquí `AVG` ja ha resumit les edats en un únic valor, i `ROUND` arrodoneix aquest resultat a una xifra decimal. Per tant, la restricció afecta les **columnes que queden fora de les agregacions**, no el fet de combinar funcions en si mateix.

## Utilització amb WHERE

Les funcions d'agregació es poden combinar amb la clàusula WHERE per filtrar les files abans de calcular l'agregat:

```sql
SELECT COUNT(*)
FROM alumnes
WHERE curs = '2n';
```

## Tractament sistemàtic dels valors NULL

`NULL` indica que no disposem d'un valor: pot ser desconegut, absent o no aplicable. **No equival a zero ni a una cadena buida** (`''`). Per interpretar una agregació, cal distingir les files existents dels valors coneguts.

### 1. Identificar quins valors entren en el càlcul

Les funcions `SUM`, `AVG`, `MIN` i `MAX` **ignoren els resultats `NULL` de l'expressió**. No els substitueixen automàticament per zero. Amb les dades fictícies anteriors:

```sql
SELECT SUM(edat) AS suma_edats,
       AVG(edat) AS mitjana_edat,
       MIN(edat) AS edat_minima,
       MAX(edat) AS edat_maxima
FROM alumnes;
```

| suma_edats | mitjana_edat | edat_minima | edat_maxima |
| --- | --- | --- | --- |
| 60 | 20 | 18 | 21 |

La mitjana és `(18 + 21 + 21) / 3 = 20`: el divisor és el nombre d'edats no nul·les, no el nombre total de files. Per això, `SUM(edat) / COUNT(*)` no equival, en general, a `AVG(edat)` quan hi ha edats nul·les.

### 2. Distingir l'absència de valors d'un resultat igual a zero

Quan totes les edats són `NULL`, `COUNT(*)` encara compta les files, però `COUNT(edat)` i `COUNT(DISTINCT edat)` retornen `0`. En canvi, `SUM(edat)`, `AVG(edat)`, `MIN(edat)` i `MAX(edat)` retornen `NULL`.

Si el filtre no selecciona cap fila, una consulta d'agregació **sense `GROUP BY`** retorna igualment una fila de resum:

```sql
SELECT COUNT(*) AS total,
       COUNT(edat) AS edats_informades,
       COUNT(DISTINCT edat) AS edats_diferents,
       SUM(edat) AS suma_edats,
       AVG(edat) AS mitjana_edat,
       MIN(edat) AS edat_minima,
       MAX(edat) AS edat_maxima
FROM alumnes
WHERE 1 = 0; -- Condició sempre falsa: no selecciona cap fila.
```

| total | edats_informades | edats_diferents | suma_edats | mitjana_edat | edat_minima | edat_maxima |
| --- | --- | --- | --- | --- | --- | --- |
| 0 | 0 | 0 | `NULL` | `NULL` | `NULL` | `NULL` |

Un `SUM` nul indica que no hi ha valors per sumar; no afirma que la suma de valors coneguts sigui zero.

### 3. Detectar i comptar els valors absents

Per comprovar si un valor és nul, utilitzem `IS NULL` o `IS NOT NULL`, mai `= NULL` ni `<> NULL`. Podem comptar les edats absents filtrant les files:

```sql
SELECT COUNT(*) AS alumnes_sense_edat
FROM alumnes
WHERE edat IS NULL;
```

Amb les dades d'exemple, el resultat és `2`. També podem obtenir en una mateixa consulta el total, els valors informats i els absents:

```sql
SELECT COUNT(*) AS total_alumnes,
       COUNT(edat) AS alumnes_amb_edat,
       COUNT(*) - COUNT(edat) AS alumnes_sense_edat
FROM alumnes;
```

El resultat és `5`, `3` i `2`, respectivament. La resta funciona perquè tots dos recomptes s'apliquen al mateix conjunt de files.

### 4. Decidir si cal substituir NULL amb COALESCE

`COALESCE(expressió, valor_alternatiu)` retorna el primer argument no nul. La posició de `COALESCE` determina si substituïm el resultat final o els valors abans d'agregar-los:

```sql
SELECT COALESCE(AVG(edat), 0) AS mitjana_o_zero,
       AVG(COALESCE(edat, 0)) AS mitjana_amb_zeros
FROM alumnes;
```

- `COALESCE(AVG(edat), 0)` calcula la mitjana de les edats conegudes i només retorna `0` si la mitjana és `NULL`. Amb les dades d'exemple, dona `20`.
- `AVG(COALESCE(edat, 0))` substitueix cada edat nul·la per `0` abans del càlcul. Amb les dades d'exemple, dona `(18 + 21 + 21 + 0 + 0) / 5 = 12`.

En aquest exemple, assignar una edat de zero anys als alumnes amb edat desconeguda altera el significat de la mitjana. **Només hem de substituir `NULL` per un valor quan el context ho justifiqui.** Si no hi ha cap fila, `AVG(COALESCE(edat, 0))` també retorna `NULL`: no hi ha cap fila en què es pugui fer la substitució.

## Exercicis per practicar

Per treballar amb Northwind, consulta els [exercicis de funcions d'agregació](./05_funcions_agregacio_exercicis.md), amb exemples resolts i activitats per resoldre.

Utilitza la taula fictícia anterior i intenta resoldre aquests exercicis abans d'executar les consultes:

1. Escriu una consulta que mostri el nombre total d'alumnes, quants tenen l'edat informada i quantes edats diferents hi ha entre els alumnes amb `edat >= 21`.
2. Aplica el filtre `WHERE edat IS NULL` i prediu els resultats de `COUNT(*)`, `COUNT(edat)`, `COUNT(DISTINCT edat)`, `SUM(edat)` i `AVG(edat)`. Explica cada resultat.
3. Compara `COALESCE(SUM(edat), 0)` i `SUM(COALESCE(edat, 0))` amb el filtre `WHERE 1 = 0`. Per què no retornen el mateix?

## Resum

Les funcions d'agregació són essencials per obtenir informació resumida de les dades. Per interpretar-les correctament, cal saber si comptem files, valors no nuls o valors diferents, i com es tracten els `NULL`. S'utilitzen sovint amb `GROUP BY` per agrupar resultats, que veurem en el següent apartat.

## Referències

- [Documentació de PostgreSQL: funcions d'agregació](https://www.postgresql.org/docs/current/functions-aggregate.html).
- [Documentació de PostgreSQL: expressions d'agregació i DISTINCT](https://www.postgresql.org/docs/current/sql-expressions.html#SYNTAX-AGGREGATES).
- [Documentació de PostgreSQL: COALESCE](https://www.postgresql.org/docs/current/functions-conditional.html#FUNCTIONS-COALESCE-NVL-IFNULL).
