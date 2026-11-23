# Esquema de Sakila per a les pràctiques

## Context

Una **pel·lícula** és un títol del catàleg (`film`). Una **còpia** és una unitat física d'aquella pel·lícula en una botiga (`inventory`). Un **lloguer** registra el préstec d'una còpia a un client (`rental`). Un **pagament** registra un import cobrat (`payment`). Una pel·lícula pot tenir moltes còpies, i una còpia pot haver-se llogat moltes vegades.

Aquest resum recull les columnes que necessitarem; no substitueix l'esquema complet. Els noms provenen de l'[esquema SQL del projecte](https://github.com/sakiladb/postgres/blob/master/1-postgres-sakila-schema.sql).

## Taules i columnes de treball

| Taula | Què representa | Columnes que utilitzarem |
| --- | --- | --- |
| `actor` | Actors del catàleg | `actor_id`, `first_name`, `last_name` |
| `film` | Pel·lícules | `film_id`, `title`, `description`, `release_year`, `language_id`, `original_language_id`, `rental_duration`, `rental_rate`, `length`, `replacement_cost`, `rating`, `special_features` |
| `language` | Idiomes | `language_id`, `name` |
| `category` | Categories | `category_id`, `name` |
| `film_actor` | Participacions d'actors en pel·lícules | `actor_id`, `film_id` |
| `film_category` | Assignacions de pel·lícules a categories | `film_id`, `category_id` |
| `store` | Botigues | `store_id`, `manager_staff_id`, `address_id` |
| `inventory` | Còpies de pel·lícules per botiga | `inventory_id`, `film_id`, `store_id` |
| `customer` | Clients | `customer_id`, `store_id`, `first_name`, `last_name`, `email`, `address_id`, `active` |
| `staff` | Personal | `staff_id`, `first_name`, `last_name`, `store_id`, `address_id`, `active` |
| `rental` | Lloguers | `rental_id`, `rental_date`, `inventory_id`, `customer_id`, `return_date`, `staff_id` |
| `payment` | Pagaments | `payment_id`, `customer_id`, `staff_id`, `rental_id`, `amount`, `payment_date` |
| `address` | Adreces | `address_id`, `address`, `address2`, `district`, `city_id`, `postal_code` |
| `city` | Ciutats | `city_id`, `city`, `country_id` |
| `country` | Països | `country_id`, `country` |

La base de dades també conté `film_text` i diverses vistes (*views*). En aquestes pràctiques utilitzarem les taules del resum.

## Relacions que cal conèixer

Cada fletxa indica una clau forana (*foreign key*): la columna de l'esquerra referencia la de la dreta.

```text
film.language_id             → language.language_id
film.original_language_id    → language.language_id
film_actor.actor_id          → actor.actor_id
film_actor.film_id           → film.film_id
film_category.film_id        → film.film_id
film_category.category_id    → category.category_id
inventory.film_id            → film.film_id
inventory.store_id           → store.store_id
rental.inventory_id          → inventory.inventory_id
rental.customer_id           → customer.customer_id
rental.staff_id              → staff.staff_id
payment.customer_id          → customer.customer_id
payment.staff_id             → staff.staff_id
payment.rental_id            → rental.rental_id
customer.store_id            → store.store_id
customer.address_id          → address.address_id
staff.store_id               → store.store_id
staff.address_id             → address.address_id
store.manager_staff_id       → staff.staff_id
store.address_id             → address.address_id
address.city_id              → city.city_id
city.country_id              → country.country_id
```

Per exemple, per conèixer la ciutat d'un client cal seguir `customer → address → city`: `customer` no té cap columna `city_id`.

## Interpretació de les dades

- `film.length` és la durada de la pel·lícula en minuts; `rental_duration` és el període de lloguer en dies.
- `rental_rate` és la tarifa de lloguer; `replacement_cost` és el cost de reposició. En els exercicis expressarem els imports en **unitats monetàries (u. m.)**.
- `rating` és la classificació de continguts: `G`, `PG`, `PG-13`, `R` o `NC-17`.
- `customer.active` i `staff.active` són booleans: utilitza `TRUE` o `FALSE`.
- `return_date IS NULL` identifica un lloguer sense devolució registrada a les dades de mostra; no implica que el lloguer continuï actiu avui.
- `original_language_id` pot ser `NULL`. Un idioma sense cap pel·lícula associada no apareix si agrupem només les files de `film`.
- `special_features` és un array de text a PostgreSQL, no una cadena de text simple.
- Aquesta distribució utilitza `payment` per als pagaments i no les particions `payment_p2022_*` d'altres materials. Les dates dels exercicis corresponen a les dades de Sakila; no s'han d'adaptar a l'any actual.

Pots explorar el període de les dades amb aquesta consulta:

```sql
SELECT MIN(payment_date) AS primer_pagament,
       MAX(payment_date) AS ultim_pagament
FROM payment;
```

Torna a l'[índex de pràctiques](./readme.md).
