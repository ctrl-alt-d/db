# Entitat inter-relació - Exercicis inter-relacions N:M
## DAW-MP02-UF1 - Exercici de Introducció a les bases de dades
**Exemple: univers de discurs**

*"Una **empresa** de manteniment de **piscines** vol una base de dades per controlar els **tractaments** efectuats. A cada piscina se li assigna un **codi** per diferenciar‑la (per exemple: piscina número 13). També emmagatzemem la **població** on es troba, l'**adreça**, els **metres cúbics**, el **nom del propietari** i un **telèfon de contacte**. Dels tractaments guardem la **data i l'hora** en què es realitza, el **codi del tècnic** que el realitza (per exemple: 'DH') i una **descripció del tractament**. Naturalment, volem saber a quina piscina s'ha realitzat cada tractament. Un mateix tècnic no pot fer dos tractaments al mateix temps; per això podem identificar un tractament respecte a un altre pels valors d'aquests atributs. Hi ha piscines a les quals encara no hem fet cap tractament; però sempre que fem un tractament cal indicar a quina piscina s'ha fet."*

*A més, es vol conèixer quins **productes** s'han utilitzat a cada tractament. Dels productes ens interessa el **nom comercial**, el **component actiu principal** i el seu **codi de barres**. Aquest darrer atribut és el valor que identifica unívocament cada producte. En un tractament es poden utilitzar diferents productes i un mateix producte es pot utilitzar en diferents tractaments. Pot ser que en un tractament no s'utilitzi cap producte; també pot haver-hi productes que mai no s'hagin fet servir en cap tractament."*

**Resolució exemple**

![Exemple inter-relació tipus de correspondència N:M](http://i.imgur.com/z3cKiqp.png)


**Exercici**

1. Identifica les inter-relacions de l'exemple. Digues de quin tipus de correspondència és cadascuna d'elles.
2. Donat el següent univers de discurs, fes el Model Conceptual de Dades mitjançant un Diagrama Entitat‑Relació:

	"Una **empresa** de transports té una flota de **vehicles**. Aquests s'identifiquen per la seva **matrícula**. També emmagatzemem el **model** i l'**any d'adquisició**. A aquests vehicles se'ls fan **revisions** periòdiques. A cada revisió anotem el **quilometratge** del vehicle i l'**estat** de conservació. També anotem les **inicials del tècnic** que fa la reparació i el **moment** en què l'ha fet. Per diferenciar una reparació s'utilitzen aquests darrers camps (per exemple: la reparació que va fer DH el 19 de juny de 2017 a les 10:15 h). A tots els vehicles se'ls fa revisió; per tant, sempre que es fa una revisió cal indicar quin vehicle es revisa. A banda, es vol saber quines **peces** es canvien a cada revisió; de cada peça emmagatzemem la seva **referència** (que és única), el seu **valor** i la quantitat d'**estoc** que tenim. A totes les revisions es canvia, com a mínim, l'aigua del neteja del parabrises. Pot ser que tinguem peces en estoc que mai no s'hagin fet servir a cap revisió."

