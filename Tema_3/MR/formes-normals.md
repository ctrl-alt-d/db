
# Documentació: Normalització de bases de dades relacionals

La normalització és el procés per organitzar els atributs i les relacions d'una base de dades relacional per tal de reduir la **redundància** de les dades i augmentar la **integritat**.

---

## **Explicació**

Amb el MCD i el seu pas a model lògic i físic hem après a crear les estructures que ens serviran de base per emmagatzemar la informació. Si ho hem fet correctament:

- Cada dada apareix només una sola vegada a la seva corresponent relació (excepte en el cas de les claus foranes, on la **integritat referencial** s'encarrega de mantenir la coherència).

Existeix una altra metodologia més formal i menys intuitiva que, aplicada a tot el conjunt d'atributs del nostre univers de discurs, ens portaria a la mateixa organització en relacions que obtenim mitjançant el MCD i el seu pas al MER. Aquesta metodologia s'anomena **normalització**.

Encara que el procés de normalització és llarg i es realitza pas a pas, no és habitual utilitzar-lo directament per dissenyar estructures de dades. Tanmateix, és útil per justificar per què una relació està mal construïda. Per exemple, és més senzill dir: "aquesta relació està malament perquè no compleix amb la 2a forma normal" que justificar-ho des del MCD.

### Avantatges de la normalització
- Una base de dades en **3a forma normal** sol estar lliure d'anomalies en:
   - **Inserció**
   - **Actualització**
   - **Esborrat**

---

## **Exercici 1: Raonament sobre les formes normals**

**Pregunta:**  
Per què un informàtic ha de conèixer, almenys, les 3 primeres formes normals?

**Resposta esperada:**  
Les 3 primeres formes normals garanteixen una organització eficient de les dades, evitant redundàncies i anomalies. A més, són una eina formal per identificar i justificar errors en el disseny d'una base de dades.

---

## **Exercici 2: Anàlisi d'una taula no normalitzada**

Un professor emmagatzema informació dels seus alumnes en una taula Excel de la següent manera:

| _Alumne | Població  | _Avaluació | Nota |
|--------|-----------|-----------|------|
| Pere   | Roses     | 1         | 8    |
| Pere   | Roses     | 2         | 7    |
| Pere   | Roses     | 1         | 5    |
| Marta  | Figueres  | 1         | 8    |


### Reflexiona sobre les següents preguntes:

1. **Com sap el professor la població dels alumnes fins que els posa la nota?**  
   La informació de la població està repetida per cada nota d'un mateix alumne. Això pot causar confusió o errors si hi ha incoherències en les dades.

2. **Pot contenir aquesta taula incoherències?**  
   Sí. La repetitivitat pot provocar:
   - Errors humans en la introducció de dades.
   - Dificultats en la modificació d'informació comuna (exemple: un canvi de població).

3. **Si un alumne canvia de població, quants canvis hem de fer a la taula? Et sembla coherent?**  
   S'haurien de modificar totes les files que continguin l'alumne afectat. Això és ineficient i poc coherent, augmentant el risc d'incoherències.

4. **Se solucionen aquestes incoherències si tenim dues taules: 'Alumnes' i 'Notes'?**  
   Sí, dividint la informació en dues taules s'eliminen redundàncies:

   - **Taula 'Alumnes':**

     | _Alumne | Població  |
     |--------|-----------|
     | Pere   | Roses     |
     | Marta  | Figueres  |

   - **Taula 'Notes':**

     | _Alumne | _Avaluació | Nota |
     |--------|-----------|------|
     | Pere   | 1         | 8    |
     | Pere   | 2         | 7    |
     | Marta  | 1         | 8    |

---

## **Exercici 3: Normalització i MySQL**

Consulta la pregunta a StackOverflow: [Normalization in MYSQL](http://stackoverflow.com/questions/1258743/normalization-in-mysql).

### Preguntes:

1. **Amplia el teu vocabulari anglès: què significa 'layman terms'?**  
   'Layman terms' significa explicar un concepte en termes senzills, comprensibles per algú sense coneixements tècnics específics.

2. **És la normalització un procés específic de cada SGBD comercial?**  
   No. La normalització és un procés teòric i independent del sistema de gestió de bases de dades (SGBD). S'aplica de manera general per garantir un disseny adequat de la base de dades.

3. **Com fa per normalitzar la taula 'Empleats' l'usuari *Extrakun*?**  
   L'usuari *Extrakun* divideix la taula 'Empleats' en diverses taules per eliminar redundàncies i garantir integritat referencial. Segueix els principis de les formes normals per assegurar que cada atribut pertany a la seva entitat correcta i redueix la dependència entre atributs no claus.

---
