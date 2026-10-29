# Exercicis d'ORDER BY amb Northwind (PostgreSQL)

## Objectius i instruccions

Practicar l'ordenació dels resultats amb `ORDER BY`, tant en ordre ascendent (`ASC`) com descendent (`DESC`), i combinar diversos criteris d'ordenació amb els filtres de `WHERE`.

Treballa amb la mateixa base de dades **Northwind** de les pràctiques de [SELECT](./02_intro_select_exercicis.md) i [WHERE](./03_where_exercicis.md). Mantén els noms de les taules i les columnes en anglès.

- Escriu i executa una consulta per exercici, excepte quan l'enunciat en demani més d'una.
- Consulta una sola taula a cada sentència. No cal utilitzar `JOIN`, subconsultes, funcions d'agregació ni `LIMIT`.
- Mostra només les columnes demanades i respecta'n l'ordre. L'ordre de les columnes del resultat és independent de l'ordre de les files.
- Escriu explícitament `ASC` o `DESC` per a cada criteri d'ordenació.
- Respecta tots els criteris de desempat indicats als enunciats.
- Desa les consultes en un fitxer `.sql` i identifica cada exercici amb un comentari.

**Material de consulta:** [Introducció a ORDER BY](./04_order_by.md).

## Taules i columnes que utilitzarem

La taula següent recull només les columnes necessàries per a aquesta pràctica; no és l'esquema complet de Northwind.

| Taula | Columnes |
| --- | --- |
| `categories` | `category_id`, `category_name` |
| `products` | `product_id`, `product_name`, `category_id`, `unit_price`, `units_in_stock`, `reorder_level` |
| `customers` | `customer_id`, `company_name`, `city`, `country` |
| `suppliers` | `supplier_id`, `company_name`, `country` |
| `shippers` | `shipper_id`, `company_name`, `phone` |
| `employees` | `employee_id`, `first_name`, `last_name` |
| `orders` | `order_id`, `order_date`, `ship_country`, `freight` |
| `order_details` | `order_id`, `product_id`, `unit_price`, `quantity` |

## Recordatoris per a la pràctica

- Sense `ORDER BY`, l'ordre de les files no està garantit.
- `ASC` ordena els nombres de menor a major i les dates de més antiga a més recent. `DESC` aplica l'ordre invers.
- En els textos, l'ordre concret depèn de les regles d'ordenació de la base de dades, especialment pel que fa a accents i majúscules. En aquesta pràctica, «ordre alfabètic» fa referència a l'ordre ascendent del text.
- Els criteris s'apliquen d'esquerra a dreta: el segon només desempata les files que tenen el mateix valor en el primer, i així successivament.
- La direcció s'indica per a cada criteri. `ORDER BY country, company_name DESC` equival a `ORDER BY country ASC, company_name DESC`.
- Si totes les claus d'ordenació coincideixen entre diverses files, l'ordre relatiu d'aquestes files no queda determinat. Afegir un identificador únic al final permet desempatar-les.
- Quan es combinen les dues clàusules, `WHERE` s'escriu abans d'`ORDER BY`.
- En PostgreSQL pots utilitzar un àlies del `SELECT` com a criteri d'`ORDER BY`, per exemple `ORDER BY valor_estoc DESC`.

## Exemples resolts

Intenta escriure cada consulta abans d'obrir-ne la solució.

### 1. Catàleg per nom de producte

**Objectiu:** ordenar un text en ordre ascendent.

**Enunciat:** mostra l'identificador i el nom de tots els productes, ordenats alfabèticament pel nom. Si dos productes tenen el mateix nom, ordena'ls per identificador de menor a major.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT product_id, product_name
FROM products
ORDER BY product_name ASC, product_id ASC;
```

El nom és el criteri principal. L'identificador només s'utilitza per desempatar noms iguals.

</details>

### 2. Productes de més cars a més barats

**Objectiu:** ordenar un valor numèric en ordre descendent.

**Enunciat:** mostra l'identificador, el nom i el preu unitari dels productes, de més cars a més barats. En cas d'empat de preu, ordena'ls per identificador ascendent.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT product_id, product_name, unit_price
FROM products
ORDER BY unit_price DESC, product_id ASC;
```

`DESC` s'aplica al preu i `ASC` a l'identificador; cada criteri té la seva direcció.

</details>

### 3. Directori de clients per país i ciutat

**Objectiu:** aplicar diversos criteris d'ordenació.

