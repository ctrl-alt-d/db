# 04. ORDER BY amb Sakila

> **Entorn:** si encara no tens la base de dades Sakila en marxa, segueix la [guia d'instal·lació i connexió](./readme.md#entorn-de-treball).

**Objectiu:** ordenar per una o diverses columnes, establir desempats i obtenir pàgines de resultats.

**Teoria:** [ORDER BY](../../04_order_by.md). **Dades:** [esquema de Sakila](./esquema.md).

Consulta una sola taula. Quan limitis o paginis els resultats, inclou un criteri final únic, com ara l'identificador, perquè els desempats no quedin indeterminats.

## Exemples resolts

### 1. Directori d'actors

**Enunciat:** mostra `actor_id`, `last_name` i `first_name`, ordenats per cognom, després per nom i finalment per identificador, tots ascendents.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT actor_id, last_name, first_name
FROM actor
ORDER BY last_name ASC, first_name ASC, actor_id ASC;
```

El segon i el tercer criteri només intervenen quan hi ha empat en els anteriors.

</details>

### 2. Les deu pel·lícules més llargues

**Enunciat:** mostra `film_id`, `title` i `length` de les deu pel·lícules amb més durada. Desempata per `film_id` ascendent i situa les durades nul·les al final.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT film_id, title, length
FROM film
ORDER BY length DESC NULLS LAST, film_id ASC
LIMIT 10;
```

`LIMIT` redueix el nombre de files; `ORDER BY` determina quines ocupen les primeres posicions.

</details>

## Exercicis sense solució

### 3. Catàleg per tarifa

Mostra `film_id`, `title`, `rental_rate` i `length`. Ordena per tarifa descendent, després per durada ascendent amb els nuls al final i finalment per identificador ascendent.

### 4. Clients per botiga

Mostra `customer_id`, `store_id`, `last_name` i `first_name` dels clients actius. Ordena per botiga ascendent, cognom descendent, nom ascendent i identificador ascendent.

### 5. Segona pàgina de pel·lícules

Mostra `film_id` i `title` de la segona pàgina d'un catàleg amb 20 files per pàgina, ordenat per títol i identificador ascendents. Utilitza `LIMIT` i `OFFSET` i explica quantes files omets.

### 6. Devolucions registrades i pendents

Mostra `rental_id` i `return_date` dels primers 25 lloguers ordenats per data de devolució ascendent, amb els valors nuls al principi. Desempata per `rental_id` ascendent. Compara el resultat amb el que obtens amb `NULLS LAST`.

[Torna a l'índex](./readme.md) · [Següent: funcions d'agregació](./05_funcions_agregacio_exercicis.md)
