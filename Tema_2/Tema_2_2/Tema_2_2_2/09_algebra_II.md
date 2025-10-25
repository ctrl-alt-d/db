# Conceptes d'àlgebra relacional (producte cartesià)

## Introducció

Després d'aprendre sobre operacions unàries (selecció i projecció) i haver practicat amb consultes bàsiques SQL, ara estudiarem les operacions **binàries** de l'àlgebra relacional, que combinen dues relacions.

En aquesta sessió ens centrarem en el **producte cartesià**, que és l'operació més bàsica per combinar dues taules i que serveix de base per entendre els JOIN.

## Producte cartesià (×)

El **producte cartesià** combina cada fila d'una relació amb cada fila d'una altra relació. És una operació **binària**.

**Notació:** Relació1 × Relació2

### Exemple conceptual

Si tenim:
- **Clients** amb 3 files
- **Productes** amb 5 files

El producte cartesià **Clients × Productes** generarà 3 × 5 = **15 files**.

### Exemple amb dades

**Taula Clients:**
| id | nom    | ciutat    |
|----|--------|-----------|
| 1  | Anna   | Barcelona |
| 2  | Bernat | Girona    |

**Taula Productes:**
| id | nom      | preu |
|----|----------|------|
| 10 | Portàtil | 800  |
| 20 | Ratolí   | 15   |

**Clients × Productes:**
| Clients.id | Clients.nom | Clients.ciutat | Productes.id | Productes.nom | Productes.preu |
|------------|-------------|----------------|--------------|---------------|----------------|
| 1          | Anna        | Barcelona      | 10           | Portàtil      | 800            |
| 1          | Anna        | Barcelona      | 20           | Ratolí        | 15             |
| 2          | Bernat      | Girona         | 10           | Portàtil      | 800            |
| 2          | Bernat      | Girona         | 20           | Ratolí        | 15             |

### Equivalent SQL

```sql
-- Sintaxi tradicional
SELECT * FROM Clients, Productes;

-- Sintaxi moderna (més explícita)
SELECT * FROM Clients CROSS JOIN Productes;
```

### Característiques

- **Nombre de files resultants:** |R1| × |R2| (producte del nombre de files)
- **Nombre de columnes resultants:** suma de columnes de les dues taules
- **No hi ha condició de join:** totes les combinacions possibles
- **Pot generar taules molt grans:** cal anar amb compte amb taules grans

### Quan s'utilitza?

El producte cartesià pur s'utilitza rarament en la pràctica perquè:
- Genera moltes files (sovint massa)
- La majoria de combinacions no tenen sentit

Però és útil per:
1. **Comprendre la base teòrica** dels JOIN
2. **Generar combinacions** en casos específics
3. **Calendaris o planificacions** (tots els dies × totes les franges horàries)

## Producte cartesià amb selecció

El producte cartesià es fa útil quan el combinem amb una selecció per filtrar només les files rellevants:

**Expressió d'àlgebra relacional:**
σ<sub>Clients.id = Comandes.client_id</sub>(Clients × Comandes)

**Equivalent SQL:**
```sql
SELECT *
FROM Clients, Comandes
WHERE Clients.id = Comandes.client_id;
```

Això és essencialment un **JOIN**, que veurem en detall en la propera sessió.

## Exemple pràctic

### Cas d'ús: Llistat de disponibilitat

Imaginem que volem crear un calendari amb totes les possibles cites entre doctors i pacients:

**Doctors:**
| id | nom        |
|----|------------|
| 1  | Dr. Martí  |
| 2  | Dra. Silva |

**Pacients:**
| id | nom   |
|----|-------|
| 10 | Joan  |
| 20 | Maria |

**Doctors × Pacients:**
| doctor_id | doctor_nom | pacient_id | pacient_nom |
|-----------|------------|------------|-------------|
| 1         | Dr. Martí  | 10         | Joan        |
| 1         | Dr. Martí  | 20         | Maria       |
| 2         | Dra. Silva | 10         | Joan        |
| 2         | Dra. Silva | 20         | Maria       |

Després podríem afegir dates i hores per crear un calendari complet de disponibilitat.

## Propietats del producte cartesià

### Commutativitat
R × S ≠ S × R (tècnicament)

Nota: El resultat conté les mateixes dades però l'ordre de les columnes és diferent.

### Associativitat
(R × S) × T = R × (S × T)

Podem fer productes cartesians de múltiples taules en qualsevol ordre.

### Relació amb altres operacions

**Producte cartesià + Selecció = Join**
σ<sub>condició</sub>(R × S) ≡ R ⋈<sub>condició</sub> S

## Problemes de rendiment

⚠️ **ADVERTÈNCIA:** El producte cartesià pot ser molt costós:

- Clients amb 1.000 files × Productes amb 10.000 files = **10.000.000 de files!**
- Això pot bloquejar la base de dades
- Sempre hauríem d'utilitzar JOINs amb condicions en lloc de productes cartesians purs

## Exercicis pràctics

1. Si tenim una taula **Colors** amb 5 files i una taula **Mides** amb 4 files, quantes files tindrà Colors × Mides?

2. Escriu en àlgebra relacional: "Troba totes les combinacions de productes i proveïdors"

3. Escriu l'equivalent SQL del següent:
   π<sub>Clients.nom, Productes.nom</sub>(Clients × Productes)

4. Per què el següent és millor que un producte cartesià pur?
   ```sql
   SELECT * FROM Clients, Comandes
   WHERE Clients.id = Comandes.client_id;
   ```

## Resum

En aquesta sessió hem après:
- El **producte cartesià** combina totes les files de dues taules
- Genera |R1| × |R2| files
- Rarament s'utilitza sol en la pràctica
- És la base teòrica dels **JOIN**, que estudiarem a continuació
- Cal vigilar amb el rendiment

---

[Anterior: Having](./08_having.md) | [Següent: Joins](./10_joins.md) | [Torna a l'índex](./readme.md)
