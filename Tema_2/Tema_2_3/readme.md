# Tema 2.2.3. Actualitzacions

Les actualitzacions en SQL permeten modificar el valor d'una o més columnes d'una o més files d'una taula. S'utilitza la sentència `UPDATE`.

## Sintaxi bàsica

```sql
UPDATE nom_taula
SET columna1 = valor1, columna2 = valor2
WHERE condició;
```

## Exemple senzill

Modificar el nom d'un gos amb un número de xip concret:

```sql
UPDATE gossos
SET nom = 'Rocky'
WHERE num_xip = 12345;
```

## Exemple amb diverses columnes

```sql
UPDATE gossos
SET nom = 'Luna', raça = 2
WHERE num_xip = 67890;
```

## Important

- Si no s'especifica la clàusula WHERE, s'actualitzaran totes les files de la taula.
- Es recomana fer servir WHERE per evitar modificacions massives involuntàries.

## Resum

La sentència UPDATE permet modificar dades existents a les taules. Cal utilitzar WHERE per controlar quines files s'actualitzen.
