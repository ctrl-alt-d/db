# Entitat inter-relació - Exercicis inter-relacions 1:N
## DAW-MP02-UF1 - Exercici de Introducció a les bases de dades
**Exemple univers de discurs**

*"Una **empresa** de manteniment de **piscines** vol una base de dades per tenir un control dels **tractaments** fets. A les piscines se'ls hi assigna un **codi** per poder-les diferenciar ( exemple: la piscina número 13 ) a més emmagatzemem la **població** allà on es troba, l'**adreça**, els **metres cúbics**, el **nom del propietari** i un **telèfon de contacte**. Dels tractaments emmagatzemem la **data i hora** en que es realitza el tractament, el **codi del tècnic** que realitza el tractament ( per exemple: 'DH' ) i una **explicació del tractament efectuat**. Naturalment també volem saber a quina piscina s'ha realitzat aquell tractament. Un mateix tècnic no pot fer dos tractaments a la vegada, per això, podem identificar un tractament respecte un altre amb els valors d'aquests dos atributs. Hi ha piscines que encara no els hem fet cap tractament, però, sempre que fem un tractament cal indicar a quina piscina s'ha fet."*

**Exemple de resolució**

![Exemple inter-relació 1:N Model Conceptual de Dades](http://i.imgur.com/c7UKEXP.png)

*Nota: recorda que cada entitat té **un** atribut identificador principal, al nostre cas, per a l'entitat Tractament, l'AIP està format per dos atributs.*

**Exercici**

1. Explica per què a l'exemple anterior no hem inclòs **empresa** com a entitat.
2. Digues quin tipus de correspondència hi ha entre les dues entitats de l'exercici anterior.
2. Digues quin tipus de cardinalitat apareix a cada extrem de la inter-relació de l'exemple anterior.
3. Donat el següent univers de discurs fes el Model Conceptual de Dades mitjançant un Diagrama Entitat Inter-Relació. *"Una **empresa** de transports té una flota de **vehícles**. Aquests s'identifiquen per la seva **matrícula**. També emmagatzemem el **model** i l'**any d'aquisició**. A aquests vehícles se'ls fa **revisions** periòdiques. A cada revisió anotem el **quilometratge** del vehícle i l'**estat** de conservació. També anotem les **inicials del tècnic** que fa la reparació i el **moment** en que l'ha fet. Per diferenciar una reparació s'utilitzen aquests darrers camps ( Exemple: la raparació que va fer DH el dia 19 juny 2017 a les 10:15h ). A tots els vehicles se'ls fa revisió, perquè només de comprar-lo ja els fem una revisió. Sempre que es fa una revisió cal indicar quin vehícle es revisa."*
4. Comprova que no has inclòs **empresa** al MCD.
5. Comprova que la cardinalitat d'aquest exercici és diferent de la cardinalitat de l'exemple.
6. Digues quants AIPs ( Atributs Identificadors Principals ) tenen cadascuna de les dues entitats que apareixen a la resolució de l'exercici.


