# Exercicis de WHERE amb Northwind (PostgreSQL)

## Objectius i instruccions

Practicar el filtratge de files amb `WHERE`: comparacions, intervals amb `BETWEEN`, conjunts de valors amb `IN`, patrons de text amb `LIKE`, comprovacions de valors nuls i combinació de condicions amb `AND` i `OR`.

Treballa amb la mateixa base de dades **Northwind** de la [pràctica de SELECT](./02_intro_select_exercicis.md). Mantén els noms de les taules i les columnes en anglès.

- Escriu i executa una consulta per exercici, excepte quan l'enunciat en demani més d'una.
- Consulta una sola taula a cada sentència. No cal utilitzar `JOIN`, subconsultes, funcions d'agregació ni `ORDER BY`.
- Mostra només les columnes demanades i respecta'n l'ordre.
- Escriu els literals de text entre cometes simples i els decimals amb un punt, per exemple `0.15`.
- Utilitza els valors de text indicats als enunciats, com ara `'Germany'`, sense traduir-los.
- Desa les consultes en un fitxer `.sql` i identifica cada exercici amb un comentari.
- Si una consulta no retorna cap fila, revisa'n la condició i les dades. Un resultat buit no implica necessàriament un error.

**Material de consulta:** [Introducció a WHERE](./03_where.md).

## Taules i columnes que utilitzarem

La taula següent recull només les columnes necessàries per a aquesta pràctica; no és l'esquema complet de Northwind.

| Taula | Columnes |
| --- | --- |
| `products` | `product_id`, `product_name`, `category_id`, `unit_price`, `units_in_stock`, `units_on_order`, `reorder_level` |
| `customers` | `customer_id`, `company_name`, `city`, `country`, `region`, `fax` |
| `suppliers` | `supplier_id`, `company_name`, `country` |
| `orders` | `order_id`, `order_date`, `shipped_date`, `ship_country`, `freight` |
| `order_details` | `order_id`, `product_id`, `unit_price`, `quantity`, `discount` |

## Recordatoris per a la pràctica

- `BETWEEN a AND b` inclou els dos extrems de l'interval.
- En un patró de `LIKE`, `%` representa zero o més caràcters i `_` representa exactament un caràcter. Amb `LIKE`, respecta les majúscules i les minúscules dels patrons indicats.
- `NULL` representa un valor desconegut o absent. Comprova'l amb `IS NULL` o `IS NOT NULL`, no amb `= NULL` ni amb `<> NULL`. Una cadena buida (`''`) és un valor diferent de `NULL`.
- `WHERE` conserva només les files per a les quals la condició és certa. Per exemple, `country <> 'France'` no selecciona les files en què `country` és `NULL`.
- `AND` té prioritat sobre `OR`. Fes servir parèntesis per deixar clara l'agrupació de les condicions.
- Pots comparar dues columnes de la mateixa fila, per exemple `units_in_stock < reorder_level`.

## Exemples resolts

Intenta escriure cada consulta abans d'obrir-ne la solució.

### 1. Productes amb un preu superior a un llindar

**Objectiu:** filtrar amb un operador de comparació.

**Enunciat:** mostra l'identificador, el nom i el preu unitari dels productes que tenen un preu estrictament superior a 30.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT product_id, product_name, unit_price
FROM products
WHERE unit_price > 30;
```

Un producte amb un preu de 30 no compleix la condició. Per incloure'l, caldria utilitzar `>=`.

</details>

### 2. Preus dins d'un interval

**Objectiu:** filtrar amb `BETWEEN`.

**Enunciat:** mostra el nom i el preu unitari dels productes amb un preu entre 10 i 20, ambdós inclosos.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT product_name, unit_price
FROM products
WHERE unit_price BETWEEN 10 AND 20;
```

La condició equival a `unit_price >= 10 AND unit_price <= 20`.

</details>

### 3. Empreses amb un nom que comença per una lletra

**Objectiu:** cercar un patró amb `LIKE`.

**Enunciat:** mostra l'identificador i el nom de les empreses clientes el nom de les quals comença per una `A` majúscula.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT customer_id, company_name
FROM customers
WHERE company_name LIKE 'A%';
```

El patró exigeix una `A` inicial. El símbol `%` permet que després hi hagi qualsevol seqüència de caràcters, inclosa una seqüència buida.

</details>

### 4. Comandes sense data d'enviament informada

**Objectiu:** detectar un valor nul amb `IS NULL`.

**Enunciat:** mostra l'identificador, la data de comanda i la data d'enviament de les comandes en què `shipped_date` és nul.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT order_id, order_date, shipped_date
FROM orders
WHERE shipped_date IS NULL;
```

