# Introduint Unions i altres operacions avançades en SQL

Les operacions d'unió permeten combinar els resultats de diverses consultes SELECT en una sola taula de resultats. Són útils per agrupar dades de diferents fonts o taules amb estructura compatible.

## UNION

Combina els resultats de dues consultes, eliminant duplicats.

```sql
SELECT nom FROM alumnes
UNION
SELECT nom FROM professors;
```

## UNION ALL

Combina els resultats de dues consultes, mantenint tots els resultats (incloent duplicats).

```sql
SELECT nom FROM alumnes
UNION ALL
SELECT nom FROM professors;
```

## INTERSECT

Retorna només les files que apareixen a les dues consultes.

```sql
SELECT nom FROM alumnes
INTERSECT
SELECT nom FROM professors;
```

## EXCEPT (o MINUS)

Retorna les files de la primera consulta que no apareixen a la segona.

En PostgreSQL utilitzarem `EXCEPT`. Alguns altres gestors anomenen aquesta operació `MINUS`.

```sql
SELECT nom FROM alumnes
EXCEPT
SELECT nom FROM professors;
```

## Requisits

- Les consultes han de tenir el mateix nombre de columnes i tipus compatibles.
- L'ordre de les columnes ha de coincidir.

La comparació es fa sobre la **fila completa**, no només sobre la primera columna. Afegir un identificador o un literal amb l'origen pot fer que dues files deixin de ser duplicades. Sense `ALL`, `INTERSECT` i `EXCEPT` també eliminen duplicats. `UNION` elimina les repeticions tant dins de cada branca com entre les branques.

Per eliminar duplicats, les files amb `NULL` a les mateixes posicions i la resta de valors iguals es consideren repetides. Això no equival a fer una comparació ordinària `NULL = NULL` en un `WHERE`.

## Noms de columna, ordenació i parèntesis

Els noms de les columnes del resultat provenen de la primera branca. Pots definir-hi un àlies i utilitzar-lo en un únic `ORDER BY` al final:

```sql
SELECT country AS pais FROM customers
UNION
SELECT country FROM suppliers
ORDER BY pais ASC NULLS LAST;
```

L'ordenació s'aplica al resultat combinat. Les operacions de conjunts no garanteixen per si mateixes cap ordre.

En PostgreSQL, `INTERSECT` té prioritat sobre `UNION` i `EXCEPT`. `UNION` i `EXCEPT` s'agrupen d'esquerra a dreta quan no hi ha parèntesis. Per exemple:

- `A UNION B INTERSECT C` s'interpreta com `A UNION (B INTERSECT C)`.
- `(A UNION B) INTERSECT C` exigeix que totes les files finals també siguin a `C`.

Aquí `A`, `B` i `C` representen consultes compatibles. Utilitza parèntesis per fer explícit l'ordre que respon a l'enunciat.

## Exemple pràctic

Suposem que volem obtenir una llista de noms de persones que són alumnes o professors:

```sql
SELECT nom FROM alumnes
UNION
SELECT nom FROM professors;
```

Si volem saber quins noms són només d'alumnes:

```sql
SELECT nom FROM alumnes
EXCEPT
SELECT nom FROM professors;
```

## Exercicis

Practica amb els [exercicis d'operacions de conjunts amb Northwind](./Exercicis/Northwind/12_unions_exercicis.md), amb exemples resolts i activitats per resoldre. També tens una [pràctica amb Sakila](./Exercicis/Sakila/12_unions_exercicis.md).

## Resum

Les operacions UNION, UNION ALL, INTERSECT i EXCEPT permeten combinar i comparar resultats de diverses consultes SELECT. Són eines potents per analitzar i agrupar dades de diferents taules.
