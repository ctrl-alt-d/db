## Exercicis SQL

# Pràctiques

- [Crear entorn a AWS](./aws.md)
- [Crear entorn amb docker-compose](./compose.md)

## Consultes

### 02. SELECT bàsic
1. Mostra el títol i l'any de totes les pel·lícules.
2. Mostra el nom de totes les ciutats.

### 03. WHERE
1. Mostra les pel·lícules amb la classificació 'PG'.
2. Mostra els clients que viuen en la ciutat amb id 5.

### 04. ORDER BY
1. Mostra els actors ordenats pel cognom.
2. Mostra les pel·lícules ordenades per any de llançament (descendent).

### 05. Funcions d’agregació
1. Quants pagaments s’han fet en total?
2. Quina és la mitjana d’import dels pagaments?

### 06. GROUP BY
1. Mostra quants clients té cada botiga (`store_id`).
2. Mostra el nombre de pel·lícules per categoria.

### 08. HAVING
1. Mostra els empleats que han gestionat més de 100 pagaments.
2. Mostra les categories amb més de 50 pel·lícules.

### 10. JOINS
1. Mostra el títol de la pel·lícula i el nom de l’actor per a cada participació.
2. Mostra el nom del client i l’adreça completa.

### 12. UNIONS
1. Mostra el nom i cognom de tots els clients i empleats (sense repeticions).
2. Mostra totes les ciutats i països (nom de ciutat i nom de país) en una sola llista.

---

## Conceptes clau encara no coberts (i que surten al temari)

## Noves propostes d’exercicis (amb l’esquema DVD Rental)

Nota: utilitza aquestes taules: `actor, address, category, city, country, customer, film, film_actor, film_category, inventory, language, payment, payment_p2022_01..07, rental, staff, store`.

### 01. Àlgebra relacional (selecció i projecció)
1. Projecció (π): llista única de cognoms d’actors.
2. Selecció (σ): pel·lícules amb `rating = 'PG-13'`.
3. Composició σ→π: títols de pel·lícules amb `length > 120` minuts (sense duplicats).
4. Composició amb filtre múltiple: clients amb `active = 1` i `store_id = 1` mostrant només `first_name, last_name`.

### 02. SELECT bàsic (ampliació)
3. Mostra `film_id, title` dels primers 10 films.
4. Mostra els idiomes disponibles (taula `language`) sense duplicats.
5. Mostra totes les categories (`category.name`).

### 03. WHERE (ampliació)
3. Pel·lícules amb `length BETWEEN 90 AND 120` minuts.
4. Clients amb email que acaba en `@sakilacustomer.org` (patró `LIKE '%@sakilacustomer.org'`).
5. Pagaments del gener 2022 amb import `>= 10` (taula `payment_p2022_01`).
6. Registres de lloguer encara actius: files a `rental` on `return_date IS NULL`.
7. Pel·lícules amb `special_features` que continguin la paraula `Deleted` (si s’emmagatzema com a text o array; adapta el predicat segons el SGBD).

### 04. ORDER BY (ampliació)
3. Clients ordenats per `store_id` asc i `last_name` desc.
4. Pel·lícules ordenades per `rental_rate` desc i, a igualtat, per `length` asc.
5. Categories ordenades per nom alfabèticament.
6. Primeres 20 pel·lícules per `release_year` més recent (pots combinar amb LIMIT).

### 05. Funcions d’agregació (ampliació)
3. Suma total d’imports cobrats el Q1 2022 (`payment_p2022_01`..`_03`).
4. `COUNT(DISTINCT customer_id)` a `rental`.
5. Mitjana (`AVG`) de la durada (`length`) de totes les pel·lícules.
6. Import màxim i mínim pagat en un únic pagament a 2022.

### 06. GROUP BY (ampliació)
3. Total pagat per cada client (suma `amount` per `customer_id`).
4. Nombre de pel·lícules per idioma (`language_id`).
5. Nombre d’unitats d’inventari per botiga (`store_id`) i pel·lícula (`film_id`).
6. Mitjana de `rental_rate` per `rating` (classificació).
7. `COUNT(DISTINCT film_id)` per categoria (via `film_category`).

