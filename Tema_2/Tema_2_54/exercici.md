# Exercici pràctic — Base de dades d'un hospital

**Durada**: 2 hores  
**Continguts avaluats**: DDL, DML, procediments emmagatzemats, vistes, permisos

---

## Context

Un hospital gestiona tres grups de personal:

| Codi | Grup | Membres |
|------|------|---------|
| **PS** | Personal Sanitari (metges, infermeres…) | Marta, Manolo |
| **PA** | Personal d'Administració i Serveis | Joan, Anna |
| **CE** | Comitè d'Ètica | Pepita |

L'hospital registra **pacients**, les **proves mèdiques** que se'ls fan i els **ingressos**. Cada cop que un pacient ve a l'hospital es crea un ingrés (pot durar hores o dies). Les proves s'assignen sempre a un ingrés, mai directament al pacient. Cada prova té un cost i un estoc limitat (kits o reactius disponibles). Quan es dóna l'alta al pacient, Administració genera una factura.

---

## Part 1 — DDL

Crea les taules següents a una base de dades nova anomenada `Hospital`. S'indica el nom de la taula, les columnes, els tipus i les restriccions.

```sql
CREATE DATABASE Hospital;
GO
USE Hospital;
GO

-- Pacients
CREATE TABLE Pacient (
    id          INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    nom         VARCHAR(50)  NOT NULL,
    cognoms     VARCHAR(100) NOT NULL,
    dni         VARCHAR(15)  NOT NULL UNIQUE,
    data_naix   DATE         NOT NULL
);

-- Catàleg de proves mèdiques
CREATE TABLE Prova (
    id      INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    nom     VARCHAR(100) NOT NULL,
    cost    DECIMAL(8,2) NOT NULL CHECK (cost > 0),
    stock   INT          NOT NULL CHECK (stock >= 0)
);

-- Ingressos
CREATE TABLE Ingres (
    id            INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    id_pacient    INT          NOT NULL,
    data_ingres   DATETIME     NOT NULL DEFAULT GETDATE(),
    diagnostic    VARCHAR(500) NOT NULL,
    data_alta     DATETIME     NULL,
    CONSTRAINT fk_ingres_pacient FOREIGN KEY (id_pacient)
        REFERENCES Pacient(id)
);

-- Proves realitzades durant un ingrés
CREATE TABLE ProvaIngres (
    id          INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    id_ingres   INT      NOT NULL,
    id_prova    INT      NOT NULL,
    data_prova  DATETIME NOT NULL DEFAULT GETDATE(),
    resultat    VARCHAR(500) NULL,
    CONSTRAINT fk_pi_ingres FOREIGN KEY (id_ingres)
        REFERENCES Ingres(id),
    CONSTRAINT fk_pi_prova FOREIGN KEY (id_prova)
        REFERENCES Prova(id)
);

-- Factures
CREATE TABLE Factura (
    id          INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    id_ingres   INT          NOT NULL UNIQUE,
    total       DECIMAL(10,2) NOT NULL,
    data_factura DATETIME     NOT NULL DEFAULT GETDATE(),
    CONSTRAINT fk_factura_ingres FOREIGN KEY (id_ingres)
        REFERENCES Ingres(id)
);
```

---

## Part 2 — DML: dades de prova

Insereix les dades següents per poder provar els procediments:

```sql
-- Pacients
INSERT INTO Pacient (nom, cognoms, dni, data_naix) VALUES
('Pere',   'Garcia López',    '11111111A', '1985-03-12'),
('Laura',  'Martínez Soler',  '22222222B', '1990-07-25'),
('Oriol',  'Puig Ferrer',     '33333333C', '2001-11-02');

-- Proves mèdiques
INSERT INTO Prova (nom, cost, stock) VALUES
('Anàlisi de sang',      25.00,  100),
('Radiografia tòrax',    40.00,   50),
('Ressonància magnètica', 350.00,  10),
('Test COVID-19',         15.00,    3),
('Ecografia abdominal',  80.00,   30);
```

