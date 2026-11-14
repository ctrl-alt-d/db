# Exercicis de funcions d'agregació amb Northwind (PostgreSQL)

## Objectius i instruccions

Practicar `COUNT`, `SUM`, `AVG`, `MIN` i `MAX`, i interpretar el tractament dels valors `NULL` i dels conjunts buits.

Treballa amb la mateixa base de dades **Northwind** de les [pràctiques anteriors](./readme.md). Mantén els noms de les taules i les columnes en anglès.

- Escriu i executa una consulta per exercici, excepte quan l'enunciat en demani més d'una.
- Consulta una sola taula a cada sentència. No cal utilitzar `GROUP BY`, `HAVING`, `JOIN` ni subconsultes.
- Mostra només les columnes demanades, en l'ordre indicat, i utilitza els àlies proposats.
- No cal arrodonir els resultats. Escriu els decimals amb un punt.
- Desa les consultes en un fitxer `.sql` i identifica cada exercici amb un comentari.

**Material de consulta:** [Funcions d'agregació i tractament de NULL](./05_funcions_agregacio.md).

## Taules i columnes que utilitzarem

La taula següent recull només les columnes necessàries per a aquesta pràctica; no és l'esquema complet de Northwind.

| Taula | Columnes |
| --- | --- |
| `customers` | `customer_id`, `country`, `fax` |
| `products` | `product_id`, `product_name`, `unit_price`, `units_in_stock` |
| `orders` | `order_id`, `order_date`, `freight` |
| `order_details` | `order_id`, `product_id`, `unit_price`, `quantity`, `discount` |

## Recordatoris per a la pràctica

- `COUNT(*)` compta files; `COUNT(expressió)` compta resultats no nuls; `COUNT(DISTINCT expressió)` compta valors diferents no nuls.
- `SUM`, `AVG`, `MIN` i `MAX` ignoren els valors nuls. `AVG` divideix pel nombre de valors no nuls, no pel nombre total de files.
- Sense `GROUP BY`, una consulta d'agregació retorna una fila de resum encara que el `WHERE` no seleccioni cap fila. En aquest cas, `COUNT` retorna `0` i les altres quatre funcions retornen `NULL`.
- `COALESCE` pot substituir un resultat nul, però substituir valors abans d'agregar-los pot canviar el significat del càlcul.
- En un resum global, no podem seleccionar també una columna individual sense agregar-la.

## Exemples resolts

Intenta escriure cada consulta abans d'obrir-ne la solució.

### 1. Clients, faxos informats i països diferents

**Objectiu:** comparar les tres variants de `COUNT`.

**Enunciat:** mostra el nombre total de clients (`total_clients`), quants tenen el fax no nul (`clients_amb_fax`), quants el tenen nul (`clients_sense_fax`) i el nombre de països diferents no nuls (`paisos_diferents`).

<details>
<summary>Mostra la solució</summary>

```sql
SELECT COUNT(*) AS total_clients,
       COUNT(fax) AS clients_amb_fax,
       COUNT(*) - COUNT(fax) AS clients_sense_fax,
       COUNT(DISTINCT country) AS paisos_diferents
FROM customers;
```

Un fax amb una cadena buida (`''`) es compta amb `COUNT(fax)`, perquè no és `NULL`. Diversos clients d'un mateix país només aporten un valor a `COUNT(DISTINCT country)`.

</details>

### 2. Resum del catàleg

**Objectiu:** combinar diverses funcions d'agregació en una fila de resum.

**Enunciat:** mostra el nombre de productes (`total_productes`), el preu mínim (`preu_minim`), el màxim (`preu_maxim`), el mitjà (`preu_mitja`) i la suma de les unitats en estoc (`total_unitats`).

<details>
<summary>Mostra la solució</summary>

```sql
SELECT COUNT(*) AS total_productes,
       MIN(unit_price) AS preu_minim,
       MAX(unit_price) AS preu_maxim,
       AVG(unit_price) AS preu_mitja,
       SUM(units_in_stock) AS total_unitats
FROM products;
```

Cada funció resumeix el conjunt de productes. Si falta algun preu, la seva fila es compta amb `COUNT(*)`, però el preu nul no participa en `MIN`, `MAX` ni `AVG`.

</details>

## Exercicis per practicar

Els exercicis següents no inclouen solució.

### 3. Imports totals de les línies de comanda

**Objectiu:** sumar expressions calculades per fila.

**Enunciat:** utilitza `order_details`. Mostra el nombre de línies (`total_linies`), la suma de les quantitats (`total_unitats`), l'import brut total (`import_brut`) i l'import net total després dels descomptes (`import_net`).

Per cada línia, l'import brut és `unit_price * quantity` i el net és `unit_price * quantity * (1 - discount)`. El descompte és una fracció: `0.15` representa un 15 %.

**Pregunta:** per què cal sumar els imports calculats per fila, en lloc de multiplicar la suma dels preus per la suma de les quantitats?

### 4. Transport de les comandes del 1997

**Objectiu:** filtrar les files abans de calcular els agregats.

**Enunciat:** considera només les comandes fetes durant el 1997. Mostra el nombre de comandes (`total_comandes`), quantes tenen el cost del transport informat (`transports_informats`), la suma d'aquests costos (`transport_total`) i la seva mitjana (`transport_mitja`).

**Pista:** utilitza `order_date >= DATE '1997-01-01'` i `order_date < DATE '1998-01-01'`.

**Pregunta:** si alguna comanda seleccionada té `freight` nul, quin dels dos recomptes correspon al divisor utilitzat per `AVG(freight)`?

### 5. Agregar un conjunt buit

**Objectiu:** distingir zero, absència de valors i substitució de `NULL`.

**Enunciat:** sobre `orders`, escriu una consulta amb `WHERE 1 = 0` que mostri, en aquest ordre:

1. `COUNT(*)` com a `total_comandes`.
2. `SUM(freight)` com a `transport_total`.
3. `AVG(freight)` com a `transport_mitja`.
4. `COALESCE(SUM(freight), 0)` com a `total_o_zero`.
5. `SUM(COALESCE(freight, 0))` com a `suma_amb_zeros`.

Prediu els cinc resultats abans d'executar la consulta. Explica per què les dues últimes expressions no retornen el mateix.

### 6. Corregir un resum global

**Objectiu:** detectar una columna que no pot acompanyar un agregat global.

**Enunciat:** es vol obtenir una única fila amb el preu mitjà de tots els productes. S'ha escrit aquesta consulta:

```sql
-- Consulta incorrecta.
SELECT product_name, AVG(unit_price) AS preu_mitja
FROM products;
```

1. Explica per què dona error en PostgreSQL.
2. Corregeix-la perquè respongui a l'objectiu, sense utilitzar `GROUP BY`.
3. Explica per què embolcallar `product_name` amb `UPPER` (conversió a majúscules) no resoldria l'error.
