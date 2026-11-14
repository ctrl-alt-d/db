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

### 4. FULL OUTER JOIN

Retorna totes les files de les dues taules. Si no hi ha coincidència, les columnes de la taula sense coincidència seran NULL.

```sql
SELECT a.nom, b.nom_curs
FROM alumnes a
FULL OUTER JOIN cursos b ON a.curs_id = b.id;
```

### 5. CROSS JOIN

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

### FULL OUTER JOIN
Obtenir tots els gossos i totes les races, coincideixin o no:

```sql
SELECT g.nom AS nom_gos, r.nom AS nom_raça
FROM gossos g
FULL OUTER JOIN raça r ON g.raça = r.id;
```
Els gossos sense raça definida tindran `nom_raça` a NULL, i les races sense cap gos tindran `nom_gos` a NULL.


## Encadenar composicions entre diverses taules

Cada `JOIN` incorpora una taula amb la seva condició d'enllaç. Per obtenir el client i els productes de les seves comandes, seguim `customers → orders → order_details → products`:

```sql
SELECT c.customer_id, o.order_id, p.product_id, p.product_name
FROM customers AS c
INNER JOIN orders AS o ON o.customer_id = c.customer_id
INNER JOIN order_details AS od ON od.order_id = o.order_id
INNER JOIN products AS p ON p.product_id = od.product_id;
```

Cada fila representa una línia de comanda. Un client pot aparèixer moltes vegades; no és un error de la composició. Si calculem imports històrics, utilitzem el preu de `order_details`, no necessàriament el preu actual de `products`.

## Condicions ON i filtres WHERE en una composició externa

L'`ON` determina quines files poden coincidir. Després, el `WHERE` filtra el resultat, incloses les files amb `NULL` que ha conservat la composició externa.

```sql
SELECT c.customer_id, o.order_id
FROM customers AS c
LEFT JOIN orders AS o
    ON o.customer_id = c.customer_id
   AND o.order_date >= DATE '1997-01-01'
   AND o.order_date < DATE '1998-01-01';
```

Això conserva tots els clients, amb les seves comandes del 1997 si en tenen. Posar els filtres de data al `WHERE` eliminaria les files sense comanda coincident, perquè comparar la data nul·la amb un límit no dona `TRUE`.

Per detectar absències amb `LEFT JOIN`, comprova `IS NULL` sobre una clau primària de la taula dreta, com ara `o.order_id`. Una altra columna nullable podria ser nul·la encara que existís la coincidència. El raonament és equivalent en un `RIGHT JOIN`, intercanviant els costats. Un `FULL JOIN` permet detectar absències a qualsevol costat.

## Comptar coincidències i conservar els zeros

```sql
SELECT c.customer_id, c.company_name, COUNT(o.order_id) AS total_comandes
FROM customers AS c
LEFT JOIN orders AS o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.company_name
ORDER BY c.customer_id ASC;
```

`COUNT(o.order_id)` compta només les comandes coincidents i dona 0 quan no n'hi ha. `COUNT(*)` també comptaria la fila amb nuls que conserva el `LEFT JOIN` i donaria 1 per a un client sense comandes.

Si afegim les línies de comanda a aquesta composició, una comanda pot aparèixer diverses vegades. Abans d'agregar, comprova què representa cada fila; per comptar comandes diferents en aquell resultat, caldria `COUNT(DISTINCT o.order_id)`.

## Composició d'una taula amb si mateixa

Un *self join* combina dues referències a una mateixa taula. Cada referència necessita un àlies diferent. Per obtenir parelles de productes de la mateixa categoria:

```sql
SELECT p1.product_id AS producte_1, p2.product_id AS producte_2
FROM products AS p1
INNER JOIN products AS p2 ON p1.category_id = p2.category_id
WHERE p1.product_id < p2.product_id;
```

La desigualtat exclou cada producte amb si mateix i conserva només una de les parelles simètriques `(A, B)` i `(B, A)`.

## Exercicis

Practica amb els [exercicis de JOIN amb Northwind](./09_joins_exercicis.md), amb exemples resolts i activitats per resoldre.

## Resum

- **INNER JOIN**: només coincidències a ambdues taules.
- **LEFT OUTER JOIN**: totes les files de l'esquerra, coincidències de la dreta de la paraula `join`.
- **RIGHT OUTER JOIN**: totes les files de la dreta, coincidències de l'esquerra de la paraula `join`.
- **FULL OUTER JOIN**: totes les files de les dues taules, amb NULLs on no hi ha coincidència.
- **CROSS JOIN**: totes les combinacions possibles.

Els joins són essencials per consultar dades relacionades i construir consultes avançades en SQL.