---

## Part 3 — Procediments emmagatzemats (4 punts)

### 3.1 `fer_ingres`

Escriu un procediment emmagatzemat `fer_ingres` que ingressa un pacient.

**Paràmetres d'entrada**:

| Paràmetre | Tipus | Descripció |
|-----------|-------|------------|
| `@id_pacient` | INT | Identificador del pacient |
| `@diagnostic` | VARCHAR(500) | Motiu de l'ingrés |

**Requisits**:
1. Comprova que el pacient existeix. Si no → error.
2. Comprova que el pacient **no** té cap ingrés actiu (un ingrés és actiu quan `data_alta IS NULL`). Si ja està ingressat → error.
3. Insereix una fila a `Ingres` amb la data actual (`GETDATE()`) i el diagnòstic.
4. Envolta tot el bloc en una transacció amb `TRY/CATCH` i `ROLLBACK` en cas d'error.

> **Pista**: tria un nivell d'aïllament que eviti que dos metges ingrestin el mateix pacient alhora.

---

### 3.2 `fer_prova` (1.5 punts)

Escriu un procediment emmagatzemat `fer_prova` que assigna una prova a un pacient ingressat.

**Paràmetres d'entrada**:

| Paràmetre | Tipus | Descripció |
|-----------|-------|------------|
| `@id_pacient` | INT | Identificador del pacient |
| `@id_prova` | INT | Identificador de la prova |

**Requisits**:
1. Busca l'ingrés actiu del pacient (`data_alta IS NULL`). Si no n'hi ha → error `'El pacient no està ingressat'`.
2. Comprova que la prova existeix. Si no → error.
3. Comprova que l'estoc de la prova és > 0. Si no → error `'No queda estoc d''aquesta prova'`.
4. Decrementa l'estoc de la prova en 1.
5. Insereix una fila a `ProvaIngres` amb la data actual i el resultat a `NULL` (es registrarà més tard).
6. Tot dins una transacció amb `TRY/CATCH`.

> **Pista**: el nivell d'aïllament ha de protegir la lectura i actualització de l'estoc per evitar overselling.

---

### 3.3 `fer_factura` (1.5 punts)

Escriu un procediment emmagatzemat `fer_factura` que dóna l'alta a un pacient i genera la factura.

**Paràmetres d'entrada**:

| Paràmetre | Tipus | Descripció |
|-----------|-------|------------|
| `@id_ingres` | INT | Identificador de l'ingrés |
| `@data_alta` | DATETIME | Data i hora de l'alta |

**Requisits**:
1. Comprova que l'ingrés existeix i que encara no té alta (`data_alta IS NULL`). Si no → error.
2. Comprova que no existeix ja una factura per a aquest ingrés. Si sí → error.
3. Calcula el **total** així:
   - Suma del `cost` de totes les proves assignades a l'ingrés.
   - Més **100 €** per cada nit d'estada. El nombre de nits es calcula com `DATEDIFF(DAY, data_ingres, @data_alta)`. Si és 0 (ingrés del mateix dia) no se suma res per nits.
4. Insereix una fila a `Factura` amb el total calculat.
5. Actualitza l'ingrés posant `data_alta = @data_alta`.
6. Tot dins una transacció amb `TRY/CATCH`.

> **Pista**: pots usar `COALESCE` o `ISNULL` per tractar el cas que no s'hagin fet proves (suma = 0).

---

## Part 4 — Vistes (1.5 punts)

Crea les tres vistes següents. Cada vista serveix per donar accés controlat a un grup d'usuaris.

### 4.1 `vw_personal_sanitari` (0.5 punts)

Vista per al **Personal Sanitari (PS)**. Han de poder veure informació clínica però **no** veure dades econòmiques.