**Enunciat:** mostra el país, la ciutat, el nom de l'empresa i l'identificador dels clients. Ordena primer pel país, després per la ciutat i després pel nom de l'empresa, tots tres alfabèticament. Utilitza l'identificador ascendent com a últim desempat.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT country, city, company_name, customer_id
FROM customers
ORDER BY country ASC, city ASC, company_name ASC, customer_id ASC;
```

La ciutat s'utilitza per ordenar els clients que tenen el mateix país. El nom de l'empresa desempata els que, a més, comparteixen ciutat.

</details>

### 4. Productes disponibles amb més existències primer

**Objectiu:** combinar `WHERE` i `ORDER BY`.

**Enunciat:** mostra l'identificador, el nom i les unitats en estoc dels productes amb més de 0 unitats en estoc. Ordena'ls de més a menys unitats i, en cas d'empat, per identificador ascendent.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT product_id, product_name, units_in_stock
FROM products
WHERE units_in_stock > 0
ORDER BY units_in_stock DESC, product_id ASC;
```

`WHERE` determina quines files es mostren i `ORDER BY` estableix l'ordre del resultat.

</details>

## Exercicis per practicar

Els exercicis següents no inclouen solució. Revisa especialment els empats: les primeres files poden semblar correctes encara que falti un criteri secundari.

### Bloc A. Ordenació de textos

**Objectiu del bloc:** practicar l'ordre ascendent i descendent de columnes de text.

#### 5. Categories per nom

Mostra l'identificador i el nom de les categories, ordenats alfabèticament pel nom. Desempata per identificador ascendent.

#### 6. Proveïdors per país

Mostra el país, el nom de l'empresa i l'identificador dels proveïdors. Ordena pel país i, dins de cada país, pel nom de l'empresa, tots dos alfabèticament. Desempata per identificador ascendent.

#### 7. Empreses de transport en ordre invers

Mostra l'identificador, el nom i el telèfon de les empreses de transport. Ordena pel nom en ordre descendent i desempata per identificador ascendent.

#### 8. Empleats per cognoms i nom

Mostra l'identificador, els cognoms i el nom dels empleats. Ordena alfabèticament pels cognoms i, en cas d'empat, pel nom. Utilitza l'identificador ascendent com a últim desempat.

### Bloc B. Nombres, dates i direccions diferents

**Objectiu del bloc:** ordenar valors numèrics i dates, i combinar direccions d'ordenació.

#### 9. Productes de més barats a més cars

Mostra l'identificador, el nom i el preu unitari dels productes, ordenats pel preu de menor a major. Desempata per identificador ascendent.

#### 10. Existències i preu

Mostra l'identificador, el nom, les unitats en estoc i el preu unitari dels productes. Ordena primer per les unitats en estoc de més a menys i, quan coincideixin, pel preu de menor a major. Desempata finalment per identificador ascendent.

#### 11. Cost del transport

Mostra l'identificador de la comanda, el país de destinació i el cost del transport (`freight`). Ordena pel cost del transport de més a menys i desempata per identificador de comanda ascendent.

#### 12. Comandes més recents primer

Mostra l'identificador i la data de les comandes amb `order_date` no nul. Ordena de la data més recent a la més antiga. Si diverses comandes tenen la mateixa data, mostra primer la que té l'identificador més gran.

#### 13. Columnes mostrades i criteris d'ordenació

Mostra primer el nom de la categoria i després l'identificador. Ordena les files per l'identificador de categoria de major a menor.

**Pregunta:** canviar l'ordre de les columnes del `SELECT` modifica per si sol l'ordre de les files?

#### 14. Canviar la prioritat dels criteris

Mostra el país, la ciutat, el nom de l'empresa i l'identificador dels clients. Escriu dues consultes amb les mateixes columnes:

1. Ordena per país, ciutat, nom de l'empresa i identificador, tots en ordre ascendent.
2. Ordena per ciutat, país, nom de l'empresa i identificador, tots en ordre ascendent.

Explica per què intercanviar els dos primers criteris pot canviar la posició de les files encara que totes les direccions continuïn sent ascendents.

#### 15. Productes per categoria i preu

Mostra l'identificador de categoria, l'identificador del producte, el nom i el preu unitari. Ordena primer per categoria ascendent i, dins de cada categoria, de més cars a més barats. Desempata per identificador de producte ascendent.

### Bloc C. Filtrar i ordenar

**Objectiu del bloc:** combinar els filtres de la pràctica anterior amb diversos criteris d'ordenació.

#### 16. Clients de tres països

Mostra el país, el nom de l'empresa i l'identificador dels clients de `'Spain'`, `'France'` o `'Portugal'`. Ordena pel país i pel nom de l'empresa, tots dos alfabèticament, i desempata per identificador ascendent.

Utilitza `IN` per al filtre.

#### 17. Productes per sota del nivell de reposició

Mostra l'identificador, el nom, les unitats en estoc i el nivell de reposició dels productes en què `units_in_stock` és estrictament inferior a `reorder_level`.

Ordena per les unitats en estoc de menor a major i desempata per identificador ascendent.

