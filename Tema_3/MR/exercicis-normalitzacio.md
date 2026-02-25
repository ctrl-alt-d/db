### **Exercici 0: Normalització d'una taula d'estudiants i assignatures**

#### **Taula inicial no normalitzada:**
La següent taula conté informació sobre estudiants, les assignatures en què estan matriculats i les notes finals:

| **_Estudiant_ID** | **Nom_Estudiant** | **Població**     | **Comarca**      | **Assignatures**                     | **Codis_Assignatures** | **Nota_Final** |
|--------------------|-------------------|------------------|------------------|--------------------------------------|------------------------|----------------|
| 1                  | Maria Pérez       | Barcelona        | Barcelonès       | Matemàtiques, Física                 | 101, 102              | 8, 7           |
| 2                  | Joan Ruiz         | Tarragona        | Tarragonès       | Química                              | 103                   | 9              |
| 3                  | Anna Soler        | Sabadell         | Vallès Occidental | Física, Informàtica                  | 102, 104              | 6, 8           |

---

#### **Pas 1: Primera Forma Normal (1NF)**

La taula inicial no està en 1NF perquè conté valors multivalorats (assignatures, codis d'assignatures i notes en una única cel·la). Desglossem aquestes dades perquè cada cel·la tingui un únic valor:

| **_Estudiant_ID** | **Nom_Estudiant** | **Població**     | **Comarca**      | **_Assignatura_ID** | **Nom_Assignatura** | **Nota_Final** |
|--------------------|-------------------|------------------|------------------|---------------------|---------------------|----------------|
| 1                  | Maria Pérez       | Barcelona        | Barcelonès       | 101                 | Matemàtiques        | 8              |
| 1                  | Maria Pérez       | Barcelona        | Barcelonès       | 102                 | Física              | 7              |
| 2                  | Joan Ruiz         | Tarragona        | Tarragonès       | 103                 | Química             | 9              |
| 3                  | Anna Soler        | Sabadell         | Vallès Occidental | 102                 | Física              | 6              |
| 3                  | Anna Soler        | Sabadell         | Vallès Occidental | 104                 | Informàtica         | 8              |

---

#### **Pas 2: Segona Forma Normal (2NF)**

La taula no està en 2NF perquè hi ha dependències parcials: la informació com el nom de l'estudiant, la població i la comarca depenen només de `_Estudiant_ID`, i no de la clau composta `_Estudiant_ID` + `_Assignatura_ID`. Dividim la taula en dues taules per eliminar aquestes dependències parcials:

1. **Taula d'Estudiants**:

| **_Estudiant_ID** | **Nom_Estudiant** | **Població**     | **Comarca**      |
|--------------------|-------------------|------------------|------------------|
| 1                  | Maria Pérez       | Barcelona        | Barcelonès       |
| 2                  | Joan Ruiz         | Tarragona        | Tarragonès       |
| 3                  | Anna Soler        | Sabadell         | Vallès Occidental |

2. **Taula de Matriculacions**:

| **_Estudiant_ID** | **_Assignatura_ID** | **Nota_Final** |
|--------------------|---------------------|----------------|
| 1                  | 101                 | 8              |
| 1                  | 102                 | 7              |
| 2                  | 103                 | 9              |
| 3                  | 102                 | 6              |
| 3                  | 104                 | 8              |

3. **Taula d'Assignatures**:

| **_Assignatura_ID** | **Nom_Assignatura** |
|---------------------|---------------------|
| 101                 | Matemàtiques        |
| 102                 | Física              |
| 103                 | Química             |
| 104                 | Informàtica         |

---

#### **Pas 3: Tercera Forma Normal (3NF)**

La taula no està en 3NF perquè hi ha dependències transitives: per exemple, la **Comarca** depèn de la **Població**, que depèn de `_Estudiant_ID`. Cal dividir la taula d'estudiants per eliminar aquestes dependències:

1. **Taula d'Estudiants**:

| **_Estudiant_ID** | **Nom_Estudiant** | **Nom_Població** |
|--------------------|-------------------|------------------|
| 1                  | Maria Pérez       | Barcelona              |
| 2                  | Joan Ruiz         | Tarragona              |
| 3                  | Anna Soler        | Sabadell              |

2. **Taula de Poblacions**:

| **_Nom_Població** | **Comarca**          |
|------------------|----------------------|
| Barcelona        | Barcelonès           |
| Tarragona        | Tarragonès           |
| Sabadell         | Vallès Occidental    |

3. **Taula de Matriculacions**:

| **_Estudiant_ID** | **_Assignatura_ID** | **Nota_Final** |
|--------------------|---------------------|----------------|
| 1                  | 101                 | 8              |
| 1                  | 102                 | 7              |
| 2                  | 103                 | 9              |
| 3                  | 102                 | 6              |
| 3                  | 104                 | 8              |

4. **Taula d'Assignatures**:

| **_Assignatura_ID** | **Nom_Assignatura** |
|---------------------|---------------------|
| 101                 | Matemàtiques        |
| 102                 | Física              |
| 103                 | Química             |
| 104                 | Informàtica         |

---


### **Exercici 1: Normalització d'una taula de clients i material arrendat**
Imagina que tens la següent taula no normalitzada, que conté informació sobre clients i el material que ens té llogat en aquest moment:

| **_Client_ID** | **Nom**     | **Adreça**       | **Material arrendat**                 |
|----------------|-------------|------------------|------------------------------|
| 1              | Maria Pérez | Carrer A, 123    | Neveres XL, 2; Microones, 5      |
| 2              | Joan Ruiz   | Carrer B, 456    | Nevera XXL, 3                  |
| 3              | Anna Soler  | Carrer C, 789    | Microones, 10; Nevera SM, 1    |

**Preguntes**:
1. Identifica per què aquesta taula no compleix la 1NF.
2. Converteix la taula en una forma que compleixi la 1NF.

---

### **Exercici 2: Normalització d'una taula de cursos i estudiants**
Observa aquesta taula no normalitzada que conté informació sobre estudiants inscrits en diferents cursos:

| **_Estudiant_ID** | **Nom**          | **Cursos**                             |
|--------------------|------------------|----------------------------------------|
| 101                | Laura Martínez   | Matemàtiques, Física                  |
| 102                | Marc García      | Química, Biologia, Història           |
| 103                | Júlia Fernández  | Matemàtiques, Física, Informàtica     |

**Preguntes**:
1. Explica per què aquesta taula no està en 1NF.
2. Transforma la taula per complir la 1NF indicant les claus primàries i estrangeres si cal.


### **Exercici 3: Normalització d'una taula de comandes i productes**
Observa la següent taula no normalitzada:

| **_Comanda_ID** | **_Producte_ID** | **Nom_Producte** | **Quantitat** | **Nom_Client** | **Adreça_Client** |
|------------------|------------------|------------------|---------------|-----------------|--------------------|
| 1                | 101              | Bolígrafs        | 5             | Joan Pérez      | Carrer X, 123      |
| 1                | 102              | Llibreta         | 2             | Joan Pérez      | Carrer X, 123      |
| 2                | 101              | Bolígrafs        | 10            | Maria Torres    | Carrer Y, 456      |

**Preguntes**:
1. Explica per què aquesta taula no compleix la 2NF.
2. Transforma la taula per complir la 2NF. Divideix-la en les taules necessàries indicant les claus primàries i estrangeres.

---

### **Exercici 4: Normalització d'una taula de cursos i professors**
Observa la següent taula:

| **_Curs_ID** | **_Professor_ID** | **Nom_Curs**   | **Duració**  | **Nom_Professor** | **Especialitat del professor**    |
|--------------|-------------------|----------------|--------------|--------------------|---------------------|
| 1            | 201               | Matemàtiques   | 40 hores     | Anna Martí         | Matemàtiques        |
| 2            | 202               | Física         | 30 hores     | Joan López         | Física              |
| 3            | 201               | Estadística    | 20 hores     | Anna Martí         | Matemàtiques        |

**Preguntes**:
1. Identifica per què aquesta taula no està en 2NF.
2. Divideix la taula en les seves parts normalitzades per complir la 2NF. Defineix les claus primàries i estrangeres.

### **Exercici 5: Normalització d'una taula de projectes**
Observa la següent taula:

| **_Projecte_ID** | **Nom_Projecte** | **_Empleat_ID** | **Nom_Empleat** | **Càrrec**       | **Departament** | **Cap departament** |
|-------------------|------------------|-----------------|-----------------|------------------|-----------------|----|
| 1                 | Alpha           | 101             | Laura Martí     | Enginyera        | R+D             |  101 |
| 2                 | Beta            | 102             | Joan López      | Analista         | IT              |  108 |
| 3                 | Gamma           | 101             | Laura Martí     | Enginyera        | R+D             |  101 |

**Preguntes**:
1. Identifica les dependències transitives i explica per què aquesta taula no compleix la 3NF.
2. Recorda que abans d'estar en 3FN ha d'estar en 2FN (i 1FN)
3. Divideix la taula en les seves parts normalitzades per complir la 3NF. Defineix les claus primàries i estrangeres i descriu les relacions entre les noves taules.


---

### **Exercici 6: Normalització d'una taula de vendes**
Observa la següent taula no normalitzada:

| **_Venda_ID** | **_Producte_ID** | **Nom_Producte** | **Categoria** | **Preu** | **Quantitat_Venuda** | **Import_Total** | **Descripció Categoria** |
|---------------|------------------|------------------|---------------|----------|----------------------|------------------|-----------------|
| 1             | 101              | Bolígrafs        | Papereria     | 1.50 €   | 10                   | 15.00 €          |  Material de parpereria |
| 2             | 102              | Llibreta         | Papereria     | 2.00 €   | 5                    | 10.00 €          |  Material de parpereria |
| 3             | 101              | Bolígrafs        | Papereria     | 1.50 €   | 20                   | 30.00 €          |  Material de parpereria |

**Preguntes**:
1. Per què aquesta taula no compleix la 3NF? Indica les dependències transitives existents.
2. Recorda que abans d'estar en 3FN ha d'estar en 2FN (i 1FN)
3. Normalitza la taula perquè compleixi la 3NF i descriu les relacions entre les noves taules.


### **Exercici 7: Normalització d'una taula de clients i comptes bancaris**

La següent taula conté informació sobre clients i els seus comptes bancaris. Observa que hi ha valors multivalorats a les columnes **Codis_Compte_Bancari** i **Saldo**:

| **_NIF_Client** | **Nom_Client** | **Població_Client** | **Província_Client** | **Codis_Compte_Bancari_amb_Data_alta**                    | **Saldos**                |
|------------------|----------------|---------------------|-----------------------|---------------------------------------------|--------------------------|
| 12345678A        | Maria Pérez    | Barcelona          | Barcelona            | ES1234567890 (2023-01-15), ES0987654321 (2022-12-01) | 1500.00 €, 2000.00 €    |
| 87654321B        | Joan López     | Sabadell           | Barcelona            | ES1111111111 (2023-05-10)                   | 500.00 €                |

**Tasques**:

Passar a 3a forma normal. Per les FN 1, 2 i 3 explicar si les compleix o no i per què, com es fa per tal que compleixi i normalitzar.

Nota: En aquest exercici, el `_NIF_Client` està marcat com clau primària. Tanmateix, quan passem a primera forma normal, ens trobarem que el nif ja no serà clau primària, que ara la clau primària serà el `codi_compte_bancari`.


