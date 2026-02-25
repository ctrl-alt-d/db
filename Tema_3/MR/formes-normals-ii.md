# Segona Forma Normal (2FN)  
## DAW-MP02-UF1 - Exercici d'Introducció a les Bases de Dades  

### **Definició**

> Una taula que està en **primera forma normal (1FN)** ha de complir criteris addicionals per qualificar com a **segona forma normal (2FN)**. Concretament:
> Una taula està en 2FN si està en 1FN i cap atribut no primer depèn d’un subconjunt propi de cap clau candidata de la taula.  
> Un atribut no primer és aquell que no forma part de cap clau candidata.

---

### **Interpretació**

Perquè una relació estigui en **segona forma normal (2FN)**:  
1. Ha d’estar en **primera forma normal (1FN)**.  
2. Cada atribut no clau ha de dependre de **tota la clau primària**.  

#### Exemple:

Relació inicial:  

| _Alumne | Població  | _Avaluació | Nota |
|------------|-----------|---------------|------|
| Pere       | Roses     | 1             | 8    |
| Pere       | Roses     | 2             | 7    |
| Marta      | Olot      | 1             | 8    |

- **Clau primària:** Alumne + Avaluació.  
- Problema: L’atribut *Població* no depèn de tota la clau primària, només depèn de *Alumne*.  

Per tant, la relació **no està en segona forma normal**.

---

### **Pas a Segona Forma Normal**

1. Mou els atributs que no depenen funcionalment de tota la clau primària a una altra taula.  
2. Afegeix una còpia del determinant (atribut del qual depenen) com a nova clau primària a la nova taula.

Relacions després de la normalització:  

**Notes:**  

| _Alumne | _Avaluació | Nota |
|---------|------------|------|
| Pere    | 1          | 8    |
| Pere    | 2          | 7    |
| Marta   | 1          | 8    |

**Alumnes:**  

| _Alumne | Població  |
|---------|-----------|
| Pere    | Roses     |
| Marta   | Olot      |

---

## **Exercicis**

### **1. Normalitza aquesta taula:**

Relació inicial: suposem una taula que informa de la puntuació màxima de cada jugador per cada dia. Per exemple, Zoom el dia 01/09/2016 va obtenir una puntuació màxima de 24K. També s'indica la nacionalitat del jugador.

| _Jugador | País       | _Dia       | MàximaPuntuació |
|---------|------------|------------|-----------------|
| Zoom    | Catalunya  | 01/09/2016 | 24K             |
| Zoom    | Catalunya  | 02/09/2016 | 23K             |
| Creep   | Itàlia     | 01/09/2016 | 45K             |
| Creep   | Itàlia     | 02/09/2016 | 13K             |
| Nation  | Algèria    | 02/09/2016 | 78K             |


#### Solució:

1. **Comprova si està en 2FN:**  
   - Clau primària: _Jugador + _Dia
   - L'atribut *País* no depèn de tota la clau primària, sinó només de _Jugador.

2. **Pas a 2FN:**  
   - Crea una nova taula per als atributs que no depenen de tota la clau primària.

**Taula 1: JugadorDia (2FN):**  

| _Jugador | _Dia       | MàximaPuntuació |
|----------|------------|-----------------|
| Zoom     | 1/9/2016   | 24K            |
| Zoom     | 2/9/2016   | 23K            |
| Creep    | 1/9/2016   | 45K            |
| Creep    | 2/9/2016   | 13K            |
| Nation   | 2/9/2016   | 78K            |

**Taula 2: Jugadors:**  

| _Jugador | Country   |
|----------|-----------|
| Zoom     | Cat       |
| Creep    | Italy     |
| Nation   | Algery    |

---

### **2. Normalitza aquesta taula:**

Relació inicial:  

| _Jugador | País       | _Dia       | MàximaPuntuació |
|---------|------------|------------|-----------------|
| Zoom    | Catalunya  | 01/09/2016 | 24K             |
| Zoom    | Catalunya  | 02/09/2016 | 23K             |
| Creep   | Itàlia     | 01/09/2016 | 45K             |
| Creep   | Itàlia     | 02/09/2016 | 13K             |
| Nation  | Algèria    | 02/09/2016 | 78K             |


#### Solució:

1. **Comprova si està en 2FN:**  
   - Clau primària: **Jugador** + **Dia**.  
   - L' atribut *Country* no depen de tota la clau primària.  

2. **Pas a 2FN:**  
   - Crea dues taules per moure els atributs que no depenen de tota la clau primària.

**Taula 1: JugadorDia (2FN):**  

| _Jugador | _Dia       | MàximaPuntuació |
|----------|------------|-----------------|
| Zoom     | 01/09/2016 | 24K             |
| Zoom     | 02/09/2016 | 23K             |
| Creep    | 01/09/2016 | 45K             |
| Creep    | 02/09/2016 | 13K             |
| Nation   | 02/09/2016 | 78K             |

**Taula 2: Jugadors:**  

| _Jugador | País       |
|----------|------------|
| Zoom     | Catalunya  |
| Creep    | Itàlia     |
| Nation   | Algèria    |
