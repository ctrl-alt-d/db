# Exercicis de HAVING amb Northwind (PostgreSQL)

## Objectius i instruccions

Practicar el filtratge de grups amb `HAVING` i distingir-lo del filtratge de files amb `WHERE`.

Treballa amb la mateixa base de dades **Northwind** de la [pràctica de GROUP BY](./06_group_by_exercicis.md). Mantén els noms de les taules i les columnes en anglès.

- Escriu una consulta per exercici, excepte quan l'enunciat en demani més d'una.
- Consulta una sola taula a cada sentència. No cal utilitzar `JOIN` ni subconsultes.
- Mostra només les columnes demanades, en l'ordre indicat, i utilitza els àlies proposats.
- Respecta els criteris d'ordenació i de desempat. No cal arrodonir els resultats.
- Desa les consultes en un fitxer `.sql` i identifica cada exercici amb un comentari.
- Un resultat buit no implica necessàriament un error: pot ser que cap grup compleixi els llindars demanats.

**Material de consulta:** [Funcions d'agregació](./05_funcions_agregacio.md), [GROUP BY](./06_group_by.md) i [Introducció a HAVING](./07_having.md).

## Taules i columnes que utilitzarem

La taula següent recull només les columnes necessàries per a aquesta pràctica; no és l'esquema complet de Northwind.

| Taula | Columnes |
| --- | --- |
| `orders` | `order_id`, `ship_country`, `freight` |
| `products` | `product_id`, `category_id`, `unit_price`, `units_in_stock` |
| `order_details` | `order_id`, `product_id`, `unit_price`, `quantity` |
| `customers` | `customer_id`, `country`, `fax` |

## Recordatoris per a la pràctica

- `WHERE` filtra files abans de l'agrupació; `HAVING` filtra els grups un cop calculats els agregats.
- En aquestes consultes, l'ordre d'escriptura és `SELECT`, `FROM`, `WHERE`, `GROUP BY`, `HAVING` i `ORDER BY`.
- Una condició sobre un recompte, una suma o una mitjana del grup correspon a `HAVING`, no a `WHERE`.
- En PostgreSQL, els àlies definits al `SELECT` es poden utilitzar a l'`ORDER BY`, però no al `HAVING`: escriu-hi l'expressió agregada, per exemple `HAVING COUNT(*) >= 5`.
- Les regles de tractament de `NULL` també s'apliquen dins de cada grup. Per exemple, `COUNT(*) - COUNT(fax)` compta els clients amb fax nul del grup.

## Exemples resolts

Intenta escriure cada consulta abans d'obrir-ne la solució.

### 1. Destinacions amb prou comandes

**Objectiu:** filtrar grups segons un recompte.

**Enunciat:** mostra el país de destinació, el nombre de comandes (`total_comandes`) i el cost mitjà del transport (`transport_mitja`) dels països que tenen almenys 20 comandes. Ordena per `total_comandes` descendent i desempata per `ship_country` ascendent.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT ship_country,
       COUNT(*) AS total_comandes,
       AVG(freight) AS transport_mitja
FROM orders
GROUP BY ship_country
HAVING COUNT(*) >= 20
ORDER BY total_comandes DESC, ship_country ASC;
```

Primer es calcula un resum per país de destinació. Després, `HAVING` descarta els grups amb menys de 20 comandes. La mitjana només té en compte els valors no nuls de `freight`.

</details>

### 2. Categories amb productes disponibles i preu mitjà elevat

**Objectiu:** combinar `WHERE` amb diverses condicions a `HAVING`.

**Enunciat:** considera només els productes amb més de 0 unitats en estoc. Mostra la categoria, el nombre de productes seleccionats (`total_productes`) i el preu mitjà (`preu_mitja`) de les categories que, després del filtre, tenen almenys 3 productes i un preu mitjà estrictament superior a 30. Ordena per `preu_mitja` descendent i desempata per `category_id` ascendent.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT category_id,
       COUNT(*) AS total_productes,
       AVG(unit_price) AS preu_mitja
FROM products
WHERE units_in_stock > 0
GROUP BY category_id
HAVING COUNT(*) >= 3 AND AVG(unit_price) > 30
ORDER BY preu_mitja DESC, category_id ASC;
```

Tant el recompte com la mitjana es calculen només sobre els productes que han superat el `WHERE`. Posar `unit_price > 30` al `WHERE` canviaria la pregunta: eliminaria productes abans de calcular la mitjana.

</details>

## Exercicis per practicar

Els exercicis següents no inclouen solució.

### 3. Comandes amb import i quantitat elevats

**Objectiu:** filtrar amb dues sumes i combinar les condicions amb `AND`.

**Enunciat:** utilitza `order_details`. Per cada comanda, calcula la suma de les quantitats (`total_unitats`) i la suma de `unit_price * quantity` (`import_brut`), sense aplicar descomptes. Mostra `order_id`, `total_unitats` i `import_brut` només per a les comandes amb almenys 1.000 d'import brut i més de 50 unitats en total. Ordena per `import_brut` descendent i desempata per `order_id` ascendent.

**Pista:** el literal numèric corresponent a mil s'escriu `1000` en SQL.

### 4. Països amb algun client sense fax

**Objectiu:** seleccionar grups segons la presència de valors nuls.

**Enunciat:** agrupa tots els clients per país. Mostra `country`, el nombre total de clients (`total_clients`) i quants tenen el fax nul (`clients_sense_fax`). Conserva només els països amb almenys un client amb fax nul i ordena per `country` ascendent.

**Pista:** compara `COUNT(*)` i `COUNT(fax)` al `HAVING`. Una cadena buida no és un valor nul.

**Pregunta:** per què afegir `WHERE fax IS NULL` faria que `total_clients` deixés de representar tots els clients de cada país?

### 5. Corregir la posició d'un filtre agregat

**Objectiu:** separar les condicions sobre files de les condicions sobre grups.

**Enunciat:** es volen seleccionar primer els productes amb preu estrictament superior a 20 i, després, mostrar només les categories amb almenys 3 d'aquests productes. S'ha escrit aquesta consulta:

```sql
-- Consulta incorrecta.
SELECT category_id, COUNT(*) AS total_productes
FROM products
WHERE unit_price > 20 AND COUNT(*) >= 3
GROUP BY category_id;
```

1. Explica per què `COUNT(*) >= 3` no es pot escriure en aquest `WHERE`.
2. Corregeix la consulta i ordena per `total_productes` descendent, amb `category_id` ascendent com a desempat.
3. Explica per què `HAVING total_productes >= 3` tampoc seria correcte en PostgreSQL.