### 07. Agregació sobre grups
1. Mitjana de `length` per categoria (uneix `film` → `film_category` → `category`).
2. Total de pagaments per mes de 2022 (usa `date_trunc('month', payment_date)` si tens una vista unificada, o agrega per particions i suma).
3. Mitjana, mínim i màxim d’import per cada empleat (`staff_id`) el Q1 2022.

### 08. HAVING (ampliació)
3. Clients amb suma d’imports > 100€ el 2022.
4. Categories amb 80 o més pel·lícules.
5. Idiomes amb una mitjana de `length` superior a 110 minuts.

### 09. Producte cartesià (CROSS JOIN)
1. Quantes files retorna `language × category`?
2. Genera totes les combinacions `language.name` i `category.name` i ordena per tots dos camps.
3. Del producte anterior, filtra només categories que comencen per 'S'.

### 10. JOINS (ampliació)
3. LEFT JOIN: llista pel·lícules i, si existeix, la seva categoria principal; mostra també les pel·lícules sense categoria.
4. FULL OUTER JOIN: pel·lícules que no tenen cap unitat a `inventory` (o unitats a inventari que no tinguin pel·lícula associada, si s’escau).
5. SELF JOIN: parelles d’actors amb el mateix cognom (evita duplicats amb `a1.actor_id < a2.actor_id`).
6. JOIN de 3 taules: títol de la pel·lícula, nom del client i data de lloguer (`film` → `inventory` → `rental` → `customer`).

### 11. Operacions de conjunts (INTERSECT / EXCEPT)
1. Clients que han pagat tant al gener com al febrer 2022:
	- `SELECT customer_id FROM payment_p2022_01 INTERSECT SELECT customer_id FROM payment_p2022_02`.
2. Clients que han pagat al gener però no al febrer 2022:
	- `SELECT customer_id FROM payment_p2022_01 EXCEPT SELECT customer_id FROM payment_p2022_02`.
3. Pel·lícules que són simultàniament d’“Action” i “Comedy” (intersecció sobre `film_id` via `film_category` + `category`).

### 12. UNIONS (ampliació)
3. Construeix tots els pagaments del Q1 2022 amb `UNION ALL` entre `payment_p2022_01..03` i calcula la recaptació total.
4. Llista de noms i cognoms de clients i empleats combinats amb `UNION` i comprova la diferència amb `UNION ALL`.

### Extres molt útils

#### LIMIT i OFFSET (paginació)
1. Mostra les 10 pel·lícules més recents per `release_year`.
2. Mostra la “pàgina 2” de 20 pel·lícules ordenades per `title` (OFFSET 20 LIMIT 20).

#### LIKE / ILIKE (patrons)
1. Actors el cognom dels quals comença per “SMI”.
2. Ciutats que contenen “new” sense distingir majúscules/minúscules (en PostgreSQL, `ILIKE`).

#### IN / NOT IN, IS NULL
1. Inventari sense devolució (`return_date IS NULL`).
2. Pagaments de clients que pertanyen a les botigues {1, 2} (`customer.store_id IN (1,2)`).

#### CASE (classificació condicional)
1. Classifica les pel·lícules per durada: `< 60` = “curta”, `60-120` = “mitjana”, `> 120` = “llarga”.
2. Marca clients com “actius/inactius” segons el camp `active`.

#### Subconsultes i EXISTS
1. Clients que tenen una suma d’imports superior a la mitjana global (subconsulta escalar dins del `WHERE`).
2. Clients que no han fet cap lloguer (`NOT EXISTS` sobre `rental`).

#### CTE (WITH)
1. Crea una CTE `pagaments_2022` (unió de particions) i calcula la recaptació mensual amb `date_trunc('month', ...)`.
2. A partir de la CTE anterior, obtén el top 3 de mesos amb més recaptació.

#### (Opcional) Funcions de finestra
1. Per a cada client, troba l’últim pagament (`ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY payment_date DESC) = 1`).
2. Import acumulat de pagaments per client i data (`SUM(amount) OVER (PARTITION BY customer_id ORDER BY payment_date)`).
