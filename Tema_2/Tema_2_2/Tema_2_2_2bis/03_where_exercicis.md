# 03. WHERE amb Sakila

**Objectiu:** filtrar files amb comparacions, operadors lògics, intervals, conjunts de valors, patrons i valors nuls.

**Teoria:** [WHERE](../Tema_2_2_2/03_where.md). **Dades:** [esquema de Sakila](./esquema.md).

Utilitza una sola taula a cada consulta. Recorda que `BETWEEN` inclou els dos extrems, que `AND` té prioritat sobre `OR` i que els valors nuls es comproven amb `IS NULL` o `IS NOT NULL`.

## Exemples resolts

### 1. Pel·lícules dins d'un interval

**Enunciat:** mostra `film_id`, `title` i `length` de les pel·lícules que duren entre 90 i 120 minuts, ambdós inclosos, i tenen classificació `PG` o `PG-13`.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT film_id, title, length
FROM film
WHERE length BETWEEN 90 AND 120
  AND rating IN ('PG', 'PG-13');
```

Les dues condicions s'han de complir alhora.

</details>

### 2. Lloguers sense devolució registrada

**Enunciat:** mostra `rental_id`, `customer_id` i `rental_date` dels lloguers amb data de devolució nul·la.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT rental_id, customer_id, rental_date
FROM rental
WHERE return_date IS NULL;
```

`return_date = NULL` no és una comprovació correcta de nul·litat.

</details>

## Exercicis sense solució

### 3. Clients actius

Mostra `customer_id`, `first_name` i `last_name` dels clients actius de la botiga 2. Utilitza el valor booleà `TRUE`.

### 4. Cerca per cognom

Mostra `actor_id`, `first_name` i `last_name` dels actors amb un cognom que comenci per `'S'`. Repeteix la consulta cercant els cognoms que continguin `'son'` sense distingir majúscules de minúscules. En aquesta segona consulta pots utilitzar `ILIKE`, propi de PostgreSQL.

### 5. Pagaments d'un mes

Mostra `payment_id`, `customer_id`, `amount` i `payment_date` dels pagaments del maig del 2005 amb import igual o superior a 5 u. m. Expressa el període amb un límit inferior inclòs (`2005-05-01`) i un límit superior exclòs (`2005-06-01`) per incloure totes les hores de l'últim dia.

### 6. Combinar AND i OR

Mostra `film_id`, `title`, `rating`, `length` i `rental_rate` de les pel·lícules que compleixin una d'aquestes dues alternatives: classificació `G` i durada inferior a 60 minuts, o classificació `PG` i tarifa inferior a 3 u. m. Escriu parèntesis que facin explícites les alternatives.

### 7. Absència d'idioma original

Mostra `film_id` i `title` de les pel·lícules amb `original_language_id` nul. Explica què significa un valor nul i per què no l'has de comparar amb la cadena `'NULL'`.

[Torna a l'índex](./readme.md) · [Següent: ORDER BY](./04_order_by_exercicis.md)
