# 09. JOIN amb Sakila

**Objectiu:** combinar taules mitjançant claus, conservar files sense coincidència i evitar recomptes incorrectes en relacions d'una fila amb moltes files.

**Teoria:** [JOIN](../Tema_2_2_2/09_joins.md). **Dades:** [esquema de Sakila](./esquema.md).

Utilitza àlies de taula i condicions `ON` explícites. Abans de comptar, identifica què representa cada fila després de la composició: un títol, una còpia, una participació o un lloguer.

## Exemples resolts

### 1. Pel·lícules amb el nom de l'idioma

**Enunciat:** mostra `film_id`, `title` i el nom de l'idioma com a `idioma`. Ordena per identificador de pel·lícula ascendent.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT f.film_id, f.title, l.name AS idioma
FROM film AS f
INNER JOIN language AS l ON l.language_id = f.language_id
ORDER BY f.film_id ASC;
```

La condició enllaça la clau forana de `film` amb la clau primària de `language`.

</details>

### 2. Còpies de totes les pel·lícules

**Enunciat:** mostra `film_id`, `title` i el nombre de còpies (`total_copies`), incloses les pel·lícules sense cap còpia. Ordena per identificador ascendent.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT f.film_id, f.title, COUNT(i.inventory_id) AS total_copies
FROM film AS f
LEFT JOIN inventory AS i ON i.film_id = f.film_id
GROUP BY f.film_id, f.title
ORDER BY f.film_id ASC;
```

`COUNT(i.inventory_id)` dona 0 quan no hi ha coincidència. `COUNT(*)` comptaria també la fila conservada pel `LEFT JOIN` i donaria 1 en aquest cas.

</details>

## Exercicis sense solució

### 3. Repartiment de les pel·lícules

Combina `film`, `film_actor` i `actor`. Mostra `film_id`, `title`, `actor_id`, `first_name` i `last_name`. Cada fila ha de representar una participació. Ordena per pel·lícula i actor ascendents.

### 4. Ubicació dels clients

Mostra `customer_id`, `first_name`, `last_name`, l'adreça (`address`), la ciutat (`city`) i el país (`country`) de cada client. Segueix `customer → address → city → country` i ordena per `customer_id` ascendent.

### 5. Historial de lloguers

Mostra `rental_id`, `rental_date`, el títol de la pel·lícula (`title`) i el nom i cognom del client (`first_name`, `last_name`). Segueix `rental → inventory → film` i `rental → customer`. Ordena per data de lloguer descendent i identificador de lloguer ascendent.

### 6. Categories amb la seva durada mitjana

Mostra `category_id`, el nom de la categoria (`categoria`), el nombre de pel·lícules (`total_pellicules`) i la durada mitjana (`durada_mitjana`). Inclou totes les categories encara que no tinguin pel·lícules. Utilitza `LEFT JOIN` des de `category`, passant per `film_category` fins a `film`, i ordena per identificador de categoria ascendent.

### 7. RIGHT JOIN amb idiomes sense pel·lícules

Utilitza `film RIGHT JOIN language` per mostrar `language_id`, `name` i el nombre de pel·lícules de cada idioma (`total_pellicules`), també si és zero. Utilitza la relació `film.language_id` i ordena per identificador d'idioma ascendent. Escriu una versió equivalent amb `LEFT JOIN`.

### 8. FULL OUTER JOIN i files sense coincidència

Combina `film` i `inventory` amb `FULL OUTER JOIN`. Conserva només les files sense coincidència en algun costat. Mostra `film.film_id`, `film.title` i `inventory.inventory_id`, ordenats per identificador de pel·lícula i de còpia ascendents, amb els nuls al final. Per què la clau forana impedeix que apareguin còpies amb un `film_id` inexistent?

### 9. Parelles d'actors amb el mateix cognom

Fes una composició de `actor` amb si mateixa (*self join*). Mostra els identificadors com a `actor_1` i `actor_2` i el cognom compartit (`cognom`). Exclou les parelles d'un actor amb si mateix i evita obtenir tant `(A, B)` com `(B, A)`. Ordena per `cognom`, `actor_1` i `actor_2` ascendents.

[Torna a l'índex](./readme.md) · [Següent: conjunts en àlgebra relacional](./10_algebra_III_exercicis.md)