#### 18. Comandes d'un any

Mostra l'identificador, la data de comanda i el cost del transport de les comandes fetes durant el 1997. Ordena per data de més antiga a més recent. Per a una mateixa data, ordena pel cost del transport de més a menys. Desempata per identificador ascendent.

**Pista:** pots expressar el filtre de dates amb un límit inferior inclòs, `DATE '1997-01-01'`, i un límit superior exclòs, `DATE '1998-01-01'`.

#### 19. Filtrar noms amb dos patrons

Mostra l'identificador i el nom dels productes el nom dels quals comença per una `C` majúscula o conté la seqüència de lletres minúscules `'ch'`. Ordena alfabèticament pel nom i desempata per identificador ascendent.

### Bloc D. Expressions, àlies i DISTINCT

**Objectiu del bloc:** ordenar valors calculats i resultats sense duplicats.

#### 20. Valor de les existències

Mostra l'identificador i el nom del producte, i una columna `valor_estoc` calculada multiplicant el preu unitari per les unitats en estoc.

Ordena de més a menys valor de les existències i desempata per identificador ascendent. Utilitza l'àlies `valor_estoc` a l'`ORDER BY`.

#### 21. Línies de comanda per import

Utilitza `order_details`. Selecciona les línies amb una quantitat estrictament superior a 10. Mostra l'identificador de la comanda, l'identificador del producte i una columna `import_brut` amb el resultat de multiplicar el preu unitari per la quantitat.

Ordena per `import_brut` de major a menor. En cas d'empat, ordena primer per l'identificador de la comanda i després pel del producte, tots dos ascendents.

#### 22. Destinacions dels clients sense duplicats

Mostra les combinacions diferents de país i ciutat que apareixen a `customers`. Ordena pel país i després per la ciutat, tots dos alfabèticament.

**Pista:** selecciona només `country` i `city`. Si afegeixes `customer_id` a la llista del `SELECT`, `DISTINCT` considerarà també aquest identificador i no eliminarà les repeticions de país i ciutat com demana l'enunciat.

### Bloc E. Revisió i pràctica integrada

**Objectiu del bloc:** detectar errors en la posició de les clàusules i en la direcció dels criteris, i preparar una consulta completa.

#### 23. Corregir una ordenació

Es volen mostrar els clients de `'France'` o de `'Germany'`, ordenats pel país en ordre descendent i, dins de cada país, pel nom de l'empresa també en ordre descendent. L'identificador s'ha d'utilitzar com a últim desempat en ordre ascendent.

S'ha escrit aquesta consulta:

```sql
SELECT customer_id, company_name, country
FROM customers
ORDER BY country, company_name DESC, customer_id ASC
WHERE country IN ('France', 'Germany');
```

1. Corregeix la posició de `WHERE` i `ORDER BY`.
2. Corregeix la direcció d'ordenació del país.
3. Explica per què el `DESC` que segueix `company_name` no s'aplica també a `country`.

#### 24. Catàleg filtrat i ordenat per valor de les existències

Escriu una única consulta sobre `products` que seleccioni els productes que compleixen totes aquestes condicions:

- Pertanyen a la categoria 1 o a la categoria 2.
- Tenen un preu unitari entre 10 i 30, ambdós inclosos.
- Tenen més de 0 unitats en estoc.

Mostra aquestes columnes, en aquest ordre:

| Columna del resultat | Contingut |
| --- | --- |
| `codi` | Identificador del producte |
| `producte` | Nom del producte |
| `categoria` | Identificador de la categoria |
| `preu_unitari` | Preu unitari |
| `unitats_estoc` | Unitats en estoc |
| `valor_estoc` | Preu unitari multiplicat per les unitats en estoc |

Ordena primer per `categoria` ascendent i, dins de cada categoria, per `valor_estoc` descendent. Desempata per `codi` ascendent. Utilitza aquests àlies a l'`ORDER BY`.

Inclou un comentari SQL que expliqui la finalitat de la consulta.

## Comprovació del treball

Abans de donar la pràctica per acabada, revisa que:

- `WHERE` apareix abans d'`ORDER BY` quan hi ha totes dues clàusules.
- Cada criteri d'ordenació té la direcció que demana l'enunciat.
- Els criteris apareixen en l'ordre de prioritat correcte.
- Els criteris secundaris resolen els empats indicats.
- L'ordre de les columnes del `SELECT` coincideix amb el que es demana, independentment de l'ordenació de les files.
- Els àlies dels valors calculats coincideixen amb els que utilitza l'`ORDER BY`.
- El fitxer `.sql` identifica cada exercici amb un comentari.

---

[Torna a la teoria d'ORDER BY](./04_order_by.md) | [Exercicis de WHERE](./03_where_exercicis.md) | [Torna a l'índex](./readme.md)
