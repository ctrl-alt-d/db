# Exercicis de JOIN amb Northwind (PostgreSQL)

> **Entorn:** si encara no tens la base de dades Northwind en marxa, segueix la [guia d'instal·lació i connexió](./readme.md#entorn-de-treball).

## Objectius i instruccions

Practicar la combinació de taules amb `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `FULL JOIN` i `CROSS JOIN`, i interpretar les files sense coincidència.

Treballa amb la mateixa base de dades **Northwind** de les [pràctiques anteriors](./readme.md). Mantén els noms de les taules i les columnes en anglès.

- Escriu i executa una consulta per exercici, excepte quan l'enunciat en demani més d'una.
- Utilitza àlies de taula amb `AS`, com ara `products AS p`, i qualifica les columnes amb l'àlies: `p.product_id`.
- Escriu explícitament el tipus de `JOIN` i la condició `ON`. El `CROSS JOIN` no necessita `ON`.
- Mostra només les columnes demanades, en l'ordre indicat, i respecta els criteris d'ordenació i de desempat.
- No cal utilitzar subconsultes ni `UNION`. No cal arrodonir els imports.
- Desa les consultes en un fitxer `.sql` i identifica cada exercici amb un comentari.
- Un resultat buit pot ser correcte: depèn de si les dades contenen casos que compleixin les condicions. No cal modificar les dades per resoldre els exercicis.

**Material de consulta:** [Introducció als JOIN](../../09_joins.md), [GROUP BY](../../06_group_by.md) i [Tractament de NULL i funcions d'agregació](../../05_funcions_agregacio.md).

## Taules, columnes i relacions

La taula següent recull només les columnes necessàries per a aquesta pràctica; no és l'esquema complet de Northwind.

| Taula | Columnes |
| --- | --- |
| `categories` | `category_id`, `category_name` |
| `products` | `product_id`, `product_name`, `category_id`, `unit_price` |
| `customers` | `customer_id`, `company_name` |
| `orders` | `order_id`, `customer_id`, `order_date` |
| `order_details` | `order_id`, `product_id`, `unit_price`, `quantity` |
| `shippers` | `shipper_id`, `company_name` |

Relaciona les taules a partir de les claus següents:

| Clau forana (foreign key) | Clau referenciada |
| --- | --- |
| `products.category_id` | `categories.category_id` |
| `orders.customer_id` | `customers.customer_id` |
| `order_details.order_id` | `orders.order_id` |
| `order_details.product_id` | `products.product_id` |

## Recordatoris per a la pràctica

- `INNER JOIN` conserva només les coincidències; els *outer joins* (unions externes) també conserven les files sense coincidència del costat indicat.
- Una fila pot aparèixer diverses vegades si té diverses coincidències: un client amb tres comandes produeix tres files en combinar `customers` i `orders`. No utilitzis `DISTINCT` per amagar aquesta relació.
- En un `LEFT JOIN`, `ON` determina quines files de la dreta coincideixen. Un `WHERE` posterior pot eliminar les files conservades amb valors nuls.
- Per detectar l'absència de coincidència, comprova amb `IS NULL` una clau de la taula que pot quedar sense correspondència, com ara `o.order_id`.
- Amb un `LEFT JOIN`, `COUNT(o.order_id)` compta les comandes coincidents; `COUNT(*)` també compta la fila conservada d'un client sense comandes.
- `CROSS JOIN` genera totes les combinacions possibles, sense buscar una relació entre claus.

## Exemples resolts

Intenta escriure cada consulta abans d'obrir-ne la solució.

### 1. Productes amb el nom de la categoria

**Objectiu:** combinar dues taules amb `INNER JOIN`.

**Enunciat:** mostra l'identificador i el nom del producte, el nom de la categoria i el preu unitari. Inclou només els productes amb una categoria coincident. Ordena per nom de categoria ascendent i, dins de cada categoria, per identificador de producte ascendent.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT p.product_id, p.product_name, c.category_name, p.unit_price
FROM products AS p
INNER JOIN categories AS c ON p.category_id = c.category_id
ORDER BY c.category_name ASC, p.product_id ASC;
```

La relació es fa mitjançant `category_id`, no comparant els noms ni els identificadors de producte amb els de categoria.

</details>

### 2. Tots els clients i les seves comandes del 1997

**Objectiu:** conservar les files de l'esquerra i filtrar les coincidències amb `ON`.

**Enunciat:** mostra l'identificador i el nom de l'empresa clienta, l'identificador de comanda i la data de les seves comandes del 1997. Inclou tots els clients, encara que no tinguin cap comanda d'aquell any. Ordena per identificador de client ascendent i després per identificador de comanda ascendent, amb els valors nuls al final.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT c.customer_id, c.company_name, o.order_id, o.order_date
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
   AND o.order_date >= DATE '1997-01-01'
   AND o.order_date < DATE '1998-01-01'
ORDER BY c.customer_id ASC, o.order_id ASC NULLS LAST;
```

Els límits de dates formen part de l'`ON`: només les comandes del 1997 poden coincidir. Si un client no en té cap, es conserva una fila amb les columnes de la comanda a `NULL`, encara que tingui comandes d'altres anys.

Si poséssim aquests límits al `WHERE`, les files sense comanda coincident s'eliminarien i deixaríem de mostrar tots els clients.

</details>

## Exercicis per practicar

Els exercicis següents no inclouen solució.

### 3. Detall dels productes de les comandes

**Objectiu:** encadenar dos `INNER JOIN` per consultar tres taules.

**Enunciat:** utilitza `orders`, `order_details` i `products`. Per a les comandes del 1997, mostra l'identificador de comanda, la data, l'identificador i el nom del producte, la quantitat i l'import brut de la línia (`import_brut`). Calcula aquest import multiplicant el preu unitari de la línia per la quantitat, sense aplicar descomptes. Ordena per identificador de comanda i després per identificador de producte, tots dos ascendents.

**Pista:** `order_details.unit_price` és el preu de la línia de comanda; `products.unit_price` és el preu del catàleg. Per a l'import de la línia, utilitza el primer.

### 4. Clients sense cap comanda

**Objectiu:** detectar files sense coincidència i interpretar un `RIGHT JOIN`.

**Enunciat:** mostra l'identificador i el nom de l'empresa dels clients que no tenen cap comanda. Ordena per identificador de client ascendent.

1. Escriu una consulta que comenci amb `FROM orders AS o` i utilitzi `RIGHT JOIN customers AS c`.
2. Escriu una consulta equivalent que comenci amb `FROM customers AS c` i utilitzi `LEFT JOIN orders AS o`.
3. Explica quina columna comproves amb `IS NULL` i per què.

### 5. Categories i productes, amb coincidència o sense

**Objectiu:** conservar les files sense coincidència de tots dos costats amb `FULL JOIN`.

**Enunciat:** utilitza `categories AS c` i `products AS p`. Mostra l'identificador i el nom de la categoria, i l'identificador i el nom del producte. Inclou totes les categories i tots els productes, encara que no tinguin correspondència a l'altra taula. Ordena per identificador de categoria ascendent, amb els nuls al final, i després per identificador de producte ascendent, també amb els nuls al final.

**Preguntes:** quines columnes serien nul·les en una categoria sense productes? I en un producte amb `category_id` nul? Si totes les files tenen coincidència, en què es diferenciaria el resultat del d'un `INNER JOIN`?

### 6. Combinacions de categories i transportistes

**Objectiu:** generar un producte cartesià amb `CROSS JOIN`.

**Enunciat:** per preparar una graella de possibles combinacions, mostra l'identificador i el nom de cada categoria juntament amb l'identificador i el nom de cada transportista de `shippers`. Inclou totes les combinacions possibles. Anomena el nom del transportista `nom_transportista` i ordena per identificador de categoria i després per identificador de transportista, tots dos ascendents.

La consulta genera una graella hipotètica; no indica quins transportistes han transportat realment productes de cada categoria.

**Pregunta:** si hi ha *C* categories i *T* transportistes, quantes files retorna la consulta? Què passa si una de les dues taules és buida?

### 7. Nombre de comandes de cada client, incloent-hi zero

**Objectiu:** combinar `LEFT JOIN` i `GROUP BY` sense comptar comandes inexistents.

**Enunciat:** mostra l'identificador i el nom de l'empresa de tots els clients, amb el nombre de comandes de cadascun (`total_comandes`). Els clients sense comandes han d'aparèixer amb `0`. Ordena per `total_comandes` descendent i desempata per identificador de client ascendent.

**Pista:** agrupa per l'identificador i el nom de l'empresa clienta. Tria quin argument de `COUNT` permet comptar només les comandes coincidents.

**Pregunta:** quin recompte obtindria un client sense comandes si utilitzessis `COUNT(*)`? Per què un `INNER JOIN` no serviria per mostrar aquest client amb zero comandes?
