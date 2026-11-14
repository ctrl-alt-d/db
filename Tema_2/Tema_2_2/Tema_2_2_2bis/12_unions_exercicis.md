# 12. UNION, UNION ALL, INTERSECT i EXCEPT amb Sakila

**Objectiu:** combinar resultats compatibles, distingir el tractament dels duplicats i aplicar operacions sobre files completes.

**Teoria:** [Unions i altres operacions](../Tema_2_2_2/12_unions.md). **Dades:** [esquema de Sakila](./esquema.md).

Les branques han de retornar el mateix nombre de columnes, en el mateix ordre i amb tipus compatibles. `UNION`, `INTERSECT` i `EXCEPT`, sense `ALL`, eliminen duplicats. Utilitza un únic `ORDER BY` al final per ordenar el resultat complet. En PostgreSQL, `INTERSECT` té prioritat sobre `UNION` i `EXCEPT`: escriu parèntesis quan combinin operacions amb un ordre específic.

## Exemples resolts

### 1. Noms i cognoms de clients i personal

**Enunciat:** combina els parells `first_name, last_name` de `customer` i `staff`, sense repeticions, ordenats per cognom i nom ascendents.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT first_name, last_name FROM customer
UNION
SELECT first_name, last_name FROM staff
ORDER BY last_name ASC, first_name ASC;
```

La igualtat es comprova sobre les dues columnes. No s'estan identificant persones: dues persones diferents amb el mateix nom i cognom es veurien com una sola fila.

</details>

### 2. Repeticions dins de les branques

**Enunciat:** combina els `store_id` de tots els clients i de tots els empleats, conservant una fila per registre d'origen. Anomena la columna `botiga` i ordena-la ascendentment.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT store_id AS botiga FROM customer
UNION ALL
SELECT store_id FROM staff
ORDER BY botiga ASC;
```

Amb les dades originals, hi ha `599 + 2 = 601` files. Si substituïm `UNION ALL` per `UNION`, només queden els identificadors de botiga diferents.

</details>

## Exercicis sense solució

### 3. Clients atesos pels dos empleats

Utilitza `rental` i `INTERSECT` per obtenir els `customer_id` dels clients que tenen algun lloguer gestionat per `staff_id = 1` i algun altre per `staff_id = 2`. Retorna cada identificador una vegada i ordena'l ascendentment.

### 4. Pagaments al maig però no al juny

Obté amb `EXCEPT` els `customer_id` dels clients amb pagaments al maig del 2005 però sense pagaments al juny del 2005. Consulta `payment` a totes dues branques i utilitza intervals amb límit superior exclòs. Ordena per identificador ascendent. Repeteix-ho intercanviant els mesos i compara els resultats.

### 5. Directori amb procedència

Crea un directori de clients i personal amb `UNION ALL`. Mostra `first_name`, `last_name` i un literal amb l'àlies `origen`: `'client'` o `'personal'`. Ordena per cognom, nom i origen ascendents. Explica per què afegir `origen` pot canviar quines files es considerarien duplicades si utilitzessis `UNION`.

### 6. Dues còpies del mateix resultat

Combina dues vegades la consulta `SELECT rating FROM film`, primer amb `UNION` i després amb `UNION ALL`. Ordena tots dos resultats per `rating` ascendent. Prediu'n el nombre de files i comprova'l: per què la diferència no depèn només de les coincidències entre les dues branques?

### 7. Coincidències de nom i cognom

Utilitza `INTERSECT` per obtenir els parells `first_name, last_name` presents tant a `actor` com a `customer`. Ordena per cognom i nom ascendents. Explica per què una coincidència de nom i cognom no demostra que es tracti de la mateixa persona.

### 8. Operacions combinades

Obté els identificadors de clients amb pagaments al maig o al juny del 2005, però sense pagaments al juliol del mateix any. Combina `UNION` i `EXCEPT` amb parèntesis explícits, retorna cada client una vegada i ordena per identificador ascendent.

[Torna a l'índex](./readme.md)
