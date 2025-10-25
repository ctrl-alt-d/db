# Tema 2.2.4. Esborrats

Els esborrats en SQL permeten eliminar una o més files d'una taula. S'utilitza la sentència `DELETE`.

## Sintaxi bàsica

```sql
DELETE FROM nom_taula
WHERE condició;
```

## Exemple senzill

Eliminar un gos amb un número de xip concret:

```sql
DELETE FROM gossos
WHERE num_xip = 12345;
```

## Esborrat massiu

Eliminar tots els gossos d'una raça concreta:

```sql
DELETE FROM gossos
WHERE raça = 2;
```

## Important

- Si no s'especifica la clàusula WHERE, s'eliminaran totes les files de la taula.
- Es recomana fer servir WHERE per evitar esborrats massius involuntaris.

## Resum

La sentència DELETE permet eliminar dades existents a les taules. Cal utilitzar WHERE per controlar quines files s'esborren.