La consulta identifica les files sense una data d'enviament registrada. El valor nul, per si sol, no explica el motiu pel qual falta aquesta dada.

</details>

## Exercicis per practicar

Els exercicis següents no inclouen solució. Comprova tant les files seleccionades com les columnes del resultat.

### Bloc A. Operadors de comparació

**Objectiu del bloc:** distingir entre igualtat, desigualtat i comparacions amb límits inclosos o exclosos.

#### 5. Clients d'un país

Mostra l'identificador, el nom de l'empresa i el país dels clients el país dels quals és exactament `'Germany'`.

#### 6. Proveïdors d'altres països

Mostra l'identificador, el nom de l'empresa i el país dels proveïdors que tenen un país informat diferent de `'France'`.

**Pregunta:** una fila amb `country` nul compliria la comparació amb `<>`?

#### 7. Productes amb un preu mínim

Mostra el nom i el preu unitari dels productes amb un preu superior o igual a 50.

#### 8. Productes amb poques existències

Mostra l'identificador, el nom i les unitats en estoc dels productes que tenen menys de 10 unitats en estoc.

#### 9. Comandes amb transport de cost limitat

Mostra l'identificador de la comanda i el cost del transport (`freight`) de les comandes amb un cost inferior o igual a 20.

#### 10. Comparar existències i nivell de reposició

Mostra el nom del producte, les unitats en estoc i el nivell de reposició dels productes en què `units_in_stock` és estrictament inferior a `reorder_level`.

### Bloc B. Intervals i conjunts de valors

**Objectiu del bloc:** seleccionar files que pertanyen a un interval o a una llista de valors.

#### 11. Quantitats dins d'un interval

Utilitza `order_details`. Mostra l'identificador de la comanda, l'identificador del producte i la quantitat de les línies amb una quantitat entre 10 i 20, ambdós inclosos. Utilitza `BETWEEN`.

#### 12. Clients de diversos països

Mostra l'identificador, el nom de l'empresa i el país dels clients de `'Spain'`, `'France'` o `'Portugal'`. Utilitza `IN`.

#### 13. Productes de determinades categories

Mostra l'identificador, el nom i l'identificador de categoria dels productes que pertanyen a les categories amb identificador 1, 3 o 5. Utilitza `IN`.

**Pregunta:** per què els identificadors numèrics de la llista no necessiten cometes simples?

### Bloc C. Patrons de text amb LIKE

**Objectiu del bloc:** utilitzar els comodins de `LIKE` per cercar prefixos, fragments i terminacions.

#### 14. Productes amb un prefix concret

Mostra l'identificador i el nom dels productes el nom dels quals comença per `'Chef'`.

#### 15. Productes que contenen un fragment

Mostra l'identificador i el nom dels productes el nom dels quals conté exactament la seqüència de lletres minúscules `'ch'` en qualsevol posició.

#### 16. Empreses amb una terminació concreta

Mostra l'identificador i el nom de les empreses proveïdores el nom de les quals acaba en `'Ltd.'`, amb el punt final inclòs.

#### 17. Identificadors de longitud concreta

Mostra l'identificador i el nom de les empreses clientes amb un `customer_id` de cinc caràcters que comença per `A`. Expressa la condició amb `LIKE` i el comodí `_`, sense utilitzar funcions de longitud.

**Pista:** després de la lletra inicial, cal representar exactament quatre caràcters més.

### Bloc D. Valors nuls

**Objectiu del bloc:** diferenciar entre l'absència d'un valor i la presència d'una dada.

#### 18. Clients sense fax informat

Mostra l'identificador, el nom de l'empresa i el fax dels clients en què `fax` és nul.

#### 19. Comandes amb data d'enviament informada

Mostra l'identificador, la data de comanda i la data d'enviament de les comandes en què `shipped_date` no és nul.

**Pista:** utilitza `IS NOT NULL`.

### Bloc E. Combinació de condicions

**Objectiu del bloc:** combinar filtres amb `AND`, `OR` i parèntesis.

#### 20. Productes amb existències i preu limitat

Mostra l'identificador, el nom, el preu unitari i les unitats en estoc dels productes que compleixen totes dues condicions:

- El preu unitari és inferior o igual a 25.
- Hi ha més de 0 unitats en estoc.

#### 21. Clients de dues ciutats

Mostra l'identificador, el nom de l'empresa, la ciutat i el país dels clients que són de `'London'` o de `'Berlin'`. Utilitza `OR`.

