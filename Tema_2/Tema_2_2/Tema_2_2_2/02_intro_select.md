# Select senzilla

## Introducció

La sentència **SELECT** és la instrucció més important de SQL per a consultar dades. Permet recuperar informació de les taules de la base de dades.

En aquesta sessió aprendrem la forma més bàsica de SELECT, sense filtres ni ordenació, centrant-nos en la seva estructura fonamental.

## Estructura bàsica

```sql
SELECT columna1, columna2, ...
FROM nom_taula;
```

### Components
- **SELECT**: Paraula clau que indica que volem consultar dades
- **columnes**: Llista de columnes que volem recuperar (separades per comes)
- **FROM**: Paraula clau que indica d'on obtenim les dades
- **nom_taula**: Nom de la taula que volem consultar

## Seleccionar totes les columnes

Per obtenir totes les columnes d'una taula, utilitzem l'asterisc `*`:

```sql
SELECT * FROM Clients;
```

Aquest símbol és un **comodí** que representa "totes les columnes".

### Quan utilitzar SELECT *

✅ **Recomanat per:**
- Exploració inicial de dades
- Taules amb poques columnes
- Scripts de desenvolupament

❌ **NO recomanat per:**
- Aplicacions en producció
- Taules amb moltes columnes
- Quan només necessitem algunes columnes (malbarata recursos)

## Seleccionar columnes específiques

És millor pràctica especificar només les columnes que necessitem:

```sql
SELECT nom, cognom, email
FROM Clients;
```

### Avantatges
- **Rendiment**: Es transfereixen menys dades
- **Claredat**: Més fàcil entendre què volem
- **Mantenibilitat**: No afecta si s'afegeixen noves columnes a la taula

## Exemples pràctics

### Exemple 1: Consulta bàsica

```sql
-- Obtenir tots els productes
SELECT * FROM Productes;
```

**Resultat possible:**
| id | nom           | preu  | stock | categoria    |
|----|---------------|-------|-------|--------------|
| 1  | Portàtil HP   | 899.00| 15    | Informàtica  |
| 2  | Ratolí        | 12.50 | 150   | Perifèrics   |
| 3  | Teclat        | 45.00 | 80    | Perifèrics   |

### Exemple 2: Columnes seleccionades

```sql
-- Obtenir només nom i preu dels productes
SELECT nom, preu
FROM Productes;
```

**Resultat:**
| nom           | preu  |
|---------------|-------|
| Portàtil HP   | 899.00|
| Ratolí        | 12.50 |
| Teclat        | 45.00 |

### Exemple 3: Una sola columna

```sql
-- Obtenir només els noms dels clients
SELECT nom
FROM Clients;
```

**Resultat:**
| nom    |
|--------|
| Anna   |
| Marc   |
| Laura  |
| Pere   |

## Ordre de les columnes

L'ordre en què especifiquem les columnes determina l'ordre en el resultat:

```sql
-- Ordre 1
SELECT nom, email, telefon
FROM Clients;

-- Ordre 2 (diferent)
SELECT email, nom, telefon
FROM Clients;
```

Els resultats tindran les columnes en diferent ordre.

## Expressions i càlculs simples

Podem fer càlculs simples en la llista de columnes:

```sql
-- Calcular el preu amb IVA (21%)
SELECT nom, preu, preu * 1.21
FROM Productes;
```

**Resultat:**
| nom         | preu  | preu * 1.21 |
|-------------|-------|-------------|
| Portàtil HP | 899.00| 1085.79     |
| Ratolí      | 12.50 | 15.13       |

## Àlies de columnes (AS)

Podem donar noms més descriptius a les columnes del resultat amb **AS**:

```sql
SELECT nom, preu, preu * 1.21 AS preu_amb_iva
FROM Productes;
```

**Resultat:**
| nom         | preu  | preu_amb_iva |
|-------------|-------|--------------|
| Portàtil HP | 899.00| 1085.79      |
| Ratolí      | 12.50 | 15.13        |

### Sintaxi d'àlies

```sql
-- Amb AS (recomanat, més clar)
SELECT nom AS nom_producte, preu AS preu_base
FROM Productes;

-- Sense AS (també vàlid)
SELECT nom nom_producte, preu preu_base
FROM Productes;

-- Amb espais (cal cometes)
SELECT nom AS "Nom del Producte", preu AS "Preu en Euros"
FROM Productes;
```

## Literals i constants

Podem afegir valors literals a les consultes:

```sql
SELECT nom, 'Euro' AS moneda, preu
FROM Productes;
```

**Resultat:**
| nom         | moneda | preu  |
|-------------|--------|-------|
| Portàtil HP | Euro   | 899.00|
| Ratolí      | Euro   | 12.50 |

## DISTINCT - Eliminar duplicats

Per obtenir només valors únics, utilitzem **DISTINCT**:

```sql
-- Sense DISTINCT (pot haver duplicats)
SELECT ciutat
FROM Clients;
```

