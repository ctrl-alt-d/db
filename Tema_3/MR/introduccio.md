# Apunts sobre el model relacional

## El model relacional

En aquest tema estudiarem el model relacional, que és el que utilitzen els sistemes gestors de bases de dades relacionals. Aprendrem a fer el pas del MCD (model conceptual de dades) al MLD (model lògic de dades).

### Explicació del model relacional

El model relacional organitza les dades en una o més taules (també anomenades relacions) formades per columnes i files; cada fila té una clau única que la identifica. Les files també es coneixen com a registres o tuplas, i les columnes com a atributs.

Generalment, cada taula representa un tipus d'entitat (per exemple: client, producte). Les files representen instàncies concretes d'aquesta entitat (per exemple, un client anomenat Pere) i les columnes contenen els valors que descriuen les característiques de cada instància (adreça, preu, etc.).

Aquest model facilita l'organització i la consulta de dades, ja que cada fila conté la informació d'una instància i cada columna especifica un atribut homogeni.

## Preguntes freqüents (FAQ)

### Qui va postular el model relacional? En quin any i on es va publicar?
El model relacional va ser proposat per Edgar F. Codd l'any 1970, a l'article «A Relational Model of Data for Large Shared Data Banks», publicat a Communications of the ACM.

### Què és una relació?
Una relació en el model relacional és una taula de dades que segueix una estructura fixa i conté un conjunt de tuplas (files) amb el mateix conjunt d'atributs (columnes).

### Què és una tupla?
Una tupla és una fila dins d'una relació; representa una instància concreta d'informació amb valors per a cada atribut.

### Què és una taula?
Una taula és una estructura bidimensional que conté un conjunt d'atributs com a columnes i un conjunt de registres (tuplas) com a files.

### Què és un registre?
Un registre és un sinònim de tupla; representa una fila d'una taula amb valors específics per als seus atributs.

### Què és un domini?
Un domini és l'interval de valors possibles que pot tenir un atribut. Cada atribut està associat a un domini (per exemple: enters, text, dates, etc.).

### Què és un atribut?
Un atribut és una columna d'una taula que defineix una característica específica d'una relació. Els atributs tenen noms únics dins de la relació i estan associats a un domini.

### Què és el grau d'una relació?
El grau és el nombre d'atributs (columnes) d'una relació; indica quantes característiques descriuen cada tupla.

### Què és la cardinalitat d'una relació?
La cardinalitat és el nombre de tuplas (registres) d'una relació; mesura la quantitat de files presents a la taula.

## Independència de les dades en el model relacional

### Independència física de les dades
La independència física de les dades és la capacitat de modificar el nivell físic d'emmagatzematge (per exemple, canviar la ubicació dels fitxers, optimitzar índexs o ajustar estructures) sense modificar el nivell lògic ni afectar les aplicacions que fan servir la base de dades. Això permet millorar el rendiment i adaptar‑se a noves tecnologies d'emmagatzematge sense alterar com els usuaris accedeixen a la informació.

### Independència lògica de les dades
La independència lògica de les dades permet modificar l'esquema lògic de la base de dades (per exemple, afegir o eliminar taules o camps) sense que això afecti les aplicacions que utilitzen la base de dades. És essencial per garantir que la base de dades s'adapti a noves necessitats sense afectar l'emmagatzematge físic.

Per a una explicació pràctica sobre els nivells ANSI‑SPARC, consulta aquesta discussió: [ANSI‑SPARC practical explanation](https://stackoverflow.com/questions/9771884/ansi-sparc-practical-explanation).

En resum, aquestes dues formes d'independència separen els nivells físic i lògic, facilitant l'adaptabilitat i la flexibilitat del sistema de gestió de bases de dades.
