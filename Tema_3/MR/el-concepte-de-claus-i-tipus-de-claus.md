# El concepte de claus i tipus de claus

En una base de dades relacional, les claus són fonamentals per garantir la unicitat i establir relacions entre taules. A continuació, documentem els diferents tipus de claus amb exemples i les seves característiques principals.

---

## Claus Candidates

Una **clau candidata** és un atribut o conjunt mínim d'atributs que pot identificar unívocament una tupla dins d'una relació. Les claus candidates han de complir:

- **Unicitat**: Cada valor o combinació de valors ha de ser únic en la relació.
- **Minimalitat**: Cap atribut pot ser eliminat de la clau sense perdre la propietat d'unicitat.

### Exemple

En una taula `Usuaris`:

| ID_Usuari | DNI         | Email                | Nom    |
|-----------|-------------|----------------------|--------|
| 1         | 12345678A   | usuari1@email.com    | Anna   |
| 2         | 87654321B   | usuari2@email.com    | Joan   |

- Claus candidates: 
  - `ID_Usuari`
  - `DNI`
  - `Email`

Totes aquestes claus són candidates perquè compleixen unicitat i minimalitat.

---

## Claus Primàries

La **clau primària** és una clau candidata seleccionada per identificar unívocament cada tupla dins d'una relació. Només pot existir una clau primària per taula, i no pot contenir valors nuls.

### Exemple

En la mateixa taula `Usuaris`:

| ID_Usuari | DNI         | Email                | Nom    |
|-----------|-------------|----------------------|--------|
| 1         | 12345678A   | usuari1@email.com    | Anna   |
| 2         | 87654321B   | usuari2@email.com    | Joan   |

- La clau primària triada podria ser `ID_Usuari`.

> **Nota**: Les claus primàries són habitualment claus artificials (generades pel sistema) per simplificar la gestió i evitar problemes amb la modificació d'altres camps.

---

## Claus Alternatives

Una **clau alternativa** és qualsevol clau candidata que no ha estat seleccionada com a clau primària. Així, si una taula té múltiples claus candidates, les que no s'utilitzen com a primària es consideren alternatives.

### Exemple

En la taula `Usuaris`:

| ID_Usuari | DNI         | Email                | Nom    |
|-----------|-------------|----------------------|--------|
| 1         | 12345678A   | usuari1@email.com    | Anna   |
| 2         | 87654321B   | usuari2@email.com    | Joan   |

- Si `ID_Usuari` és la clau primària:
  - Claus alternatives: `DNI`, `Email`

---

## Claus Foranes

Una **clau forana** és un atribut o conjunt d'atributs que estableix una relació entre dues taules referenciant la clau primària d'una altra taula.

### Exemple

En una taula `Ordres` que fa referència a la taula `Usuaris`:

| ID_Ordre | ID_Usuari | Data       | Total   |
|----------|-----------|------------|---------|
| 1        | 1         | 2024-12-01 | 50.00€  |
| 2        | 2         | 2024-12-05 | 30.00€  |

- `ID_Usuari` en la taula `Ordres` és una clau forana que apunta a la clau primària `ID_Usuari` de la taula `Usuaris`.

---
---

## Clau Surrogada vs Clau Natural

Quan es defineix una clau primària en una taula, es pot optar per una **clau natural** o una **clau surrogada**. Ambdues tenen avantatges i inconvenients segons el context i les necessitats del sistema.

### Clau Natural

Una **clau natural** és un atribut o conjunt d'atributs existents en les dades que tenen significat dins del domini del negoci i que poden identificar unívocament cada tupla.

#### Avantatges
- És intuïtiva perquè prové del món real.
- No requereix la creació d'un nou camp artificial.

#### Inconvenients
- Pot ser susceptible a canvis (per exemple, si un DNI és erroni o canvia).
- Pot ser complexa si es necessita més d'un atribut (per exemple, una clau composta).

#### Exemple

En una taula `Clients`:

| DNI         | Nom    | Cognoms    | Email              |
|-------------|--------|------------|--------------------|
| 12345678A   | Anna   | López      | anna@email.com     |
| 87654321B   | Joan   | Ferrer     | joan@email.com     |

- En aquest cas, `DNI` és una clau natural perquè existeix com a identificador en el món real.

---

### Clau Surrogada

Una **clau surrogada** és un atribut artificial, sense significat dins del domini del negoci, creat exclusivament per identificar unívocament cada tupla. Sol ser un número autoincrementat o un identificador únic generat pel sistema.

#### Avantatges
- No canvia, fins i tot si els valors dels altres camps es modifiquen.
- Simplifica la gestió, especialment en claus compostes o relacions complexes.

#### Inconvenients
- No té cap significat per al negoci, i la seva interpretació pot ser menys intuïtiva.
- Pot requerir més espai de memòria si es fa servir per relacionar moltes taules.

#### Exemple

En la mateixa taula `Clients`, s'afegeix un identificador artificial `ID_Client` com a clau surrogada:

| ID_Client | DNI         | Nom    | Cognoms    | Email              |
|-----------|-------------|--------|------------|--------------------|
| 1         | 12345678A   | Anna   | López      | anna@email.com     |
| 2         | 87654321B   | Joan   | Ferrer     | joan@email.com     |

- Aquí, `ID_Client` és la clau surrogada.

---

### Comparació

| Característica         | Clau Natural                        | Clau Surrogada                     |
|------------------------|--------------------------------------|-------------------------------------|
| **Significat**         | Té significat en el domini del negoci. | No té significat en el negoci.     |
| **Canvis**             | Pot canviar si el valor real canvia. | Es manté constant.                 |
| **Simplicitat**        | Pot ser complexa si requereix més atributs. | És sempre senzilla.                |
| **Rendiment**          | Pot ser menys eficient en relacions complexes. | Òptima per a relacions grans.      |
| **Exemple**            | DNI, número de compte.              | ID autoincrementat, UUID.          |

---
