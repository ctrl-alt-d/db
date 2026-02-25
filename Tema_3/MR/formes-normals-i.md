# Primera Forma Normal (1FN)  
## DAW-MP02-UF1 - Exercici d'Introducció a les Bases de Dades  

### **Definició**

La **primera forma normal (1FN)** és una propietat d'una relació en una base de dades relacional. Una relació està en primera forma normal si, i només si:  
1. El domini de cada atribut conté només valors **atòmics** (indivisibles).  
2. El valor de cada atribut conté només un únic valor del seu domini.  

Font: [1]

---

### **Interpretació**

- No es poden utilitzar atributs **multivaluats**, és a dir, camps que continguin més d'un valor alhora.

Exemple de camp multivaluat:  
- Una columna que emmagatzemi diversos números de telèfon separats per comes.

---

### **Solució**

Cal **despivotar** (transformar) les dades que no estan en primera forma normal.  

#### Exemple:

Abans de la normalització:  

| _Nom   | Telf1 | Telf2 | Telf3 |
|-------|-------|-------|-------|
| Pere  | 12    | 42    | -     |
| Marta | 15    | -     | -     |


Després de la normalització:  

| _Nom   | _Telf |
|-------|------|
| Pere  | 12   |
| Pere  | 42   |
| Marta | 15   |

---

### **Experiència**

Sovint es troba algú que vol **reinventar la roda** i decideix posar informació en un camp de la base de dades separada per comes. Al principi sembla una gran idea, però, a mesura que la base de dades creix, es fa evident que aquesta pràctica crea problemes greus quan cal relacionar aquesta taula amb una altra a través d'aquell camp.

Una base de dades que no està en primera forma normal es coneix com **Non First Normal Form (NFNF)** o, de manera simplificada, **NF²**.

---

## **Exercici**

Llegeix [Is storing a delimited list in a database column really that bad?](http://stackoverflow.com/questions/3653462/is-storing-a-delimited-list-in-a-database-column-really-that-bad) i contesta les següents preguntes:

1. **Si emmagatzemem dades separades per comes en un camp de la base de dades, quina forma normal estem incomplint?**  
   Estem incomplint la **primera forma normal (1FN)**, ja que un atribut conté més d'un valor del seu domini.

2. **Documenta per què és tan dolent treballar en NF²:**  
   - **Dificultat en les consultes:** Per recuperar informació dels camps separats per comes, cal fer ús de funcions o processos complexos, cosa que complica l'optimització i rendiment de les consultes.
   - **Problemes en la relació de taules:** És pràcticament impossible fer un enllaç amb altres taules de manera efectiva, ja que el camp no és atòmic.
   - **Augment del risc d'errors:** Modificar o actualitzar un valor en un camp amb dades separades per comes és més complex i propens a errors.
   - **Pèrdua de consistència:** És fàcil que es creïn incoherències perquè no es pot aplicar la integritat referencial als valors individuals.

En resum, treballar en NF² és una mala pràctica que impacta negativament en la mantenibilitat i eficiència de la base de dades.