#### 22. Clients de dos països sense regió informada

Mostra l'identificador, el nom de l'empresa, el país i la regió dels clients que són de `'France'` o de `'Germany'` i que, en tots dos casos, tenen `region` nul.

Escriu dues versions equivalents:

1. Una amb `OR`, `AND` i parèntesis.
2. Una amb `IN` i `AND`.

#### 23. Productes amb existències baixes i sense unitats pendents

Mostra el nom del producte, les unitats en estoc, el nivell de reposició i les unitats pendents de rebre (`units_on_order`) dels productes que compleixen totes dues condicions:

- Les unitats en estoc són inferiors al nivell de reposició.
- Les unitats pendents de rebre són 0.

### Bloc F. Revisió i pràctica integrada

**Objectiu del bloc:** detectar errors de filtratge i combinar els continguts de `SELECT` i `WHERE`.

#### 24. Corregir una comparació amb NULL

La consulta següent pretén obtenir els clients sense fax informat:

```sql
SELECT customer_id, company_name, fax
FROM customers
WHERE fax = NULL;
```

Escriu una versió correcta i explica per què `= NULL` no permet comprovar si falta el valor. Escriu també una segona consulta que seleccioni els clients amb `fax` no nul.

#### 25. Revisar la prioritat dels operadors

Es volen seleccionar els clients de `'France'` o de `'Germany'` que tenen `fax` nul, independentment de quin dels dos països siguin. S'ha escrit aquesta consulta:

```sql
SELECT customer_id, company_name, country, fax
FROM customers
WHERE country = 'France'
   OR country = 'Germany' AND fax IS NULL;
```

1. Explica com agrupa PostgreSQL les condicions si no hi ha parèntesis.
2. Indica si un client de `'France'` amb fax informat passaria el filtre actual.
3. Corregeix la consulta perquè el filtre de fax s'apliqui als clients de tots dos països.

#### 26. Filtrar un valor calculat

Mostra l'identificador i el nom del producte, i una columna `valor_estoc` amb el resultat de multiplicar el preu unitari per les unitats en estoc. Selecciona només els productes en què aquest valor calculat és estrictament superior a 1000.

**Pista:** un àlies definit a la llista `SELECT` no es pot utilitzar directament al `WHERE` de la mateixa consulta. Repeteix l'expressió aritmètica a la condició.

#### 27. Comandes d'un any concret

Mostra l'identificador, la data de comanda i el país de destinació de les comandes fetes durant l'any 1997.

Expressa l'interval amb dues comparacions unides amb `AND`: des de l'1 de gener de 1997, inclòs, fins a l'1 de gener de 1998, exclòs.

**Pista:** en PostgreSQL pots escriure literals de data amb la forma `DATE '1997-01-01'`.

#### 28. Selecció de productes per a una revisió del catàleg

Escriu una única consulta sobre `products` que seleccioni els productes que compleixen totes aquestes condicions:

- Pertanyen a la categoria 1 o a la categoria 2.
- Tenen un preu unitari entre 10 i 30, ambdós inclosos.
- Tenen més de 0 unitats en estoc.
- El nom comença per una `C` majúscula o conté la seqüència de lletres minúscules `'ch'`.

Mostra aquestes columnes, en aquest ordre:

| Columna del resultat | Contingut |
| --- | --- |
| `codi` | Identificador del producte |
| `producte` | Nom del producte |
| `categoria` | Identificador de la categoria |
| `preu_unitari` | Preu unitari |
| `unitats_estoc` | Unitats en estoc |
| `valor_estoc` | Preu unitari multiplicat per les unitats en estoc |

Utilitza `IN`, `BETWEEN`, `LIKE`, `AND`, `OR` i parèntesis. Inclou un comentari SQL que expliqui la finalitat de la consulta.

## Comprovació del treball

Abans de donar la pràctica per acabada, revisa que:

- Els operadors reflecteixen si cada límit s'ha d'incloure o excloure.
- Les comparacions utilitzen columnes de la taula consultada.
- Els patrons de `LIKE` situen correctament `%` i `_`.
- Els valors nuls es comproven amb `IS NULL` o `IS NOT NULL`.
- Les condicions amb `AND` i `OR` estan agrupades segons l'enunciat.
- Els filtres amb expressions calculades no depenen dels àlies del `SELECT`.
- Les consultes només recuperen dades i el fitxer `.sql` identifica cada exercici amb un comentari.

---

[Torna a la teoria de WHERE](./03_where.md) | [Exercicis de SELECT](./02_intro_select_exercicis.md) | [Torna a l'índex](./readme.md)
