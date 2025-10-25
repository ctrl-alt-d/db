# Conceptes d'àlgebra relacional (unions, interseccions, diferències)

## Introducció

Després d'aprendre sobre operacions unàries (selecció i projecció) i operacions que combinen taules diferents (producte cartesià i joins), ara estudiarem les **operacions de conjunts** de l'àlgebra relacional.

Aquestes operacions tracten les relacions com a conjunts matemàtics i permeten combinar, comparar i contrastar dades de taules amb la mateixa estructura.

## Requisit de compatibilitat

Per aplicar operacions de conjunts, les dues relacions han de ser **compatibles**:
- Han de tenir el **mateix nombre de columnes**
- Les columnes corresponents han de tenir **tipus de dades compatibles**
- Els noms de les columnes no cal que coincideixin (però és recomanable)

## Operacions de conjunts

### 1. Unió (∪)

La **unió** combina files de dues relacions, eliminant duplicats automàticament.

**Notació:** Relació1 ∪ Relació2

#### Exemple

**ClientsBCN:**
| id | nom   | ciutat    |
|----|-------|-----------|
| 1  | Anna  | Barcelona |
| 2  | Marc  | Barcelona |

**ClientsGIR:**
| id | nom    | ciutat |
|----|--------|--------|
| 3  | Laura  | Girona |
| 1  | Anna   | Girona |

**ClientsBCN ∪ ClientsGIR:**
| id | nom   | ciutat    |
|----|-------|-----------|
| 1  | Anna  | Barcelona |
| 2  | Marc  | Barcelona |
| 3  | Laura | Girona    |
| 1  | Anna  | Girona    |

**Equivalent SQL:**
```sql
SELECT * FROM ClientsBCN
UNION
SELECT * FROM ClientsGIR;
```

#### Característiques
- Elimina files **completament duplicades**
- Nombre de files: entre max(|R1|, |R2|) i |R1| + |R2|
- És **commutativa**: R ∪ S = S ∪ R
- És **associativa**: (R ∪ S) ∪ T = R ∪ (S ∪ T)

#### UNION ALL en SQL

Si volem mantenir duplicats:
```sql
SELECT * FROM ClientsBCN
UNION ALL
SELECT * FROM ClientsGIR;
```

### 2. Intersecció (∩)

La **intersecció** retorna només les files que estan presents en **ambdues** relacions.

**Notació:** Relació1 ∩ Relació2

#### Exemple

**ClientsOnline:**
| id | nom   | email           |
|----|-------|-----------------|
| 1  | Anna  | anna@mail.com   |
| 2  | Marc  | marc@mail.com   |
| 3  | Laura | laura@mail.com  |

**ClientsBotiga:**
| id | nom   | email           |
|----|-------|-----------------|
| 1  | Anna  | anna@mail.com   |
| 3  | Laura | laura@mail.com  |
| 4  | Pere  | pere@mail.com   |

**ClientsOnline ∩ ClientsBotiga:**
| id | nom   | email          |
|----|-------|----------------|
| 1  | Anna  | anna@mail.com  |
| 3  | Laura | laura@mail.com |

Aquests són els clients que han comprat tant online com a la botiga física.

**Equivalent SQL:**
```sql
SELECT * FROM ClientsOnline
INTERSECT
SELECT * FROM ClientsBotiga;
```

#### Característiques
- Només files que apareixen a **totes dues** taules
- Nombre de files: entre 0 i min(|R1|, |R2|)
- És **commutativa**: R ∩ S = S ∩ R
- És **associativa**: (R ∩ S) ∩ T = R ∩ (S ∩ T)

### 3. Diferència (−)

La **diferència** retorna les files que estan a la **primera** relació però **no** a la segona.

**Notació:** Relació1 − Relació2

#### Exemple

Utilitzant les mateixes taules de l'exemple anterior:

**ClientsOnline − ClientsBotiga:**
| id | nom  | email         |
|----|------|---------------|
| 2  | Marc | marc@mail.com |

Aquest és Marc, que només ha comprat online.

**ClientsBotiga − ClientsOnline:**
| id | nom  | email         |
|----|------|---------------|
| 4  | Pere | pere@mail.com |

Aquest és Pere, que només ha comprat a la botiga física.

**Equivalent SQL:**
```sql
-- Clients que només han comprat online
SELECT * FROM ClientsOnline
EXCEPT
SELECT * FROM ClientsBotiga;

-- Clients que només han comprat a la botiga
SELECT * FROM ClientsBotiga
EXCEPT
SELECT * FROM ClientsOnline;
```

