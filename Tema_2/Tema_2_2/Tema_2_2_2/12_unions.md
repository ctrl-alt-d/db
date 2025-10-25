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

```sql
SELECT nom FROM alumnes
EXCEPT
SELECT nom FROM professors;
```

## Requisits

- Les consultes han de tenir el mateix nombre de columnes i tipus compatibles.
- L'ordre de les columnes ha de coincidir.

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

## Resum

Les operacions UNION, UNION ALL, INTERSECT i EXCEPT permeten combinar i comparar resultats de diverses consultes SELECT. Són eines potents per analitzar i agrupar dades de diferents taules.