**Columnes**: `Pacient.nom`, `Pacient.cognoms`, `Ingres.data_ingres`, `Ingres.diagnostic`, `Ingres.data_alta`, `Prova.nom` (com a `nom_prova`), `ProvaIngres.resultat`, `ProvaIngres.data_prova`.

> No ha d'incloure: `Prova.cost`, `Prova.stock`, ni res de `Factura`.

### 4.2 `vw_administracio` (0.5 punts)

Vista per al **Personal d'Administració (PA)**. Han de poder veure les proves i el seu cost per poder facturar.

**Columnes**: `Pacient.nom`, `Pacient.cognoms`, `Pacient.dni`, `Ingres.id` (com a `id_ingres`), `Ingres.data_ingres`, `Ingres.data_alta`, `Prova.nom` (com a `nom_prova`), `Prova.cost`, `ProvaIngres.data_prova`.

> No ha d'incloure: `ProvaIngres.resultat` (dades clíniques) ni `Ingres.diagnostic`.

### 4.3 `vw_comite_etica` (0.5 punts)

Vista per al **Comitè d'Ètica (CE)**. Ho veu tot: dades clíniques i econòmiques.

**Columnes**: totes les del PS + les del PA. És a dir: `Pacient.nom`, `Pacient.cognoms`, `Pacient.dni`, `Ingres.data_ingres`, `Ingres.diagnostic`, `Ingres.data_alta`, `Prova.nom` (com a `nom_prova`), `Prova.cost`, `ProvaIngres.resultat`, `ProvaIngres.data_prova`.

---

## Part 5 — Usuaris, rols i permisos (1.5 punts)

### 5.1 Crea els logins i usuaris següents

Tots amb la contrasenya `@DAW2026`:

| Login/Usuari | Grup |
|---|---|
| Marta | PS |
| Manolo | PS |
| Joan | PA |
| Anna | PA |
| Pepita | CE |

### 5.2 Crea els rols i assigna membres

| Rol | Membres |
|---|---|
| `rol_ps` | Marta, Manolo |
| `rol_pa` | Joan, Anna |
| `rol_ce` | Pepita |

### 5.3 Assigna els permisos

Aplica el **principi de mínim privilegi**: cada rol només pot fer el que necessita.

| Rol | Permisos |
|---|---|
| `rol_ps` | `SELECT` sobre `vw_personal_sanitari`. `EXECUTE` sobre `fer_ingres` i `fer_prova`. |
| `rol_pa` | `SELECT` sobre `vw_administracio`. `EXECUTE` sobre `fer_factura`. |
| `rol_ce` | `SELECT` sobre `vw_comite_etica`. Cap `EXECUTE`. |

---

## Comprovacions finals suggerides

Un cop hagis acabat, prova la seqüència completa:

```
1. Connecta com a Marta (PS).
   → Executa fer_ingres per ingressar el pacient Pere amb diagnòstic 'Dolor abdominal'.
   → Executa fer_prova per fer-li una 'Anàlisi de sang' i una 'Ecografia abdominal'.
   → Comprova que pot fer SELECT sobre vw_personal_sanitari.
   → Comprova que NO pot fer SELECT sobre vw_administracio (ha de donar error).

2. Connecta com a Joan (PA).
   → Executa fer_factura donant l'alta a Pere amb data actual.
   → Comprova que el total = 25 + 80 + (100 × nits) és correcte.
   → Comprova que pot fer SELECT sobre vw_administracio.
   → Comprova que NO pot executar fer_ingres (ha de donar error).

3. Connecta com a Pepita (CE).
   → Comprova que pot fer SELECT sobre vw_comite_etica i veu tota la informació.
   → Comprova que NO pot executar cap procediment.

4. Prova casos d'error:
   → fer_ingres d'un pacient que ja està ingressat.
   → fer_prova d'un pacient que no està ingressat.
   → fer_prova quan l'estoc d'una prova és 0.
   → fer_factura d'un ingrés que ja té alta.
```