#### Característiques
- **NO és commutativa**: R − S ≠ S − R
- **NO és associativa**: (R − S) − T ≠ R − (S − T)
- Nombre de files: entre 0 i |R1|

## Casos d'ús pràctics

### Exemple 1: Campanyes de màrqueting

```sql
-- Clients que han comprat aquest any però no l'any passat (nous clients)
SELECT client_id FROM Compres2024
EXCEPT
SELECT client_id FROM Compres2023;

-- Clients que hem perdut (van comprar l'any passat però no aquest)
SELECT client_id FROM Compres2023
EXCEPT
SELECT client_id FROM Compres2024;
```

### Exemple 2: Gestió d'inventari

```sql
-- Productes disponibles a Barcelona i Madrid
SELECT producte_id FROM StockBarcelona
INTERSECT
SELECT producte_id FROM StockMadrid;

-- Tots els productes en algun magatzem
SELECT producte_id FROM StockBarcelona
UNION
SELECT producte_id FROM StockMadrid
UNION
SELECT producte_id FROM StockValencia;
```

### Exemple 3: Control d'accés

```sql
-- Usuaris que tenen permisos d'admin o editor
SELECT user_id FROM Admins
UNION
SELECT user_id FROM Editors;

-- Usuaris que són admins però no editors
SELECT user_id FROM Admins
EXCEPT
SELECT user_id FROM Editors;
```

## Propietats de les operacions de conjunts

### Lleis de De Morgan
- NOT (R ∪ S) ≡ (NOT R) ∩ (NOT S)
- NOT (R ∩ S) ≡ (NOT R) ∪ (NOT S)

### Distributivitat
- R ∩ (S ∪ T) = (R ∩ S) ∪ (R ∩ T)
- R ∪ (S ∩ T) = (R ∪ S) ∩ (R ∪ T)

### Identitats
- R ∪ ∅ = R (la unió amb el conjunt buit)
- R ∩ ∅ = ∅ (la intersecció amb el conjunt buit)
- R ∪ R = R (idempotència de la unió)
- R ∩ R = R (idempotència de la intersecció)

## Combinació amb altres operacions

Les operacions de conjunts es poden combinar amb selecció i projecció:

**Exemple:**
π<sub>nom</sub>(σ<sub>ciutat='Barcelona'</sub>(ClientsActius)) ∪ π<sub>nom</sub>(σ<sub>ciutat='Barcelona'</sub>(ClientsInactius))

Això ens dona tots els noms de clients de Barcelona, siguin actius o inactius.

**Equivalent SQL:**
```sql
SELECT nom FROM ClientsActius WHERE ciutat = 'Barcelona'
UNION
SELECT nom FROM ClientsInactius WHERE ciutat = 'Barcelona';
```

## Diferència entre SQL i àlgebra relacional pura

En àlgebra relacional pura:
- **Les operacions sempre eliminen duplicats**

En SQL:
- **UNION** elimina duplicats (com l'àlgebra relacional)
- **UNION ALL** manté duplicats (extensió de SQL)
- **INTERSECT** i **EXCEPT** eliminen duplicats

## Exercicis pràctics

1. Tenim dues taules: **ProductesEuropa** i **ProductesAsia**. Escriu consultes per:
   - Tots els productes disponibles globalment
   - Productes només a Europa
   - Productes en tots dos continents

2. Explica la diferència entre:
   ```sql
   SELECT * FROM T1 UNION SELECT * FROM T2
   ```
   i
   ```sql
   SELECT * FROM T1 UNION ALL SELECT * FROM T2
   ```

3. Si |ClientsVIP| = 500 i |ClientsNormals| = 10.000, i sabem que tots els VIP també són normals, quantes files tindrà:
   - ClientsVIP ∪ ClientsNormals
   - ClientsVIP ∩ ClientsNormals
   - ClientsNormals − ClientsVIP

4. Escriu en àlgebra relacional: "Estudiants que han aprovat Matemàtiques però no Física"

## Resum

En aquesta sessió hem après:
- La **unió** (∪) combina files de dues taules eliminant duplicats
- La **intersecció** (∩) retorna files comunes a ambdues taules
- La **diferència** (−) retorna files de la primera taula que no estan a la segona
- Totes aquestes operacions requereixen **compatibilitat de taules**
- SQL proporciona **UNION**, **INTERSECT** i **EXCEPT**
- Són útils per **anàlisi comparativa** i **segmentació de dades**

---

[Anterior: Joins](./10_joins.md) | [Següent: Unions i operacions avançades](./12_unions.md) | [Torna a l'índex](./readme.md)
