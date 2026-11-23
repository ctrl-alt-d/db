# 05. Funcions d'agregació amb Sakila

> **Entorn:** si encara no tens la base de dades Sakila en marxa, segueix la [guia d'instal·lació i connexió](./readme.md#entorn-de-treball).

**Objectiu:** obtenir resums globals i distingir `COUNT(*)`, `COUNT(columna)` i `COUNT(DISTINCT columna)`.

**Teoria:** [Funcions d'agregació](../../05_funcions_agregacio.md). **Dades:** [esquema de Sakila](./esquema.md).

Consulta una sola taula per sentència, sense `GROUP BY` ni `JOIN`. Les funcions d'agregació, excepte `COUNT(*)`, ignoren els valors `NULL` de l'expressió. Sobre un conjunt buit, `COUNT` retorna 0; `SUM`, `AVG`, `MIN` i `MAX` retornen `NULL`.

## Exemples resolts

### 1. Resum dels pagaments

**Enunciat:** retorna una sola fila amb el nombre de pagaments (`total_pagaments`), l'import total (`import_total`) i l'import mitjà per pagament (`import_mitja`).

<details>
<summary>Mostra la solució</summary>

```sql
SELECT COUNT(*) AS total_pagaments,
       SUM(amount) AS import_total,
       AVG(amount) AS import_mitja
FROM payment;
```

La mitjana es calcula sobre els pagaments, no sobre els clients.

</details>

### 2. Lloguers i devolucions

**Enunciat:** mostra el nombre de lloguers (`total_lloguers`), quants tenen devolució registrada (`amb_devolucio`) i quants no en tenen (`sense_devolucio`).

<details>
<summary>Mostra la solució</summary>

```sql
SELECT COUNT(*) AS total_lloguers,
       COUNT(return_date) AS amb_devolucio,
       COUNT(*) - COUNT(return_date) AS sense_devolucio
FROM rental;
```

`COUNT(return_date)` només compta les dates no nul·les.

</details>

## Exercicis sense solució

### 3. Durada de les pel·lícules

Mostra el nombre de pel·lícules (`total_pellicules`), la durada mínima (`durada_minima`), la màxima (`durada_maxima`) i la mitjana (`durada_mitjana`). No cal arrodonir. Explica què passaria amb una durada nul·la.

### 4. Clients que han llogat

Utilitza només `rental` per obtenir el nombre de clients diferents que han fet algun lloguer, amb l'àlies `clients_amb_lloguers`. Explica per què `COUNT(customer_id)` no respon la mateixa pregunta.

### 5. Recaptació d'un període

Calcula el nombre de pagaments i l'import total dels pagaments del maig del 2005. Utilitza el període `[2005-05-01, 2005-06-01)` sobre `payment_date` i els àlies `total_pagaments` i `import_total`.

### 6. Un filtre sense coincidències

Obté `COUNT(*)`, `SUM(amount)` i `AVG(amount)` dels pagaments amb `amount < 0`, amb els àlies `total_pagaments`, `import_total` i `import_mitja`. Interpreta el resultat. Escriu una segona consulta que mostri 0 en lloc d'un total nul mitjançant `COALESCE(SUM(amount), 0)` i explica per què això no obliga a substituir també la mitjana.

### 7. Una columna sense agregar

La consulta següent és incorrecta en PostgreSQL:

```sql
-- Consulta incorrecta: cal corregir-la abans d'executar-la.
SELECT title, AVG(length)
FROM film;
```

Explica el problema i corregeix-la per obtenir una sola fila amb la durada mitjana de totes les pel·lícules. No utilitzis `GROUP BY`.

[Torna a l'índex](./readme.md) · [Següent: GROUP BY](./06_group_by_exercicis.md)
