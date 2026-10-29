# Exercicis de SELECT amb Northwind (PostgreSQL)

## Objectius i instruccions

Practicar la selecció de columnes, els àlies amb `AS`, les expressions aritmètiques, els literals i l'eliminació de duplicats amb `DISTINCT`.

Treballa amb la base de dades **Northwind** en PostgreSQL. Els noms de les taules i les columnes es mantenen en anglès, tal com apareixen a la base de dades.

- Escriu i executa una consulta per exercici, excepte quan l'enunciat en demani més d'una.
- Consulta una sola taula a cada sentència. En aquesta pràctica no cal utilitzar `WHERE`, `ORDER BY`, `JOIN`, subconsultes ni funcions d'agregació.
- Respecta l'ordre de les columnes que demana cada enunciat. Sense `ORDER BY`, l'ordre de les files no està garantit.
- Utilitza `AS` per als àlies i acaba cada sentència amb un punt i coma.
- Fes servir el punt com a separador decimal en SQL, per exemple `1.10`.
- No cal arrodonir els resultats dels càlculs. El nombre de decimals que mostra l'eina pot variar.
- Desa les consultes en un fitxer `.sql`, amb un comentari que indiqui el número de cada exercici.

**Material de consulta:** [Introducció a SELECT](./02_intro_select.md).

## Taules i columnes que utilitzarem

La taula següent recull només les columnes necessàries per a aquesta pràctica; no és l'esquema complet de Northwind.

| Taula | Columnes |
| --- | --- |
| `categories` | `category_id`, `category_name`, `description` |
| `products` | `product_id`, `product_name`, `supplier_id`, `category_id`, `unit_price`, `units_in_stock`, `units_on_order`, `reorder_level` |
| `customers` | `customer_id`, `company_name`, `contact_name`, `city`, `country` |
| `suppliers` | `supplier_id`, `company_name`, `city`, `country`, `phone` |
| `employees` | `employee_id`, `first_name`, `last_name`, `title` |
| `orders` | `order_id`, `customer_id`, `order_date`, `freight`, `ship_city`, `ship_country` |
| `order_details` | `order_id`, `product_id`, `unit_price`, `quantity`, `discount` |
| `shippers` | `shipper_id`, `company_name`, `phone` |

## Exemples resolts

Intenta escriure cada consulta abans d'obrir-ne la solució.

### 1. Explorar les categories

**Objectiu:** seleccionar totes les columnes d'una taula.

**Enunciat:** mostra totes les columnes i totes les files de `categories`.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT *
FROM categories;
```

L'asterisc selecciona totes les columnes, incloses les que no apareixen a la taula de referència d'aquesta pràctica.

</details>

### 2. Simular un increment de preu

**Objectiu:** seleccionar columnes, calcular una expressió i assignar-hi un àlies.

**Enunciat:** mostra el nom de cada producte, el preu unitari actual i el preu que tindria si augmentés un 10 %. Anomena les columnes del resultat `nom_producte`, `preu_actual` i `preu_incrementat`.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT
    product_name AS nom_producte,
    unit_price AS preu_actual,
    unit_price * 1.10 AS preu_incrementat
FROM products;
```

La consulta calcula un valor per a cada fila. No modifica els preus desats a la taula.

</details>

### 3. Localitats dels clients sense duplicats

**Objectiu:** aplicar `DISTINCT` a una combinació de columnes.

**Enunciat:** mostra les combinacions diferents de país i ciutat dels clients, en aquest ordre.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT DISTINCT country, city
FROM customers;
```

`DISTINCT` elimina les files repetides del resultat considerant totes dues columnes conjuntament. Un país pot aparèixer diverses vegades si té clients en ciutats diferents.

</details>

### 4. Afegir una etiqueta al resultat

**Objectiu:** incloure un literal de text en una consulta.

**Enunciat:** mostra el nom de cada empresa de transport i una columna anomenada `tipus_servei` que contingui el text `Transport` a totes les files.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT
    company_name,
    'Transport' AS tipus_servei
FROM shippers;
```

Els literals de text s'escriuen entre cometes simples. El valor es repeteix a cada fila del resultat.

</details>

## Exercicis per practicar

Els exercicis següents no inclouen solució. Executa les consultes i comprova que les columnes, els noms i els càlculs coincideixen amb l'enunciat.

### Bloc A. Seleccionar columnes

**Objectiu del bloc:** escollir les columnes necessàries i controlar-ne l'ordre al resultat.

#### 5. Noms dels productes

Mostra únicament la columna `product_name` de tots els productes. Conserva els possibles valors repetits.

#### 6. Directori de clients

Mostra l'identificador del client, el nom de l'empresa, el nom de la persona de contacte, la ciutat i el país, en aquest ordre.

#### 7. Directori d'empleats

Mostra els cognoms, el nom i el càrrec de tots els empleats, en aquest ordre.

#### 8. Contacte dels proveïdors

Mostra el nom de l'empresa, el telèfon i el país de tots els proveïdors, en aquest ordre.

#### 9. Informació bàsica de les comandes

Mostra l'identificador de la comanda, l'identificador del client, la data de la comanda i el cost del transport (`freight`), en aquest ordre.

### Bloc B. Àlies i literals

**Objectiu del bloc:** donar noms descriptius a les columnes del resultat i incorporar-hi text.

#### 10. Fitxa de producte en català

Mostra `product_id`, `product_name` i `unit_price`, en aquest ordre, amb els àlies `codi_producte`, `nom_producte` i `preu_unitari`.

#### 11. Capçaleres amb espais

Mostra el nom i la descripció de cada categoria. Les capçaleres han de ser exactament `Nom de la categoria` i `Descripció`.

**Pista:** els àlies amb espais o amb majúscules que vulguis conservar s'escriuen entre cometes dobles.

