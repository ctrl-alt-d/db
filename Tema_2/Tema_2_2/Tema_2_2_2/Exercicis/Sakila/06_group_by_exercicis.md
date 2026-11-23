# 06. GROUP BY amb Sakila

> **Entorn:** si encara no tens la base de dades Sakila en marxa, segueix la [guia d'instal·lació i connexió](./readme.md#entorn-de-treball).

**Objectiu:** obtenir una fila de resum per grup, agrupar per diverses columnes i filtrar les files abans de resumir-les.

**Teoria:** [GROUP BY](../../06_group_by.md) i [funcions d'agregació](../../05_funcions_agregacio.md). **Dades:** [esquema de Sakila](./esquema.md).

Utilitza una sola taula a cada consulta. No cal utilitzar `JOIN`, subconsultes ni `HAVING`. En aquest apartat treballem amb els identificadors dels grups; més endavant hi afegirem noms procedents d'altres taules.

## Recordatoris

- Cada combinació de valors de les columnes del `GROUP BY` defineix un grup.
- Com a regla general, una columna del `SELECT` que no estigui agregada ha d'aparèixer al `GROUP BY`.
- `WHERE` elimina files abans de formar els grups.
- `GROUP BY` no ordena el resultat: utilitza `ORDER BY` si l'enunciat ho demana.
- Els valors nuls d'una columna d'agrupació formen un mateix grup; si hi ha més columnes, també compten els seus valors.

## Exemples resolts

### 1. Clients per botiga

**Enunciat:** mostra `store_id` i el nombre de clients (`total_clients`) de cada botiga. Ordena per `store_id` ascendent.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT store_id, COUNT(*) AS total_clients
FROM customer
GROUP BY store_id
ORDER BY store_id ASC;
```

Cada fila representa una botiga amb clients registrats. La suma de `total_clients` ha de coincidir amb el recompte global de `customer`.

</details>

### 2. Còpies per botiga i pel·lícula

**Enunciat:** mostra `store_id`, `film_id` i el nombre de còpies (`total_copies`) de cada combinació. Ordena per botiga i pel·lícula ascendents.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT store_id, film_id, COUNT(*) AS total_copies
FROM inventory
GROUP BY store_id, film_id
ORDER BY store_id ASC, film_id ASC;
```

Una pel·lícula present a dues botigues forma dos grups. Una combinació sense cap fila d'inventari no apareix amb un recompte de zero.

</details>

## Exercicis sense solució

### 3. Resum per classificació

Mostra `rating`, el nombre de pel·lícules (`total_pellicules`), la durada mitjana (`durada_mitjana`) i la tarifa màxima (`tarifa_maxima`) de cada classificació. Ordena per `rating` ascendent. No cal arrodonir.

### 4. Import pagat per client

Utilitza `payment` per mostrar `customer_id`, el nombre de pagaments (`total_pagaments`) i la suma dels imports (`import_total`). Ordena per `import_total` descendent i desempata per `customer_id` ascendent.

### 5. Filtrar abans d'agrupar

Considera només els pagaments amb `amount >= 5`. Per cada `staff_id`, mostra el nombre de pagaments seleccionats (`total_pagaments`) i la suma dels imports (`import_total`). Ordena per `staff_id` ascendent. Explica si el resultat inclou els pagaments que no han superat el filtre.

### 6. Clients per botiga i estat

Mostra `store_id`, `active` i el nombre de clients (`total_clients`) de cada combinació. Ordena per botiga ascendent i, dins de cada botiga, primer els actius. Compara el nombre de files amb el d'una agrupació només per `store_id`.

### 7. Devolucions per client

Mostra `customer_id`, el nombre total de lloguers (`total_lloguers`), el nombre de devolucions registrades (`amb_devolucio`) i el nombre de lloguers sense devolució registrada (`sense_devolucio`). Ordena per client ascendent. Utilitza les variants de `COUNT`, sense filtrar prèviament els valors nuls.

### 8. Pel·lícules per categoria

Utilitza només `film_category` per mostrar `category_id` i el nombre de pel·lícules associades (`total_pellicules`). Ordena per nombre de pel·lícules descendent i identificador de categoria ascendent. Per què no pots mostrar aquí el nom de la categoria sense consultar una altra taula?

### 9. Agrupar valors nuls

Agrupa `film` per `original_language_id`. Mostra aquesta columna, `COUNT(*)` com a `total_pellicules` i `COUNT(original_language_id)` com a `amb_idioma_original`. Ordena per identificador ascendent amb els nuls al final. Explica la diferència entre els dos recomptes en el grup amb identificador nul.

### 10. Resum mensual

Agrupa els pagaments per mes amb l'expressió `date_trunc('month', payment_date)`. Mostra el mes (`mes`), el nombre de pagaments (`total_pagaments`) i la recaptació (`import_total`). Ordena per mes ascendent. `date_trunc` conserva l'any i el mes: és preferible a agrupar només pel número de mes quan hi pot haver diversos anys.

### 11. Corregir una agrupació

Es vol obtenir una sola fila per classificació amb la durada mitjana:

```sql
-- Consulta incorrecta: cal corregir-la abans d'executar-la.
SELECT rating, title, AVG(length) AS durada_mitjana
FROM film
GROUP BY rating;
```

Explica l'error i corregeix la consulta mantenint una fila per classificació, ordenada per `rating` ascendent. Per què afegir `title` al `GROUP BY` canviaria el significat del resum?

[Torna a l'índex](./readme.md) · [Següent: HAVING](./07_having_exercicis.md)
