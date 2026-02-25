# Apunts sobre el Model Relacional

## El model relacional

En aquest tema esturiarem el model relacional, que és el que fan servir els sistemes gestors de bases de dades relacionals. Aprendrem a fer el pas del MCD (Model conceptual de dades) a MLD (Model lògic de dades).

### Explicació del Model Relacional

El **model relacional** organitza les dades en una o més **taules** (també anomenades "relacions") formades per **columnes** i **files**, on cada fila té una **clau única** que la identifica. Les files també es coneixen com a **registres** o **tuples**, i les columnes com a **atributs**.

Generalment, cada taula o relació representa un tipus d'**entitat** (com per exemple, "client" o "producte"). Les files dins de la taula representen instàncies específiques d'aquesta entitat (per exemple, un client com "Pere" o un producte com "taula"), i les columnes contenen els **valors** que descriuen les característiques de cada instància (com ara l'adreça per als clients o el preu per als productes).

Aquesta estructura facilita l'organització i consulta de dades, ja que cada fila conté informació completa sobre una entitat específica, i cada columna especifica atributs consistents i homogenis.

## FAQs

### Qui va postular el model relacional. En quin any. On es va publicar.
El model relacional va ser postulat per **Edgar F. Codd** l'any **1970**. Aquest treball es va publicar a l'article titulat "**A Relational Model of Data for Large Shared Data Banks**" a la revista **Communications of the ACM**.

### Què és una relació.
Una **relació** en el model relacional és una **taula de dades** que segueix una estructura fixa i conté un conjunt de tuplas (files) que comparteixen el mateix conjunt d'atributs (columnes).

### Què és una tupla.
Una **tupla** és una fila dins d'una relació o taula. Representa una **instància concreta d'informació** i conté valors específics per a cada atribut de la relació.

### Què és una taula.
Una **taula** en el model relacional és una **estructura de dades bidimensional** que conté un conjunt d'atributs com a columnes i un conjunt de registres (o tuplas) com a files.

### Què és un registre.
Un **registre** és un altre terme per a una **tupla** en el model relacional. Representa una fila d'una taula amb valors específics per a cada atribut.

### Què és un Domini.
Un **Domini** és l'**interval de valors possibles** que pot tenir un atribut. Cada atribut està associat a un domini que defineix el tipus de valors que pot emmagatzemar (com nombres enters, text, dates, etc.).

### Què és un Atribut.
Un **Atribut** és una **columna en una taula** que defineix una característica específica d'una relació. Els atributs tenen noms únics dins de la relació i estan associats a un domini.

### Què és el Grau al model relacional.
El **Grau** en el model relacional és el **nombre d'atributs** o columnes d'una relació o taula. Indica la quantitat de característiques que es descriuen per cada tupla en la taula.

### Què és la Cardinalitat al model relacional.
La **Cardinalitat** en el model relacional és el **nombre de tuplas** o registres en una relació o taula. Aquesta mesura quantifica la quantitat de files presents en la taula.

## Independència de les Dades en el Model Relacional

### Independència Física de les Dades
La **independència física de les dades** és la capacitat de modificar el nivell físic d’emmagatzematge de les dades (com ara canviar la ubicació física dels fitxers, optimitzar els índexs, o ajustar les estructures d’emmagatzematge) sense haver de modificar el nivell lògic de la base de dades ni afectar les aplicacions que fan servir aquestes dades. Això permet millorar el rendiment i adaptar-se a noves tecnologies d’emmagatzematge sense alterar la forma en què els usuaris i les aplicacions accedeixen a la informació.

### Independència Lògica de les Dades
La **independència lògica de les dades** es refereix a la capacitat de poder modificar l’esquema lògic de la base de dades (per exemple, afegir o eliminar taules o camps, o canviar les relacions entre elles) sense que afecti a les aplicacions que utilitzen la base de dades. Aquesta independència és essencial per garantir que la base de dades pugui adaptar-se a noves necessitats d'informació i estructures sense afectar la manera com les dades s’emmagatzemen físicament.

Fes un cop d'ull a la pregunta [ANSI-SPARC practical explanation](https://stackoverflow.com/questions/9771884/ansi-sparc-practical-explanation) de StackOverflow per a una explicació més detallada de la independència de les dades en el context del model relacional.

En resum, aquestes dues formes d’independència permeten mantenir separats els nivells físic i lògic de la base de dades, facilitant l’adaptabilitat i la flexibilitat del sistema de gestió de bases de dades en el model relacional.
