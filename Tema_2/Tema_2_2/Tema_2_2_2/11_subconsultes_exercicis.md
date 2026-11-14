# Exercicis de subconsultes amb Northwind (PostgreSQL)

## Objectius i instruccions

Practicar subconsultes escalars, subconsultes amb `IN`, `ANY` i `ALL`, subconsultes correlacionades i l'operador `NOT EXISTS`. Utilitzar també subconsultes al `SELECT` i composicions internes dins d'una subconsulta.

Treballa amb la mateixa base de dades **Northwind** de les [pràctiques anteriors](./readme.md). Mantén els noms de les taules i les columnes en anglès.

- Resol cada exercici amb les subconsultes indicades. A l'exercici 8, utilitza un `JOIN` dins de la subconsulta. Als altres exercicis no cal utilitzar `JOIN`; no cal utilitzar `UNION` en cap exercici.
- Escriu una consulta per exercici, excepte quan l'enunciat en demani més d'una.
- Utilitza àlies per distingir les taules de la consulta externa i de les subconsultes correlacionades.
- Mostra només les columnes demanades, en l'ordre indicat, i respecta els criteris d'ordenació i de desempat.
- No cal arrodonir els resultats. Desa les consultes en un fitxer `.sql` i identifica cada exercici amb un comentari.
- Un resultat buit pot ser correcte: depèn de les dades i de la condició.

