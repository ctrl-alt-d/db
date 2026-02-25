# Entitat inter-relació - Exercicis inter-relacions 1:N
## Exercici de Introducció a les bases de dades
**Exemple: univers de discurs**

*"Una **empresa** de manteniment de **piscines** vol una base de dades per controlar els **tractaments** efectuats. A cada piscina se li assigna un **codi** per diferenciar‑la (per exemple: piscina número 13). També emmagatzemem la **població** on es troba, l'**adreça**, els **metres cúbics**, el **nom del propietari** i un **telèfon de contacte**. Dels tractaments guardem la **data i l'hora** en què es realitza el tractament, el **codi del tècnic** que l'executa (per exemple: 'DH') i una **descripció del tractament**. Naturalment també volem saber a quina piscina s'ha realitzat cada tractament. Un mateix tècnic no pot fer dos tractaments al mateix temps; per això podem identificar un tractament respecte a un altre pels valors d'aquests atributs. Hi ha piscines a les quals encara no hem fet cap tractament; però sempre que fem un tractament cal indicar a quina piscina s'ha fet."*

**Exemple de resolució**

![Exemple inter-relació 1:N Model Conceptual de Dades](http://i.imgur.com/c7UKEXP.png)

*Nota: recorda que cada entitat té **un** atribut identificador principal; en el nostre cas, per a l'entitat Tractament l'AIP està format per dos atributs.*

**Exercici**

1. Explica per què a l'exemple anterior no hem inclòs **empresa** com a entitat.
2. Digues quin tipus de correspondència hi ha entre les dues entitats de l'exercici anterior.
3. Digues quin tipus de cardinalitat apareix a cada extrem de la interrelació de l'exemple anterior.
4. Donat el següent univers de discurs, fes el model conceptual de dades mitjançant un diagrama entitat‑relació:

	"Una **empresa** de transports té una flota de **vehicles**. Aquests s'identifiquen per la seva **matrícula**. També emmagatzemem el **model** i l'**any d'adquisició**. A aquests vehicles se'ls fa **revisions** periòdiques. A cada revisió anotem el **quilometratge** del vehicle i l'**estat** de conservació. També anotem les **inicials del tècnic** que fa la reparació i el **moment** en què l'ha fet. Per diferenciar una reparació s'utilitzen aquests darrers camps (per exemple: la reparació que va fer DH el 19 de juny de 2017 a les 10:15 h). A tots els vehicles se'ls fa revisió; per tant, sempre que es fa una revisió cal indicar quin vehicle es revisa."

5. Comprova que no has inclòs **empresa** al MCD.
6. Comprova que la cardinalitat d'aquest exercici és diferent de la cardinalitat de l'exemple.
7. Digues quants atributs identificadors principals (AIP) té cadascuna de les dues entitats que apareixen a la resolució de l'exercici.


