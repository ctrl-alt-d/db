# Introduint la clàusula ORDER BY

La clàusula `ORDER BY` en SQL permet ordenar els resultats d'una consulta segons una o més columnes. És útil per presentar les dades de manera organitzada i facilitar la seva anàlisi.

## Sintaxi bàsica

```sql
SELECT columnes
FROM taula
ORDER BY columna [ASC|DESC];
```

- `ASC` (ascendent) és l'opció per defecte.
- `DESC` (descendent) ordena de major a menor.

## Exemple senzill

Suposem que tenim una taula `alumnes` amb les columnes `nom` i `edat`. Si volem obtenir la llista d'alumnes ordenada per edat de menor a major:

```sql
SELECT nom, edat
FROM alumnes
ORDER BY edat ASC;
```

Si volem la llista d'alumnes ordenada per edat de major a menor:

```sql
SELECT nom, edat
FROM alumnes
ORDER BY edat DESC;
```

## Ordenar per més d'una columna

Es pot ordenar per diverses columnes. Per exemple, primer per `curs` i després per `nom`:

```sql
SELECT nom, curs
FROM alumnes
ORDER BY curs ASC, nom ASC;
```

## Exemple amb WHERE i ORDER BY

```sql
SELECT nom, edat
FROM alumnes
WHERE edat > 18
ORDER BY nom;
```

Aquest exemple retorna els alumnes majors de 18 anys ordenats alfabèticament pel nom.

## Desempats i àlies

Els criteris s'apliquen d'esquerra a dreta: el segon només resol empats del primer. La direcció s'indica per a cada columna: `ORDER BY curs, nom DESC` equival a `ORDER BY curs ASC, nom DESC`.

Si totes les claus d'ordenació coincideixen, l'ordre relatiu d'aquelles files no queda determinat. Afegir un identificador únic al final permet desempatar-les. Sense `ORDER BY`, SQL no garanteix l'ordre de les files.

En PostgreSQL, podem ordenar per un àlies del `SELECT`:

```sql
SELECT product_id, unit_price * units_in_stock AS valor_estoc
FROM products
ORDER BY valor_estoc DESC NULLS LAST, product_id ASC;
```

L'ordre concret dels textos depèn de les regles d'ordenació (*collation*) de la base de dades, especialment pel que fa a accents i majúscules.

## Ordenar valors NULL

`NULLS FIRST` situa els nuls al principi i `NULLS LAST` al final. S'escriuen després d'`ASC` o `DESC` per a cada criteri. En PostgreSQL, per defecte els nuls van al final amb `ASC` i al principi amb `DESC`.

```sql
SELECT rental_id, return_date
FROM rental
ORDER BY return_date ASC NULLS FIRST, rental_id ASC;
```

## LIMIT i OFFSET

`LIMIT` estableix el nombre màxim de files retornades. `OFFSET` indica quantes files s'ometen abans de començar a retornar-les. Per obtenir la segona pàgina d'un catàleg de 20 files per pàgina:

```sql
SELECT film_id, title
FROM film
ORDER BY title ASC, film_id ASC
LIMIT 20 OFFSET 20;
```

Primer s'ordena el resultat, després s'ometen les primeres 20 files i se'n retornen com a màxim 20. La primera pàgina utilitza `OFFSET 0` o omet aquesta clàusula. L'ordenació amb un desempat únic és necessària perquè la paginació sigui previsible quan les dades no canvien.

## Resum

La clàusula `ORDER BY` permet ordenar els resultats d'una consulta SQL de manera flexible, utilitzant una o diverses columnes i especificant l'ordre ascendent o descendent.