**Material de consulta:** [Subconsultes](./11_subconsultes.md), [Funcions d'agregació](./05_funcions_agregacio.md), [GROUP BY](./06_group_by.md), [HAVING](./07_having.md) i [JOIN](./09_joins.md).

## Taules i columnes que utilitzarem

La taula següent recull només les columnes necessàries per a aquesta pràctica; no és l'esquema complet de Northwind.

| Taula | Columnes |
| --- | --- |
| `products` | `product_id`, `product_name`, `category_id`, `unit_price` |
| `customers` | `customer_id`, `company_name` |
| `orders` | `order_id`, `customer_id`, `order_date` |
| `order_details` | `order_id`, `product_id` |

Les relacions necessàries són `orders.customer_id → customers.customer_id`, `order_details.product_id → products.product_id` i `order_details.order_id → orders.order_id`.

## Recordatoris per a la pràctica

- Una subconsulta escalar retorna una columna i, com a màxim, una fila. Si no retorna cap fila, el seu valor és `NULL`; si retorna més d'una fila, PostgreSQL dona error.
- `IN` permet comparar amb diversos valors. No cal eliminar-ne els duplicats perquè la comprovació de pertinença funcioni.
- Una subconsulta correlacionada fa referència a columnes de la consulta externa. Cal comprovar que la condició relaciona els àlies correctes.
- `EXISTS` comprova si hi ha almenys una fila; `NOT EXISTS` comprova que no n'hi hagi cap. `SELECT 1` és suficient dins d'aquestes subconsultes.
- `NOT IN` no substitueix sempre `NOT EXISTS`: si la subconsulta retorna un `NULL`, pot fer que no se seleccionin files que esperàvem obtenir.
- Assigna un àlies a cada subconsulta del `FROM`, per exemple `AS totals_comanda`.

## Exemples resolts

Intenta escriure cada consulta abans d'obrir-ne la solució.

### 1. Productes més cars que la mitjana del catàleg

**Objectiu:** comparar amb una subconsulta escalar.

**Enunciat:** mostra l'identificador, el nom i el preu dels productes amb un preu estrictament superior a la mitjana de tots els preus coneguts. Ordena per preu descendent i desempata per identificador de producte ascendent.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT p.product_id, p.product_name, p.unit_price
FROM products AS p
WHERE p.unit_price > (
    SELECT AVG(p2.unit_price)
    FROM products AS p2
)
ORDER BY p.unit_price DESC, p.product_id ASC;
```

La subconsulta calcula un únic valor, la mitjana global. Els preus nuls no participen en la mitjana ni satisfan la comparació externa.

</details>

### 2. Clients que no han fet cap comanda

**Objectiu:** comprovar l'absència de files amb una subconsulta correlacionada.

**Enunciat:** mostra l'identificador i el nom de l'empresa dels clients sense cap comanda. Utilitza `NOT EXISTS` i ordena per identificador de client ascendent.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT c.customer_id, c.company_name
FROM customers AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.customer_id = c.customer_id
)
ORDER BY c.customer_id ASC;
```

La condició interna busca comandes del client de la fila externa. El client només es mostra si no se'n troba cap. Una comanda amb `customer_id` nul no coincideix amb cap identificador de client i no altera aquesta comprovació.

</details>

## Exercicis per practicar

Els exercicis següents no inclouen solució.

### 3. Productes de categories amb almenys deu productes

**Objectiu:** utilitzar `IN` amb una subconsulta que agrupa i filtra grups.

**Enunciat:** mostra l'identificador, el nom i l'identificador de categoria dels productes que pertanyen a categories amb almenys 10 productes. La subconsulta ha de retornar els `category_id` no nuls que compleixen aquest recompte. Ordena per categoria i després per identificador de producte, tots dos ascendents.

**Pista:** combina `GROUP BY` i `HAVING` dins de la subconsulta.

### 4. Productes més cars de cada categoria

**Objectiu:** comparar amb un agregat correlacionat i conservar els empats.

**Enunciat:** mostra l'identificador, el nom, la categoria i el preu de tots els productes que tenen el preu màxim de la seva categoria. Considera només productes amb categoria i preu no nuls. Si hi ha diversos productes empatats al màxim, mostra'ls tots. Ordena per categoria i després per identificador de producte, tots dos ascendents.

**Pista:** la subconsulta ha de calcular `MAX(unit_price)` només per a la categoria del producte extern. No utilitzis `LIMIT 1`.

### 5. Productes més cars que la mitjana

**Objectiu:** comparar el preu d'un producte amb una mitjana calculada en una subconsulta escalar.

**Enunciat:** mostra `product_id`, `product_name` i `unit_price` dels productes amb un preu estrictament superior a la mitjana dels preus de tot el catàleg. Calcula la mitjana amb una subconsulta sobre `products`. Ordena per preu descendent i desempata per identificador de producte ascendent.

**Pregunta:** com intervenen els preus nuls en el càlcul de la mitjana i en la comparació externa?

### 6. Comptar comandes des del SELECT

**Objectiu:** utilitzar una subconsulta escalar correlacionada al `SELECT`.

**Enunciat:** mostra l'identificador i el nom de l'empresa de tots els clients. Afegeix una columna `total_comandes` calculada amb una subconsulta al `SELECT` que compti les comandes del client. Els clients sense comandes han de mostrar `0`. Ordena per `total_comandes` descendent i desempata per identificador de client ascendent.

**Pregunta:** per què la subconsulta amb `COUNT(*)` retorna un únic valor encara que el client tingui diverses comandes?

### 7. Comparar amb algun preu o amb tots els preus

**Objectiu:** distingir `ANY` i `ALL`.

**Enunciat:** considera com a referència els preus no nuls dels productes de la categoria `1`. Escriu dues consultes que mostrin l'identificador, el nom i el preu dels productes d'altres categories amb categoria i preu no nuls:

1. Productes més cars que almenys un preu de referència, amb `> ANY`.
2. Productes més cars que tots els preus de referència, amb `> ALL`.

En tots dos casos, ordena per preu descendent i desempata per identificador de producte ascendent.

**Pregunta:** substitueix el filtre de la subconsulta per `WHERE 1 = 0`. Com canvia el resultat de cada consulta quan el conjunt de referència és buit?

### 8. Productes que no s'han comprat des d'una data

**Objectiu:** combinar `NOT EXISTS`, una subconsulta correlacionada i un `INNER JOIN` per comprovar l'absència de compres en un període.

**Enunciat:** pren com a data de referència **X = 1 de gener de 1998**, inclosa. Mostra `product_id` i `product_name` dels productes que no apareixen en cap comanda amb `order_date >= DATE '1998-01-01'`. Inclou tant els productes que només es van comprar abans d'aquesta data com els que no s'han comprat mai. Ordena per identificador de producte ascendent.

La consulta externa ha de consultar `products`. Dins de `NOT EXISTS`, combina `order_details` amb `orders` mitjançant un `INNER JOIN` sobre `order_id`: la línia identifica el producte i la capçalera de la comanda n'indica la data. Relaciona el producte de la subconsulta amb el de la fila externa.

**Pregunta:** per què buscar una compra anterior a X no és suficient per respondre l'enunciat? Què ha de passar amb un producte que té una compra anterior i una altra de posterior a X?
