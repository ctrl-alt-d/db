# El model entitat‑relació — Interrelacions
## Exercici: interrelacions

Una interrelació (relationship) representa una associació, en l'univers de discurs, entre dues o més entitats.

Exemple: una empresa manté una base de dades amb informació sobre les seves seus i els seus empleats. De cada seu es vol emmagatzemar, per exemple, el nom i la data d'inauguració. Dels empleats ens interessen el nom, el número de la seguretat social i la seu a la qual estan assignats.

A priori podríem pensar que la seu és un atribut del treballador; però si analitzem la informació (si la seu té més atributs, si una mateixa seu té molts empleats, etc.), és més adequat modelar la seu com una entitat i la relació entre empleat i seu com una interrelació 1:N: cada empleat està assignat a una seu i en una seu hi poden haver molts empleats.

Tipus de correspondència

- Tipus 1:N — Per cada instància d'una entitat A hi pot haver diverses instàncies de l'entitat B; per cada instància de B només hi ha una instància d'A. Exemple: un treballador està assignat a una seu; en una seu hi ha molts treballadors.

    ![Tipus de correspondència 1:N](http://i.imgur.com/HAwalaQ.png)

- Tipus N:M — Per cada instància d'A hi pot haver diverses instàncies de B i viceversa. Exemple: un mecànic pot intervenir en moltes reparacions i una reparació pot tenir la intervenció de diversos mecànics. Una interrelació N:M pot tenir atributs propis (per exemple, hores treballades) i sol modelitzar‑se com una entitat auxiliar en la traducció al model relacional.

    ![Tipus de correspondència N:M](http://i.imgur.com/zJV7wlC.png)

- Tipus 1:1 — Cada instància d'A s'associa com a màxim a una instància de B i viceversa. Exemple: cada gos pot tenir assignada una gàbia.

    ![Tipus de correspondència 1:1](http://i.imgur.com/Bn74qvI.png)

Cardinalitat

La cardinalitat informa, a cada extrem de la relació, els límits mínim i màxim de participació d'una entitat en la interrelació. Per exemple, en una relació 1:1 podem indicar que de gos a gàbia la cardinalitat és (1,1) (cada gos té obligatòriament una gàbia) i de gàbia a gos (0,1) (hi pot haver gàbies buides).

- Cardinalitat (1,1): la participació és obligatòria i com a màxim 1.
- Cardinalitat (0,1): la participació és opcional i com a màxim 1.
- Cardinalitat (1,n): la participació és obligatòria i pot ser moltes.
- Cardinalitat (0,n): la participació és opcional i pot ser moltes.

![Cardinalitats](http://i.imgur.com/wZ4AbXh.png)

Representació gràfica

En aquest temari fem servir la notació Crow's foot (peu de corb). Aquesta notació s'ha imposat en l'àmbit empresarial per la seva claredat i facilitat d'interpretació en comparació amb la notació original de Chen.

Exercicis

* Cerca per què aquesta notació rep el nom de 'crow foot' i per què s'han triat aquests símbols per representar tipus de correspondència i cardinalitats.
* Prepara exemples per explicar a la classe: una interrelació 1:N, una N:M i una 1:1, i marca les cardinalitats en cada cas.
* Explica la diferència conceptual entre 'diagrama entitat‑relació' (model conceptual) i 'model relacional' (estructura de dades en forma de taules o relacions).


