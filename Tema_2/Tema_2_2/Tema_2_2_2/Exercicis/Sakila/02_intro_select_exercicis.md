# 02. SELECT amb Sakila

> **Entorn:** si encara no tens la base de dades Sakila en marxa, segueix la [guia d'instal·lació i connexió](./readme.md#entorn-de-treball).

**Objectiu:** seleccionar columnes, definir àlies, calcular expressions i eliminar duplicats.

**Teoria:** [SELECT](../../02_intro_select.md). **Dades:** [esquema de Sakila](./esquema.md).

Consulta una sola taula per sentència. No cal utilitzar `WHERE`, `GROUP BY` ni `JOIN`. L'ordre de les files no està garantit; en aquest apartat només fixem l'ordre de les columnes.

## Exemples resolts

### 1. Fitxa bàsica de les pel·lícules

**Enunciat:** mostra `film_id`, el títol com a `titol` i la durada com a `durada_minuts`, en aquest ordre.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT film_id, title AS titol, length AS durada_minuts
FROM film;
```

Els àlies canvien les capçaleres del resultat, sense modificar els noms de les columnes de la taula.

</details>

### 2. Noms complets

**Enunciat:** mostra `actor_id` i el nom complet de cada actor, separant nom i cognom amb un espai, com a `nom_complet`.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT actor_id, first_name || ' ' || last_name AS nom_complet
FROM actor;
```

En PostgreSQL, `||` concatena cadenes de text.

</details>

## Exercicis sense solució

### 3. Dades de contacte dels clients

Mostra `customer_id`, `first_name`, `last_name` i `email`, en aquest ordre. No utilitzis `SELECT *`.

### 4. Tarifa amb un increment

Mostra `title`, `rental_rate` i el resultat d'incrementar la tarifa un 10 %, amb l'àlies `tarifa_incrementada`. No cal arrodonir ni modificar les dades emmagatzemades.

### 5. Tarifes i classificacions diferents

Escriu dues consultes: una amb les classificacions `rating` diferents i una altra amb les combinacions diferents de `rating, rental_rate`. Explica per què la segona pot retornar més files.

### 6. Identificar l'origen d'un llistat

Mostra `staff_id`, `first_name`, `last_name` i una columna literal amb el text `'personal'` i l'àlies `origen`, per a cada empleat de `staff`.

[Torna a l'índex](./readme.md) · [Següent: WHERE](./03_where_exercicis.md)
