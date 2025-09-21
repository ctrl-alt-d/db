# Introducció als diagrames de representació gràfica de bases de dades

Els **diagrames de representació gràfica de bases de dades** són una eina visual que ens permet entendre i comunicar l’estructura d’una base de dades d’una manera clara i intuïtiva. Aquests diagrames serveixen per documentar i planificar com s’organitzen les dades, com es relacionen entre elles i quines restriccions hi ha.

## Objectius principals
- Representar els elements de la base de dades i les seves **relacions**.
- Facilitar la comunicació entre desenvolupadors, dissenyadors i usuaris.
- Detectar incoherències o redundàncies en el model de dades.

## Tipus més habituals
1. **Diagrama Entitat-Relació (ERD)** `Entity-Relationship Diagram`
   - Mostra entitats (taules), atributs (columnes) i relacions (vincles).
   - És el més utilitzat en fases inicials de disseny.
   - Ex.: Relació entre *Alumne* i *Assignatura*.

2. **Diagrama UML de Classes**
   - Molt usat en entorns de programació orientada a objectes.
   - Representa classes (com si fossin taules), atributs i associacions.
   - Permet incloure herència i visibilitat dels atributs.

3. **Esquema Físic** `Physical Data Model (PDM)`
   - Representació més propera a la implementació real al sistema gestor de bases de dades (SGBD).
   - Inclou tipus de dades, claus primàries i externes, índexs i restriccions.

## Elements bàsics d’un diagrama ER
- **Entitat**: Generalment representada amb un rectangle (ex. *Client*).
- **Atributs**: Ovalats o dins la taula, indiquen les característiques de l’entitat (ex. *Nom*, *DNI*).
- **Relacions**: Representades amb un rombe o una línia que connecta entitats (ex. *Compra* entre *Client* i *Producte*).
- **Cardinalitat**: Indica quantes instàncies d’una entitat poden estar associades amb instàncies d’una altra (1:1, 1:N, N:M).

## Elements bàsics d’un esquema físic.
- **Taules**: Representen entitats o objectes (ex. *Clients*, *Productes*).
- **Columnes**: Atributs o propietats de les taules (ex. *Nom*, *Preu*).
- **Claus primàries**: Identifiquen de manera única cada registre (ex. *ID_Client*).
- **Claus externes**: Enllacen taules relacionades (ex. *ID_Ordre* a la taula *Clients* que fa referència a la taula *Ordres*).

## Exemples

### Physical Data Model (PDM)

Al diagrama següent es mostra un exemple senzill d’un esquema físic per a una base de dades que gestiona informació sobre llibres i autors.
Anotem amb PK les claus primàries i amb FK les claus externes.
Observem com le taules estan relacionades a través de la clau externa `Nom_Autor` a la taula `Llibres`, que fa referència a la clau primària `Nom` a la taula `Autors`.

```plaintext
                                                                     
  ┌───────────────────────────┐            ┌────────────────────────────┐  
  │ Llibres                   │     ┌─────►│ Autors                     │  
  ├───────────────────────────┤     │      ├────────────────────────────┤  
  │                           │     │      │                            │  
  │  ISBN varchar(50) PK      │     │      │ Nom varchar(200) PK        │  
  │                           │     │      │                            │  
  │  Nom varchar(200)         │     │      │ Nacionalitat varchar(150)  │  
  │                           │     │      │                            │  
  │  Nom_Autor varchar(200) FK┼─────┘      │ Any_Defuncio  int          │  
  │                           │            └────────────────────────────┘  
  │  Any_publicacio int       │                                            
  └───────────────────────────┘                                            
                                                                           
```

### Diagrama Entitat-Relació (ERD)

Farem servir la notació crow's foot per representar les relacions entre les entitats.
En aquest diagrama es pot apreciar com un autor pot escriure múltiples llibres, però cada llibre està escrit per un únic autor.
Cal notar que aquest tipus de diagrama no inclou les claus forànees explícitament, sinó que es dedueixen de les relacions.

```plaintext
                                                                     
 ┌───────────────────────┐ 
 │    Autors             │ 
 ├───────────────────────┤ 
 │ Nom cadena AIP        │ 
 │ Nacionalitat cadena   │ 
 │ Any_Defuncio enter.   │ 
 └────────┬──────────────┘ 
          │        
          │        
          │        
         /│\       
  ┌─────/─┴─\───────────┐
  │   Llibres           │
  ├─────────────────────┤
  │ ISBN   cadena       │
  │ Nom    cadena       │
  │ Any_publicacio enter│
  └─────────────────────┘
```

### Exercici

Dibuixa el diagrama físic de les dades i el diagrama Entitat-Relació (ERD) per a una base de dades que gestioni informació sobre estudiants i grups, cada alumne està inscrit en un únic grup, però cada grup pot tenir múltiples alumnes. Dels grups tenim el nom dels estudis, el número de curs i la lletra, exemple: `DAW 1 A`, són 3 camps i tots tres formen part de la PK (clau primària). Dels alumnes tenim el nom, cognoms i DNI. La clau primària dels alumnes és el DNI.