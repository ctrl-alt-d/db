# 07. HAVING amb Sakila

> **Entorn:** si encara no tens la base de dades Sakila en marxa, segueix la [guia d'instal·lació i connexió](./readme.md#entorn-de-treball).

**Objectiu:** filtrar grups a partir dels resultats de les funcions d'agregació i distingir aquest filtre del que fa `WHERE`.

**Teoria:** [HAVING](../../07_having.md). **Dades:** [esquema de Sakila](./esquema.md).

Utilitza una sola taula a cada consulta. L'ordre d'escriptura és `SELECT`, `FROM`, `WHERE`, `GROUP BY`, `HAVING`, `ORDER BY`. A `HAVING`, escriu l'expressió agregada: PostgreSQL no hi admet els àlies definits al `SELECT`.

## Exemples resolts

### 1. Clients amb un import acumulat elevat

**Enunciat:** mostra `customer_id` i l'import total pagat (`import_total`) dels clients que han pagat més de 150 u. m. Ordena per import descendent i identificador ascendent.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT customer_id, SUM(amount) AS import_total
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 150
ORDER BY import_total DESC, customer_id ASC;
```

El llindar s'aplica al total del grup, no a cada pagament individual.

</details>

### 2. Seleccionar files i després grups

**Enunciat:** considera només les pel·lícules amb tarifa inferior a 3 u. m. Mostra les classificacions que, entre aquestes pel·lícules, tenen almenys 50 títols. Retorna `rating`, el recompte (`total_pellicules`) i la durada mitjana (`durada_mitjana`), ordenats per classificació ascendent.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT rating,
       COUNT(*) AS total_pellicules,
       AVG(length) AS durada_mitjana
FROM film
WHERE rental_rate < 3
GROUP BY rating
HAVING COUNT(*) >= 50
ORDER BY rating ASC;
```

`WHERE` selecciona les pel·lícules; `HAVING` selecciona els grups formats amb aquestes files.

</details>

## Exercicis sense solució

### 3. Clients amb molts lloguers

Mostra `customer_id` i el nombre de lloguers (`total_lloguers`) dels clients que n'han fet almenys 30. Ordena per recompte descendent i client ascendent.

### 4. Categories amb un catàleg ampli

Utilitza `film_category` per obtenir `category_id` i el nombre de pel·lícules (`total_pellicules`) de les categories amb almenys 60 pel·lícules. Ordena per identificador ascendent.

### 5. Còpies suficients per botiga

Utilitza `inventory` per mostrar `store_id`, `film_id` i el nombre de còpies (`total_copies`) de les combinacions de botiga i pel·lícula amb almenys 4 còpies. Ordena per botiga i pel·lícula ascendents.

### 6. Dos filtres sobre un mateix grup

Considera només els pagaments del maig del 2005. Mostra `customer_id`, el nombre de pagaments (`total_pagaments`) i l'import total (`import_total`) dels clients amb almenys 3 pagaments en aquell mes i un total superior a 15 u. m. Ordena per import descendent i client ascendent.

### 7. Corregir un filtre agregat

```sql
-- Consulta incorrecta: cal corregir-la abans d'executar-la.
SELECT customer_id, SUM(amount) AS import_total
FROM payment
WHERE SUM(amount) > 150
GROUP BY customer_id;
```

Explica per què el filtre no pot anar a `WHERE` i corregeix la consulta. Després afegeix la condició que només es considerin pagaments individuals d'almenys 2 u. m., mantenint el llindar de 150 u. m. sobre el total dels pagaments seleccionats.

[Torna a l'índex](./readme.md) · [Següent: producte cartesià](./08_algebra_II_exercicis.md)
