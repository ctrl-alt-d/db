# Exercicis d'operacions de conjunts amb Northwind (PostgreSQL)

> **Entorn:** si encara no tens la base de dades Northwind en marxa, segueix la [guia d'instal·lació i connexió](./readme.md#entorn-de-treball).

## Objectius i instruccions

Practicar `UNION`, `UNION ALL`, `INTERSECT` i `EXCEPT`, i distingir com tracten els duplicats i l'ordre dels operands.

Treballa amb la mateixa base de dades **Northwind** de les [pràctiques anteriors](./readme.md). Mantén els noms de les taules i les columnes en anglès.

- Escriu una consulta per exercici, excepte quan l'enunciat en demani més d'una.
- Utilitza les operacions de conjunts indicades. No cal utilitzar `JOIN` ni subconsultes al `FROM`.
- Les branques de cada operació han de retornar el mateix nombre de columnes, en el mateix ordre i amb tipus compatibles.
- Mostra només les columnes demanades. Escriu un únic `ORDER BY` al final per ordenar el resultat complet.
- Desa les consultes en un fitxer `.sql` i identifica cada exercici amb un comentari.
- Un resultat buit pot ser correcte: depèn de les dades i de l'operació.

**Material de consulta:** [Unions i altres operacions](../../12_unions.md) i [Operacions de conjunts en àlgebra relacional](../../10_algebra_III.md).

## Taules i columnes que utilitzarem

La taula següent recull només les columnes necessàries per a aquesta pràctica; no és l'esquema complet de Northwind.

| Taula | Columnes |
| --- | --- |
| `customers` | `customer_id`, `company_name`, `country`, `city` |
| `suppliers` | `supplier_id`, `company_name`, `country`, `city` |
| `orders` | `order_id`, `ship_country` |

## Recordatoris per a la pràctica

- `UNION` combina resultats i elimina duplicats; `UNION ALL` conserva totes les files, incloses les repetides.
- `INTERSECT` retorna les files presents als dos resultats. `EXCEPT` retorna les del primer resultat que no apareixen al segon. Sense `ALL`, aquestes operacions també eliminen duplicats.
- La comparació es fa sobre la fila completa: afegir-hi un identificador o una columna d'origen pot fer que dues files deixin de ser duplicades.
- Per eliminar duplicats, les files amb `NULL` en les mateixes posicions i la resta de valors iguals es consideren repetides.
- Els noms de les columnes del resultat es prenen de la primera branca. Pots definir-hi àlies per utilitzar-los a l'`ORDER BY` final.
- En PostgreSQL, `INTERSECT` té prioritat sobre `UNION` i `EXCEPT`. Utilitza parèntesis quan vulguis establir explícitament l'ordre de les operacions.

## Exemples resolts

Intenta escriure cada consulta abans d'obrir-ne la solució.

### 1. Països de clients o proveïdors, sense repeticions

**Objectiu:** combinar dues llistes amb `UNION`.

**Enunciat:** mostra els països no nuls que apareixen a `customers`, a `suppliers` o a totes dues taules. Cada país ha d'aparèixer una sola vegada. Anomena la columna `pais` i ordena-la ascendentment.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT country AS pais
FROM customers
WHERE country IS NOT NULL
UNION
SELECT country
FROM suppliers
WHERE country IS NOT NULL
ORDER BY pais ASC;
```

`UNION` elimina tant les repeticions dins d'una mateixa branca com les coincidències entre les dues. No cal afegir `DISTINCT` a cada `SELECT`.

</details>

### 2. La mateixa llista conservant les repeticions

**Objectiu:** observar la diferència entre `UNION` i `UNION ALL`.

**Enunciat:** repeteix la consulta anterior amb `UNION ALL`: cada client i cada proveïdor amb país no nul ha d'aportar una fila amb el seu país. Mantén l'àlies `pais` i l'ordre ascendent.

<details>
<summary>Mostra la solució</summary>

```sql
SELECT country AS pais
FROM customers
WHERE country IS NOT NULL
UNION ALL
SELECT country
FROM suppliers
WHERE country IS NOT NULL
ORDER BY pais ASC;
```

Si un país apareix en quatre clients i dos proveïdors, ara apareix sis vegades al resultat. Amb `UNION`, només apareixeria una vegada.

</details>

## Exercicis per practicar

Els exercicis següents no inclouen solució.

### 3. Localitats compartides per clients i proveïdors

**Objectiu:** obtenir una intersecció de files amb dues columnes.

**Enunciat:** utilitza `INTERSECT` per mostrar les combinacions de país i ciutat presents tant a `customers` com a `suppliers`. Exclou de totes dues branques les files amb país o ciutat nuls. Mostra `country` i `city`, en aquest ordre, sense duplicats, i ordena per país i després per ciutat, tots dos ascendents.

**Pregunta:** per què comparar només `city` no permet assegurar que es tracta de la mateixa localitat?

### 4. Països presents només en una de les dues llistes

**Objectiu:** interpretar el sentit d'`EXCEPT`.

**Enunciat:** escriu dues consultes, excloent els països nuls de cada branca i anomenant `pais` la columna del resultat:

1. Països amb clients però sense cap proveïdor.
2. Països amb proveïdors però sense cap client.

Utilitza `EXCEPT` i ordena cada resultat per `pais` ascendent.

**Pregunta:** per què intercanviar les dues branques pot canviar el resultat?

### 5. Directori amb identificació de l'origen

**Objectiu:** combinar files amb una columna literal que n'indiqui la procedència.

**Enunciat:** crea un directori amb `UNION ALL`. Per cada client i cada proveïdor, mostra el nom de l'empresa (`empresa`), el país (`pais`) i l'origen (`origen`). Utilitza el literal `'customer'` per als clients i `'supplier'` per als proveïdors. Conserva totes les files, incloses les que tenen país nul.

Ordena per `empresa` ascendent, després per `pais` ascendent amb els nuls al final i, finalment, per `origen` ascendent.

**Pregunta:** amb aquesta columna d'origen, `UNION` eliminaria dues files amb el mateix nom i país si una correspon a un client i l'altra a un proveïdor? Raona-ho.

### 6. Països de contacte que també són destinacions

**Objectiu:** combinar operacions i establir-ne l'ordre amb parèntesis.

**Enunciat:** mostra, sense duplicats, els països que apareixen entre els clients o els proveïdors i que, a més, apareixen com a destinació d'alguna comanda (`orders.ship_country`). Exclou els països nuls de les tres branques. Anomena la columna final `pais` i ordena-la ascendentment.

Primer combina els països de clients i proveïdors amb `UNION`, entre parèntesis. Després aplica `INTERSECT` amb els països de destinació de les comandes.

**Pregunta:** si retires els parèntesis, quin dels dos operands de l'`UNION` queda afectat primer per l'`INTERSECT`? Continuaries exigint que tots els països del resultat fossin destinacions de comandes?