**Resultat:**
| ciutat    |
|-----------|
| Barcelona |
| Barcelona |
| Madrid    |
| Barcelona |

```sql
-- Amb DISTINCT (valors únics)
SELECT DISTINCT ciutat
FROM Clients;
```

**Resultat:**
| ciutat    |
|-----------|
| Barcelona |
| Madrid    |

### DISTINCT amb múltiples columnes

```sql
SELECT DISTINCT ciutat, codi_postal
FROM Clients;
```

Això retorna combinacions úniques de ciutat i codi postal.

## Comentaris en SQL

És important documentar les nostres consultes:

```sql
-- Això és un comentari d'una línia

/*
Això és un comentari
de múltiples línies
*/

SELECT nom, preu  -- Comentari al final d'una línia
FROM Productes;
```

## Bones pràctiques

1. **Especifica les columnes**: Evita `SELECT *` en producció
2. **Utilitza àlies descriptius**: Millora la llegibilitat
3. **Formata el codi**: Usa salts de línia i indentació
4. **Comenta el codi**: Explica consultes complexes
5. **Majúscules per paraules clau**: Millora la llegibilitat (SELECT, FROM, etc.)

### Exemple de bon format:

```sql
-- Obtenir informació bàsica de productes amb preu calculat
SELECT 
    nom AS nom_producte,
    preu AS preu_base,
    preu * 1.21 AS preu_amb_iva,
    stock AS unitats_disponibles
FROM Productes;
```

## Relació amb àlgebra relacional

La sentència SELECT bàsica correspon a l'operació de **projecció** (π) de l'àlgebra relacional:

```sql
SELECT nom, preu FROM Productes;
```

És equivalent a:

π<sub>nom, preu</sub>(Productes)

Quan fem `SELECT *`, estem projectant tots els atributs:

π<sub>*</sub>(Productes)

## Exercicis pràctics

Assumeix que tens les següents taules:

**Taula Empleats:**
| id | nom      | cognom   | departament | salari |
|----|----------|----------|-------------|--------|
| 1  | Anna     | Garcia   | Vendes      | 30000  |
| 2  | Marc     | Lopez    | IT          | 45000  |
| 3  | Laura    | Martí    | IT          | 42000  |
| 4  | Pere     | Vila     | Vendes      | 32000  |

**Exercicis:**

1. Escriu una consulta per obtenir totes les columnes de tots els empleats

2. Escriu una consulta per obtenir només el nom i cognom dels empleats

3. Escriu una consulta per obtenir el nom, cognom i salari mensual (salari/12) dels empleats, amb un àlies adequat

4. Escriu una consulta per obtenir tots els departaments diferents

5. Escriu una consulta que mostri el nom complet (nom + cognom) amb l'àlies "nom_complet"

### Solucions

<details>
<summary>Fes clic per veure les solucions</summary>

```sql
-- 1. Totes les columnes
SELECT * FROM Empleats;

-- 2. Nom i cognom
SELECT nom, cognom FROM Empleats;

-- 3. Salari mensual
SELECT 
    nom, 
    cognom, 
    salari / 12 AS salari_mensual
FROM Empleats;

-- 4. Departaments únics
SELECT DISTINCT departament FROM Empleats;

-- 5. Nom complet (concatenació pot variar segons el SGBD)
-- PostgreSQL/MySQL:
SELECT CONCAT(nom, ' ', cognom) AS nom_complet FROM Empleats;
-- SQL Server:
SELECT nom + ' ' + cognom AS nom_complet FROM Empleats;
```

</details>

## Errors comuns

### ❌ Error 1: Oblidar FROM
```sql
SELECT nom, preu;  -- ERROR: falta FROM
```

### ❌ Error 2: Coma al final
```sql
SELECT nom, preu, FROM Productes;  -- ERROR: coma extra
```

### ❌ Error 3: Nom de columna incorrecte
```sql
SELECT nombre FROM Productes;  -- ERROR: si la columna es diu 'nom'
```

### ❌ Error 4: Àlies amb espais sense cometes
```sql
SELECT nom AS Nom Producte FROM Productes;  -- ERROR
-- Correcte:
SELECT nom AS "Nom Producte" FROM Productes;
```

## Resum

En aquesta sessió hem après:
- La **sintaxi bàsica** de SELECT
- Com seleccionar **totes les columnes** amb `*`
- Com seleccionar **columnes específiques**
- Utilitzar **àlies** amb AS
- Eliminar **duplicats** amb DISTINCT
- Fer **càlculs simples** en columnes
- **Bones pràctiques** de formatació

La sentència SELECT és la base de totes les consultes SQL. En les properes sessions afegirem més funcionalitats com filtres (WHERE), ordenació (ORDER BY) i agregacions.

---

[Anterior: Àlgebra relacional](./01_algebra.md) | [Següent: Where](./03_where.md) | [Torna a l'índex](./readme.md)
