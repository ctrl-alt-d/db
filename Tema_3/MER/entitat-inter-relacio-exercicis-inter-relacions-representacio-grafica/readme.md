# Entitat inter-relació - Exercicis inter-relacions representació gràfica
## DAW-MP02-UF1 - Exercici de Introducció a les bases de dades
Quan modelitzem el mon real seguim una série de concrecions fins a disposar de la base de dades ( i de la resta del sistema informàtic ):

1. Observació del **món real**.
1. Redacció de l'**Univers de Discurs**
1. Elaboració del **Model Conceptual de Dades** mitjançant el Diagrama Entitat Inter-relació.
1. Elaboració del **Model Lògic de les Dades**.
1. Elaboració del **Model Físic de les Dades**.
1. Implementació de la **base de dades**.

Els punts 3, 4 i 5 utilitzen ( o poden utilitzar ) diagrames. És important no confondre un diagrama per un altre. Aquí s'expliquen les principals caractarístiques que cal tenir en compte:

**Model Conceptual de Dades** Apareixen les entitats i les inter-relacions. A cada entitat només apareixen els **atributs propis d'aquella entitat** ( no apareixen altres atributs que es propaguen degut a les inter-relacions, tal com estudiarem més endavant )

![Imgur](http://i.imgur.com/Ik0JnYQ.png)

**Model Lògic de les Dades** Aquí s'estan representant relacions ( taules ) i inter-relacions entre les relacions però ara mitjançant **identificadors foranis** (fi1, fi2). Aquest diagrama ha de ser independent del SGBD que fem servir.

![Imgur](http://i.imgur.com/qBGcr95.png)

*Nota: per ara no cal entendre com funcionen els identificadors foranis, només estem posant en context el MCD*

**Model Físic de les Dades** És un nivell més de concreció del diagrama anterior. És depenent del SGBD. Apareixen els tipus de dades tal i com es defineixen als diferents SGBD del mercat i les **claus foranes** (fk1, fk2)

*Model Físic de les Dades Oracle:*
![Model Físic de les Dades Oracle](http://i.imgur.com/pDnhZkY.png)

*Model Físic de les Dades MS SQL Server:*
![Model Físic de les Dades MS SQL Server](http://i.imgur.com/gFhf5rq.png)

*Model Físic de les Dades MySQL:*
![Model Físic de les Dades MySQL](http://i.imgur.com/tXtBzBH.png)

*Nota: per ara no cal entendre com funcionen les claus foranes, tampoc cal saber quins tipus de dades suporten els diferents SGBD del mercat, tot això es veurà més endavant. Ara només estem posant en context el MCD*

**Exercici**

1. Comprova que tens clar la diferència entre Model Conceptual de Dades, Model Lògic de les Dades i Model Físic de les Dades.
1. Fixa't que el PDM (Physical Data Model) és diferent per a cada sistema gestor de base de dades, en que es diferencien?
2. En aquests exercicis, per a fer el diagrama entitat Inter-Relació, estem fent servir sempre la notació 'Crow Foot', però també hi ha la notació chen. Busca quins símbols fa servir aquesta darrera notació.
1. Comprova a la wikipedia, [Entity–relationship model](https://en.wikipedia.org/wiki/Entity%E2%80%93relationship_model), que hi ha diferents de notacions per al diagrama entitat inter-relació.
1. El següent model Enritat Inter-Relació fa servir la notació Barker. Explica la correspondència entre aqeusta notació i la crow foot.

![Barker's notation](http://i.imgur.com/LAHe4i4.png)

