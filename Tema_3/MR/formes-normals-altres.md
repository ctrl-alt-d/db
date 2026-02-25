# Formes Normals Avançades

Un cop una base de dades compleix les tres primeres formes normals (1NF, 2NF i 3NF), es pot continuar el procés de normalització per abordar problemes més subtils de dependència. Aquestes formes avançades s’apliquen en situacions específiques on la redundància o les anomalies encara poden existir.

---

## Quarta Forma Normal (4NF)

La **Quarta Forma Normal (4NF)** elimina les **dependències multivaluades**. Una dependència multivaluada ocorre quan un atribut de la taula pot tenir múltiples valors independents d’altres atributs.

### Requisits:
1. Complir la 3NF.
2. No tenir dependències multivaluades: Si un atribut pot tenir múltiples valors independents, cal descompondre la taula.

### Exemple

Taula No en 4NF:

| ID_Proveïdor | Producte     | Lloc_Distribució |
|--------------|--------------|------------------|
| 1            | Llibres      | Barcelona        |
| 1            | Llibres      | Girona           |
| 1            | Bolígrafs    | Barcelona        |
| 1            | Bolígrafs    | Girona           |

- Hi ha dues dependències multivaluades: `Producte` i `Lloc_Distribució` són independents.

Taules en 4NF:

**Taula `Proveïdor_Producte`:**

| ID_Proveïdor | Producte   |
|--------------|------------|
| 1            | Llibres    |
| 1            | Bolígrafs  |

**Taula `Proveïdor_Lloc`:**

| ID_Proveïdor | Lloc_Distribució |
|--------------|------------------|
| 1            | Barcelona        |
| 1            | Girona           |

---

## Cinquena Forma Normal (5NF)

La **Cinquena Forma Normal (5NF)** elimina les **dependències de juntura** (join dependencies). Es produeixen anomalies si tota la informació d’una taula pot ser reconstruïda unint diverses taules més petites.

### Requisits:
1. Complir la 4NF.
2. No tenir dependències de juntura.

### Exemple

Suposem una taula `Projectes` que registra quins empleats treballen en quins projectes per a quins clients:

| Empleat    | Projecte    | Client      |
|------------|-------------|-------------|
| Anna       | Projecte X  | Client A    |
| Anna       | Projecte Y  | Client A    |
| Joan       | Projecte X  | Client A    |

Aquesta estructura pot tenir redundància si l’associació entre `Empleat`, `Projecte` i `Client` es pot descompondre.

Taules en 5NF:

**Taula `Empleat_Projecte`:**

| Empleat    | Projecte    |
|------------|-------------|
| Anna       | Projecte X  |
| Anna       | Projecte Y  |
| Joan       | Projecte X  |

**Taula `Projecte_Client`:**

| Projecte    | Client      |
|-------------|-------------|
| Projecte X  | Client A    |
| Projecte Y  | Client A    |

Ara, la informació es pot reconstruir sense redundància ni anomalies.

---

## Forma Normal de Boyce-Codd (BCNF)

La **Forma Normal de Boyce-Codd (BCNF)** és una millora de la 3NF. S’aplica quan una taula compleix la 3NF, però encara hi ha dependències funcionals inadequades.

### Requisits:
1. Complir la 3NF.
2. Per a cada dependència funcional, l’esquerra ha de ser una superclau.

### Exemple

Taula No en BCNF:

| ID_Classe | Nom_Professor | Assignatura |
|-----------|---------------|-------------|
| 1         | Dr. Joan      | Matemàtiques|
| 2         | Dr. Joan      | Física      |

En aquest cas, `Nom_Professor` determina `Assignatura`, però no és una superclau. Això viola la BCNF.

Taules en BCNF:

**Taula `Professor_Assignatura`:**

| Nom_Professor | Assignatura   |
|---------------|---------------|
| Dr. Joan      | Matemàtiques  |
| Dr. Joan      | Física        |

**Taula `Classe_Professor`:**

| ID_Classe | Nom_Professor |
|-----------|---------------|
| 1         | Dr. Joan      |
| 2         | Dr. Joan      |

---

## Resum de les Formes Normals Avançades

| Forma Normal  | Requisits Addicionals                                                  |
|---------------|------------------------------------------------------------------------|
| **BCNF**      | Elimina dependències funcionals inadequades.                          |
| **4NF**       | Elimina dependències multivaluades.                                   |
| **5NF**       | Elimina dependències de juntura.                                      |

Les formes normals avançades s’utilitzen en situacions específiques per optimitzar encara més la base de dades, tot i que la majoria dels dissenys pràctics es limiten a complir la 3NF.
