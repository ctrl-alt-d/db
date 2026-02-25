## El model entitat‑relació — Introducció
### Exercici: introducció a les bases de dades
Al llibre Diseño de bases de datos relacionales, els autors Adoración de Miguel, Mario Piattini i Esperanza Marcos defineixen les etapes del disseny:

* Món real: persones, animals i altres elements del món real que volem informatitzar.
* Univers de discurs: visió del món real amb uns objectius determinats.
* Model conceptual de dades: és la representació gràfica —en un llenguatge de símbols— que identifica entitats i relacions dins l'univers de discurs.
* Model lògic (base de dades): concreció del model conceptual en un model de base de dades (relacional, post‑relacional, etc.).
* Model intern (estructures de dades): estructures internes del SGBD (taules, índexs, col·leccions, ...).
* Emmagatzematge físic: fitxers de dades, fitxers de registre (logs), fitxers de control, fitxers de configuració, etc.

Jo prefereixo veure-ho com les concrecions del disseny, de més abstracte a més concret: de les idees als 0 i 1.

**Exercicis**

* Procura comprendre que el model entitat‑relació (entity–relationship model, ER) permet descriure el model conceptual de dades.
* Cerca al diccionari què és un "model" i reflexiona per què s'utilitza aquest terme aplicat al model conceptual de dades.
* Recorda que el model entitat‑relació sovint s'anomena diagrama entitat‑relació perquè s'usen símbols per representar entitats i interrelacions.
* Fixa't en què la paraula «relació» té semàntiques diferents en el model entitat‑relació i en el model relacional: al primer fa referència a les relacions entre entitats; al segon, a conjunts de dades (taules).
* El terme correcte és model entitat‑relació; la variant «entitat inter‑relació» s'usa ocasionalment per remarcar la distinció conceptual. Cerca els noms equivalents en anglès: "relational model" i "entity–relationship model".


## Importància del model entitat‑relació
### Exercici: introducció a les bases de dades
El model entitat‑relació presenta l'esquema de dades de negoci en un format gràfic.

Saber construir i interpretar un diagrama entitat‑relació és fonamental per diverses raons:

* Igual que un músic llegeix una partitura, un desenvolupador ha de saber llegir un model per comprendre les entitats del sistema, les seves interrelacions i els atributs.
* Amb un model entitat‑relació és possible fer‑se una idea ràpida de la complexitat d'un sistema, identificar els elements principals i conèixer les restriccions i limitacions: és un mapa de les dades.

**Exercicis pràctics**

1. L'Orquestra de Girona contracta un pianista. Quan li passen la partitura, el músic diu: «Jo no sé llegir una partitura; me la podeu passar en MP3?» Creus que aquest cas és realista? Per què? Adapta aquest microconte al sector informàtic i després al sector de la construcció.
2. En un projecte nou, l'equip comenta que la base de dades només emmagatzema el telèfon fix, el mòbil i l'e‑mail dels clients, però se'ls demana també el compte de Twitter i Instagram. Si un informàtic rep el model entitat‑relació del sistema, podrà respondre si cal fer canvis a la base de dades? Per què?


