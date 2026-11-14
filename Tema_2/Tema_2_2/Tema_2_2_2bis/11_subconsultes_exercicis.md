# 11. Subconsultes amb Sakila

**Objectiu:** utilitzar una consulta dins d'una altra amb subconsultes escalars, `IN`, `EXISTS`, subconsultes correlacionades i taules derivades.

**Teoria:** [Subconsultes](../Tema_2_2_2/11_subconsultes.md). **Dades:** [esquema de Sakila](./esquema.md).

Utilitza subconsultes en les respostes. Una subconsulta escalar ha de retornar una columna i com a màxim una fila. En una subconsulta correlacionada, qualifica les columnes per distingir la fila exterior de les files de la subconsulta.

## Exemples resolts

### 1. Durada superior a la mitjana

**Enunciat:** mostra `film_id`, `title` i `length` de les pel·lícules amb durada superior a la mitjana de totes les pel·lícules. Ordena per durada descendent i identificador ascendent.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT film_id, title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film)
ORDER BY length DESC, film_id ASC;
```

L'agregat sense agrupació retorna un únic valor que es pot utilitzar a la comparació.

</details>

### 2. Pel·lícules sense còpies

**Enunciat:** mostra `film_id` i `title` de les pel·lícules sense cap fila associada a `inventory`, ordenades per identificador ascendent.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT f.film_id, f.title
FROM film AS f
WHERE NOT EXISTS (
    SELECT 1
    FROM inventory AS i
    WHERE i.film_id = f.film_id
)
ORDER BY f.film_id ASC;
```

La subconsulta està correlacionada amb la pel·lícula exterior. `NOT EXISTS` comprova que no existeixi cap coincidència.

</details>

## Exercicis sense solució

### 3. Pel·lícules d'una categoria

Mostra `film_id` i `title` de les pel·lícules de la categoria `'Action'`. Utilitza `IN` amb una subconsulta sobre `film_category` i una altra sobre `category`, sense escriure cap `JOIN`. Ordena per identificador ascendent.

### 4. Comparació dins de la mateixa classificació

Mostra `film_id`, `title`, `rating` i `length` de les pel·lícules amb durada superior a la mitjana de la seva pròpia classificació. Utilitza una subconsulta correlacionada i ordena per classificació i identificador ascendents.

### 5. Total per client superior a la mitjana de totals

Calcula el total pagat per cada client present a `payment`. Mostra `customer_id` i `import_total` dels que superen la mitjana d'aquests totals. Utilitza una taula derivada al `FROM` per calcular els totals de referència i una subconsulta amb `AVG` al `HAVING`. Ordena per import descendent i client ascendent.

**Pista:** `AVG(amount)` calcula la mitjana per pagament; aquí necessites la mitjana dels resultats de `SUM(amount) GROUP BY customer_id`.

### 6. Recompte com a columna

Mostra tots els clients amb `customer_id`, `first_name`, `last_name` i el nombre de lloguers (`total_lloguers`). Calcula aquest nombre amb una subconsulta correlacionada al `SELECT`, sense `JOIN`. Ordena per identificador de client ascendent.

### 7. EXISTS i NOT EXISTS

Escriu dues consultes que mostrin `customer_id`, `first_name` i `last_name`, ordenats per identificador: clients amb algun lloguer sense devolució registrada i clients sense cap lloguer. Utilitza `EXISTS` i `NOT EXISTS`, respectivament. Si algun resultat és buit, explica què significa.

### 8. Comparar amb tots els valors d'un conjunt

Mostra `film_id`, `title` i `rental_rate` de les pel·lícules amb tarifa superior a totes les tarifes de les pel·lícules de classificació `'G'`. Utilitza `> ALL` i ordena per identificador ascendent. Interpreta el resultat encara que sigui buit.

### 9. Un parany de NOT IN amb NULL

```sql
SELECT language_id, name
FROM language
WHERE language_id NOT IN (
    SELECT original_language_id
    FROM film
)
ORDER BY language_id ASC;
```

Es volen obtenir els idiomes que no consten com a idioma original de cap pel·lícula. Explica per què la presència de `NULL` a la subconsulta afecta `NOT IN`. Escriu una versió amb `NOT EXISTS` i una altra amb `NOT IN` que exclogui els nuls de la subconsulta. Mantén les columnes i l'ordre de la consulta inicial.

[Torna a l'índex](./readme.md) · [Següent: operacions de conjunts en SQL](./12_unions_exercicis.md)