#### 12. Identificar l'origen de les dades

Mostra l'identificador i el nom de cada empresa de transport. Afegeix al final una columna anomenada `origen` amb el literal de text `Northwind`.

#### 13. Nom complet dels empleats

Mostra l'identificador de cada empleat i una columna anomenada `nom_complet` que contingui el nom, un espai i els cognoms.

**Pista:** en PostgreSQL pots concatenar textos amb `CONCAT(text1, text2, ...)`. L'espai entre el nom i els cognoms és un literal: `' '`.

### Bloc C. Expressions i càlculs

**Objectiu del bloc:** obtenir valors calculats a partir de les columnes de cada fila.

#### 14. Valor de les existències

Mostra el nom del producte, el preu unitari, les unitats en estoc (`units_in_stock`) i el resultat de multiplicar el preu per aquestes unitats. Anomena la columna calculada `valor_estoc`.

#### 15. Existències i unitats pendents de rebre

Mostra el nom del producte, les unitats en estoc i les unitats pendents de rebre (`units_on_order`). Afegeix una columna `unitats_previstes` amb la suma de les dues quantitats.

Aquest càlcul és una suma simple; no té en compte vendes futures ni reserves.

#### 16. Diferència respecte del nivell de reposició

Mostra el nom del producte, les unitats en estoc, el nivell de reposició (`reorder_level`) i una columna `diferencia_reposicio` amb el resultat de restar el nivell de reposició a les unitats en estoc.

**Per interpretar el resultat:** un valor negatiu indica que les unitats en estoc són inferiors al nivell de reposició. Mostra tots els productes, sigui quin sigui el signe del resultat.

#### 17. Import d'una línia de comanda abans del descompte

Utilitza `order_details`. Mostra l'identificador de la comanda, l'identificador del producte, el preu unitari i la quantitat. Afegeix una columna `import_brut` amb el resultat de multiplicar el preu unitari per la quantitat.

Fes servir el preu de `order_details`, que correspon a la línia de comanda, i no el preu del catàleg de `products`.

#### 18. Import d'una línia de comanda amb descompte

Utilitza `order_details`. Mostra l'identificador de la comanda i el del producte. Afegeix aquestes columnes calculades, en aquest ordre:

1. `import_brut`: preu unitari multiplicat per la quantitat.
2. `import_descompte`: import brut multiplicat per `discount`.
3. `import_net`: import brut menys l'import del descompte.

Per als càlculs d'aquest exercici, interpreta `discount` com una fracció: `0` representa un 0 % i `0.15` representa un 15 %. No cal dividir aquest valor entre 100.

**Pista:** repeteix les expressions necessàries; no pots utilitzar un àlies definit en una expressió per calcular una altra columna de la mateixa llista `SELECT`.

### Bloc D. Eliminar duplicats

**Objectiu del bloc:** distingir entre valors únics d'una columna i combinacions úniques de diverses columnes.

#### 19. Països dels clients

Escriu dues consultes:

1. Mostra el país de cada client, conservant els possibles duplicats.
2. Mostra cada país una sola vegada.

Explica breument què canvia entre els dos resultats.

#### 20. Ciutats dels proveïdors

Mostra els valors diferents de `city` de la taula `suppliers`. El resultat ha de tenir una sola columna.

#### 21. Destinacions de les comandes

Mostra les combinacions diferents de país i ciutat de destinació de les comandes, a partir de `ship_country` i `ship_city`, en aquest ordre.

**Pregunta:** per què un mateix país pot aparèixer en diverses files encara que utilitzis `DISTINCT`?

#### 22. Combinacions de categoria i proveïdor

Mostra les combinacions diferents de `category_id` i `supplier_id` que apareixen a `products`, en aquest ordre. Mostra només els identificadors; no cal obtenir els noms de les categories ni dels proveïdors.

### Bloc E. Revisió i pràctica integrada

**Objectiu del bloc:** corregir errors habituals i combinar els continguts treballats.

#### 23. Corregir una consulta

La consulta següent vol mostrar el nom i el preu unitari de tots els productes amb les capçaleres `Nom del producte` i `Preu unitari`:

```sql
SELECT
    product_name AS Nom del producte,
    price AS Preu unitari,
FROM products;
```

Escriu una versió correcta i explica els tres tipus d'error que hi has corregit: delimitació dels àlies, nom de columna i ús de les comes.

#### 24. Preparar un catàleg de productes

Escriu una única consulta sobre `products` que mostri aquestes columnes, en aquest ordre:

| Columna del resultat | Contingut |
| --- | --- |
| `codi` | Identificador del producte |
| `producte` | Nom del producte |
| `preu_base` | Preu unitari |
| `preu_rebaixat` | Preu unitari amb una rebaixa del 5 % |
| `unitats_estoc` | Unitats en estoc |
| `valor_estoc_base` | Preu unitari original multiplicat per les unitats en estoc |
| `procedencia` | Literal de text `Northwind` |

Inclou un comentari SQL d'una línia que expliqui la finalitat de la consulta. La rebaixa és una simulació i no s'ha d'actualitzar cap dada.

## Comprovació del treball

Abans de donar la pràctica per acabada, revisa que:

- Cada consulta utilitza els noms reals de les taules i les columnes de Northwind.
- Les columnes apareixen en l'ordre indicat a l'enunciat.
- Els literals de text porten cometes simples i els àlies que ho necessiten porten cometes dobles.
- Els càlculs tenen àlies descriptius i respecten els parèntesis necessaris.
- `DISTINCT` s'aplica a totes les columnes seleccionades conjuntament.
- El fitxer `.sql` identifica cada exercici amb un comentari.

---

[Torna a la teoria de SELECT](./02_intro_select.md) | [Torna a l'índex](./readme.md)
