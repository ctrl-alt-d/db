# Entitat inter-relació - Exercicis inter-relacions N:M
## DAW-MP02-UF1 - Exercici de Introducció a les bases de dades
**Exemple univers de discurs**

*"Una **empresa** de manteniment de **piscines** vol una base de dades per tenir un control dels **tractaments** fets. A les piscines se'ls hi assigna un **codi** per poder-les diferenciar ( exemple: la piscina número 13 ) a més emmagatzemem la **població** allà on es troba, l'**adreça**, els **metres cúbics**, el **nom del propietari** i un **telèfon de contacte**. Dels tractaments emmagatzemem la **data i hora** en que es realitza el tractament, el **codi del tècnic** que realitza el tractament ( per exemple: 'DH' ) i una **explicació del tractament efectuat**. Naturalment també volem saber a quina piscina s'ha realitzat aquell tractament. Un mateix tècnic no pot fer dos tractaments a la vegada, per això, podem identificar un tractament respecte un altre amb els valors d'aquests dos atributs. Hi ha piscines que encara no els hem fet cap tractament, però, sempre que fem un tractament cal indicar a quina piscina s'ha fet.*

*A banda, es vol conèixer quins **productes** s'han fet servir a cada tractament. Dels productes ens interessa el **nom comercial**, el principal **component actiu** i el seu **codi de barres**. Aquest darrer atribut, el codi de barres, és el valor que ens permet identificar unívocament cada producte. En un tractament es poden fer servir diferents productes i un mateix producte es pot fer servir en diferents tractaments. Pot ser que en un tractament no fem servir cap producte. Pot ser que hi hagi productes que mai no s'hagin fet servir a cap tractament.*

**Resolució exemple**

![Exemple inter-relació tipus de correspondència N:M](http://i.imgur.com/z3cKiqp.png)


**Exercici**

1. Identifica les inter-relacions de l'exemple. Digues de quin tipus de correspondència és cadascuna d'elles.
2. Donat el següent univers de discurs es el Model Conceptual de Dades mitjançant un Diagrama Entitat Inter-Relació. *"Una **empresa** de transports té una flota de **vehícles**. Aquests s'identifiquen per la seva **matrícula**. També emmagatzemem el **model** i l'**any d'aquisició**. A aquests vehícles se'ls fa **revisions** periòdiques. A cada revisió anotem el **quilometratge** del vehícle i l'**estat** de conservació. També anotem les **inicials del tècnic** que fa la reparació i el **moment** en que l'ha fet. Per diferenciar una reparació s'utilitzen aquests darrers camps ( Exemple: la raparació que va fer DH el dia 19 juny 2017 a les 10:15h ). A tots els vehicles se'ls fa revisió, perquè només de comprar-lo ja els fem una revisió. Sempre que es fa una revisió cal indicar quin vehícle es revisa. A banda, es vol saber quines **peces** es canviien a cada revisió, de les peces emmagatzemem la seva **referència** ( que és única per a cada peça), el seu **valor** i la quantitat d'**estoc** que tenim. A totes les revisions canviem, com a mínim, l'aigua del neteja parabrises. Pot ser que tinguem peces en estoc que mai no hem fet servir a cap revisió."*

