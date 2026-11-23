# Exercicis de GROUP BY amb Northwind (PostgreSQL)

> **Entorn:** si encara no tens la base de dades Northwind en marxa, segueix la [guia d'instal·lació i connexió](./readme.md#entorn-de-treball).

## Objectius i instruccions

Practicar l'agrupació de files amb `GROUP BY`, calcular resums per grup i combinar l'agrupació amb `WHERE` i `ORDER BY`.

Treballa amb la mateixa base de dades **Northwind** de les pràctiques de [SELECT](./02_intro_select_exercicis.md), [WHERE](./03_where_exercicis.md) i [ORDER BY](./04_order_by_exercicis.md). Mantén els noms de les taules i les columnes en anglès.

- Escriu una consulta per exercici, excepte quan l'enunciat en demani més d'una.
- Consulta una sola taula a cada sentència. No cal utilitzar `JOIN`, subconsultes ni `HAVING`.
- Mostra només les columnes demanades, en l'ordre indicat, i utilitza els àlies proposats.
- Respecta els criteris d'ordenació i de desempat. No cal arrodonir els resultats.
- Desa les consultes en un fitxer `.sql` i identifica cada exercici amb un comentari.

**Material de consulta:** [Funcions d'agregació](../../05_funcions_agregacio.md) i [Introducció a GROUP BY](../../06_group_by.md).

## Taules i columnes que utilitzarem

La taula següent recull només les columnes necessàries per a aquesta pràctica; no és l'esquema complet de Northwind.

| Taula | Columnes |
| --- | --- |
| `products` | `product_id`, `product_name`, `category_id`, `unit_price`, `units_in_stock` |
| `customers` | `customer_id`, `country`, `city`, `region`, `fax` |
| `order_details` | `order_id`, `product_id`, `unit_price`, `quantity` |

## Recordatoris per a la pràctica

- Cada combinació de valors de les columnes del `GROUP BY` produeix una fila de resum.
- Com a regla general, les columnes del `SELECT` que no estan dins d'una funció d'agregació han d'aparèixer al `GROUP BY`.
- `WHERE` filtra les files abans d'agrupar-les. L'ordre d'escriptura és `SELECT`, `FROM`, `WHERE`, `GROUP BY` i `ORDER BY`.
- `GROUP BY` no garanteix l'ordre del resultat: cal escriure `ORDER BY` quan es demana una ordenació.
- Els valors `NULL` d'una columna d'agrupació formen un mateix grup. Si agrupem per diverses columnes, també es tenen en compte els valors de les altres columnes.
- `COUNT(*)` compta totes les files de cada grup; `COUNT(columna)` i `COUNT(DISTINCT columna)` ignoren els valors nuls.

## Exemples resolts

Intenta escriure cada consulta abans d'obrir-ne la solució.

### 1. Resum de preus per categoria

**Objectiu:** calcular diversos agregats sobre un mateix grup.

**Enunciat:** mostra l'identificador de categoria, el nombre de productes (`total_productes`), el preu mitjà (`preu_mitja`) i el preu màxim (`preu_maxim`). Ordena per identificador de categoria ascendent.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT category_id,
       COUNT(*) AS total_productes,
       AVG(unit_price) AS preu_mitja,
       MAX(unit_price) AS preu_maxim
FROM products
GROUP BY category_id
ORDER BY category_id ASC;
```

Cada fila resumeix els productes d'una categoria. No seleccionem `product_name` perquè un grup pot contenir diversos noms de producte.

</details>

### 2. Clients per país i ciutat

**Objectiu:** agrupar per més d'una columna.

**Enunciat:** mostra el país, la ciutat i el nombre de clients (`total_clients`) de cada combinació de país i ciutat. Ordena per país i després per ciutat, tots dos ascendents.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT country, city, COUNT(*) AS total_clients
FROM customers
GROUP BY country, city
ORDER BY country ASC, city ASC;
```

Agrupar només per `country` resumiria totes les ciutats d'un país en un sol grup. Amb dues columnes, cada combinació constitueix un grup diferent.

</details>

## Exercicis per practicar

Els exercicis següents no inclouen solució.

### 3. Existències disponibles per categoria

**Objectiu:** filtrar files abans de calcular els resums.

**Enunciat:** considera només els productes amb més de 0 unitats en estoc. Per cada categoria, mostra `category_id`, el nombre de productes seleccionats (`total_productes`) i la suma de les seves unitats en estoc (`total_unitats`). Ordena per `total_unitats` descendent i desempata per `category_id` ascendent.

**Pregunta:** si una categoria no té cap producte que superi el filtre, apareixerà al resultat?

### 4. Resum de les línies de cada comanda

**Objectiu:** agregar una expressió calculada per fila.

**Enunciat:** utilitza `order_details`. Mostra l'identificador de comanda, el nombre de línies (`total_linies`), la suma de les quantitats (`total_unitats`) i l'import brut de la comanda (`import_brut`), calculat com la suma de `unit_price * quantity`. No apliquis descomptes. Ordena per `order_id` ascendent.

**Pregunta:** per què `SUM(unit_price * quantity)` no es pot substituir, en general, per `SUM(unit_price) * SUM(quantity)`?

### 5. Regions, dades informades i valors diferents

**Objectiu:** distingir les variants de `COUNT` dins de cada grup i interpretar `NULL`.

**Enunciat:** agrupa els clients per `region`. Mostra la regió, el nombre total de clients (`total_clients`), quants tenen un fax no nul (`clients_amb_fax`) i el nombre de països diferents no nuls (`paisos_diferents`). Ordena per `region` ascendent, amb els valors nuls al final.

**Pista:** en PostgreSQL pots escriure `ORDER BY region ASC NULLS LAST`.

**Pregunta:** si diversos clients tenen `region` nul·la, formen un únic grup o un grup per client? Un fax amb una cadena buida es compta amb `COUNT(fax)`?

### 6. Corregir una columna sense agregar

**Objectiu:** detectar una columna incompatible amb l'agrupació demanada.

**Enunciat:** es vol obtenir una sola fila per categoria, amb el seu identificador i el preu mitjà dels productes. S'ha escrit aquesta consulta:

```sql
-- Consulta incorrecta.
SELECT category_id, product_name, AVG(unit_price) AS preu_mitja
FROM products
GROUP BY category_id;
```

1. Explica per què dona error en PostgreSQL.
2. Corregeix-la mantenint l'objectiu d'una sola fila per categoria i ordena per `category_id` ascendent.
3. Explica per què afegir `product_name` al `GROUP BY` canviaria el significat de l'agrupació.
