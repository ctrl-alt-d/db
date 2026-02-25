# El model Entitat Inter-relació  - Introducció
## DAW-MP02-UF1 - Exercici de Introducció a les bases de dades
Al llibre 'Diseño de base de datos relacionales', els autors, Adoración de Miguel, Mario Piattini i Esperanza Marcos defineixen quines són les etapes del disseny:

* Món real: són les persones, animals i coses actors del món real que volem informatitzar.
* Univers de discurs: visió del món real sota uns determinats objectius.
* Modelat conceptual de dades: És una representació gràfica identificant entitats i relacions i en un llenguatge de símbols que els informàtics entenen de l'univers de discurs.
* Modelat lògic (base de dades): Concreció de model conceptual a un model convencional de base de dades (relacional, post relacional, ... )
* Modelat intern (estructures de dades): Estructures internes del sgbd ( taules, indexos, col·leccions, etc )
* Emmagatzematge físic: estructures físiques com ara fitxers de dades, de log, de control, de configuració, etc.

Tanmateix a mi m'agrada veure-ho com a quines són les concrecions del disseny, de més abstracte a més concret, de les idees als 0 i 1's.

**Exercici**

* Procura que et quedi clar que el model entitat inter-relació ens permet realitzar el Model Conceptual de Dades.
* Busca al diccionari que és un 'Model'. Intenta comprendre per què s'utilitza la paraula model al Model Conceptual de Dades. 
* Recorda que el model entitat inter-relació de vegades s'anomena *diagrama entitat inter-relació* degut a que s'utilitzen símbols per a la representació de les entitats i les inter-relacions.
* Fixa't en que la paraula *'relació'* no comparteix semàntica al model entitat inter-relació i al model relacional. Al primer fa referència a les relacions entre entitats i al segon fa referència a col·leccions de dades.
* En realitat el model entitat inter-relació es diu model entitat-relació. Però pel motiu esmentat al punt anterior li canviem el nom per no concondre. Busca els noms en anglès de: *'model relacional'* i *'model entitat inter-relació'*


# El model entitat inter-relació - Importància
## DAW-MP02-UF1 - Exercici de Introducció a les bases de dades
El model entitat inter-relació presenta l'esquema de dades de negoci en un format gràfic. 

És d'extrema importància saber construir i interpretar un diagrama entitat inter-relació per diferents motius:

* Igual que un músic sap llegir una partitura, un desenvolupador ha de saber llegir un model entitat inter-relació, allà troba amb detall totes les entitats del sistema i les seves interrelacions així com els atributs de totes elles.
* El model entitat inter-relació permet, amb molt poc temps, fer-se una idea de la complexitat d'un sistema informàtic, conèixer els principals elements i les limitacions i restriccions del mateix. És com un mapa de les dades.

**Exercici**

1. L'Orquestra de Girona contracta un pianista per a una audició, quan li passen la partitura del que haurà de tocar, el músic comenta 'jo no sé llegir una partitura' m'ho poden passar en mp3? Creus que aquest pot ser un cas real? per què? Ara adapta aquest microconte al sector informàtic. Adapta'l també al sector de la construcció.
2. Assignen un nou projecte a un desenvolupador, li comenten que l'aplicació ara mateix només pot emmagatzemar dels clients el telèfon fix, mòbil i e-mail, però que volen, a més, emmagatzemar el compte de twitter, instagram. A l'informàtic li passen el model entitat inter-relació del sistema informàtic i li demanen si cal fer canvis a la base de dades. Podrà l'informàtic amb aquesta informació resoldre la pregunta? Per què?


