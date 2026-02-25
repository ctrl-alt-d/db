# El model Entitat Inter-relació - Inter-relacions
## DAW-MP02-UF1 - Exercici de Introducció a les bases de dades
**Inter-relacions, Introducció**

Inter-relació és la traducció que alguns autors utilitzen del vocable original amb anglès 'relationship'. Podriem usar simplement el vocable 'relació' i dir 'model entitat relació', però alguns alumnes tendeixen a confondre-ho amb el 'model relacional' que es veurà més endavant.

**Inter-relacions, Concepte**

Una inter-relació representa una associació, de l'univers de discurs, entre dues o més entitats. 

**Inter-relacions, Exemple**

Fixem-nos en aquest univers de discurs: 

*Una empresa té una base de dades amb els seves **seus** i els seus **empleats**. De les seus emmagatzemen el nom de la seu i data de la seva inaguració. Dels empleats s'emmagatzema el nom, número de la seguretat social i **seu allà on aquell empleat està assignat**.*

És la primera vegada que ens apareix una inter-relació. A primera vista, podriem pensar que, la seu on està ubicat un treballador és un atribut del treballador, però si ho analitzem bé, es tracta d'una relació entre les entitats **treballador** i **seu**, de manera que, cada treballador té **una** seu assignada i en una seu hi podem trobar **molts** treballadors. Per tant, és una inter-relació **1 a molts** ó també anomenada *Inter-relació amb tipus de correspondència 1:N*.

**Inter-relacions, Tipus de correspondència**

El tipus de correspondència ens informa sobre el número d'instàncies d'entitat que poden intervenir a la inter-relació.

* **Tipus de correspondència 1:N** 
    * Per a cada instància d'una entitat A trobem associades vàries instàncies de l'entitat B. Per a cada instància de l'entitat B només trobem associada una entitat A. 
    * Exemple: Un treballador està en una seu, en una seu hi ha molts treballadors.

![Tipus de correspondència 1:N](http://i.imgur.com/HAwalaQ.png)

* **Tipus de correspondència N:M** 
    * Per a cada instància d'una entitat A trobem associades vàries instàncies de l'entitat B. Per a cada instància de l'entitat B trobem vàries instàncies d'A. 
    * Exemple: Un mecànic intervé en moltes reparacions, en una reparació hi intervenen molts de mecànics.
    * Una inter-relació N:M pot tenir atributs, per exemple, quantes hores ha invertit el mecànic a la reparació. Es veurà més endavant com modelitzar aquest tipus de casuística.

![Tipus de correspondència N:M](http://i.imgur.com/zJV7wlC.png)

* **Tipus de correspondència 1:1** 
    * Per a cada instància d'una entitat A trobem una instància de B. Per a cada instància de B trobem una instància d'A. 
    * Exemple: Cada gos té assignada una gàbia. 

![Tipus de correspondència 1:1](http://i.imgur.com/Bn74qvI.png)

**Inter-relacions, Cardinalitat**

És una informació adicional al tipus de correspondència. Fixem-nos en l'exemple d'inter-relació amb tipus de correspondència 1:1. Quan diem que cada gos té assignada una gàbia, totes les gàbies tenen gos? Això ens ho respon la cardinalitat. El tipus de correspondència s'informa per al global de la inter-relació, la cardinalitat cal informar-la als dos extrems de la inter-relació. A l'exemple de gos, trobem que el tipus de correspondència és 1:1, però cal informar la cardinalitat de gos a gàbia i de gàbia a gos. Suposant que tots els gossos tenen gàbia, tindriem que de gos a gàbia la cardinalitat és (1,1), com a mínim una gàbia i com a màxim 1. En canvi, de gàbia a gos la cardinalitat podria ser (0,1), poden haver gàbies sense gos, però, si tenen gos, en tindran com a màxim 1.

* **Cardinalitat (1,1)** En aquest costat de la inter-relació trobarem sempre una entitat relacionada. 
* **Cardinalitat (0,1)** En aquest costat de la inter-relació ens podem trobar amb una entitat o pot ser que no n'hi hagi cap.
* **Cardinalitat (1,n)** En aquest costat de la inter-relació ens podem trobar amb una entitat o moltes.
* **Cardinalitat (0,n)** En aquest costat de la inter-relació ens podem trobar amb cap entitat o moltes.

![Cardinalitats](http://i.imgur.com/wZ4AbXh.png)

**Inter-relacions, Representació gràfica**

Per a fer la representació gràfica de les entitats i inter-relacions estem fent servir la notació 'crow foot'. Aquesta notació, a nivell empresarial, a deixat obsoleta la notació original de Chen. Això ha estat així perquè la nova notació és molt més pràctica i intuitiva a l'hora d'interpretar i plamar els models.

**Exercicis** 

* Busca una explicació a:
    * Per què aquesta notació es diu 'crow foot'.
    * Per què s'han triat cadascun d'aquests símbols per a les notacions dels tipus de correspondència i de les cardinalitats.
* Prepara't per sortir a la pissarra a dir que és una inter-relació al model entitat inter-relació i posar un exemple.
* Prepara't per sortir a la pissarra i posar un exemple d'inter-relació amb tipus de correspondència 1:N.
* Prepara't per sortir a la pissarra i posar un exemple d'inter-relació amb tipus de correspondència N:M.
* Prepara't per sortir a la pissarra i posar un exemple d'inter-relació amb tipus de correspondència 1:1.
* Prepara't per sortir a la pissarra i posar les cardinalitats als exemples dels teus companys.
* Recorda diferenciar aquests conceptes tant distants. Prepara't per sortir a la pissarra i explicar que és cadascun d'ells:
    * 'diagrama entitat inter-relació' (o 'model entitat inter-relació') és un recurs que utilitzem per a representar el 'model conceptual de dades'.
    * 'model relacional' és un paradigme de base de dades, una estructura de com estructurar les dades. En aquest cas les dades s'organitzen en 'relacions' ( relació de productes, relació de clients, etc) Això el diferencia d'altres sistemes pre-relacionals com el model jeràrquic i el model en xarxa o de models post relacionals com el model clau-valor o els models de col·leccions i documents.

