# Entitat inter-relació — Exercicis: representació gràfica
## DAW‑MP02‑UF1 — Exercici: introducció a les bases de dades

Quan modelitzem el món real seguim una sèrie de concrecions fins a disposar de la base de dades (i de la resta del sistema informàtic):

1. Observació del **món real**.
2. Redacció de l'**univers de discurs**.
3. Elaboració del **model conceptual de dades** mitjançant el diagrama entitat‑relació.
4. Elaboració del **model lògic de dades**.
5. Elaboració del **model físic de dades**.
6. Implementació de la **base de dades**.

Els punts 3, 4 i 5 utilitzen (o poden utilitzar) diagrames. És important no confondre un diagrama amb un altre. A continuació s'expliquen les principals característiques que cal tenir en compte:

**Model conceptual de dades**

Apareixen les entitats i les interrelacions. A cada entitat només hi figuren els **atributs propis d'aquella entitat** (no hi apareixen altres atributs que es propaguen a través de les interrelacions; ho estudiem més endavant).

![Entitats i atributs](http://i.imgur.com/Ik0JnYQ.png)

**Model lògic de dades**

Aquí es representen relacions (taules) i les seves interrelacions mitjançant **identificadors forans** (per exemple, fk1, fk2). Aquest diagrama ha de ser independent del SGBD que utilitzem.

![Model lògic](http://i.imgur.com/qBGcr95.png)

*Nota: per ara no cal entendre en detall les claus foranes ni els tipus de dades específics dels SGBD; tot això es veurà més endavant. Ara només posem en context el MCD.*

**Model físic de dades**

És un nivell més de concreció del diagrama anterior i depèn del SGBD. Apareixen els tipus de dades tal com els defineixen els diferents SGBD del mercat i les **claus foranes** (fk1, fk2).

*Model físic de dades (Oracle):*

![Model Físic de les Dades Oracle](http://i.imgur.com/pDnhZkY.png)

*Model físic de dades (MS SQL Server):*

![Model Físic de les Dades MS SQL Server](http://i.imgur.com/gFhf5rq.png)

*Model físic de dades (MySQL):*

![Model Físic de les Dades MySQL](http://i.imgur.com/tXtBzBH.png)

**Exercici**

1. Comprova que tens clara la diferència entre model conceptual de dades, model lògic de dades i model físic de dades.
2. Fixa't que el PDM (Physical Data Model) és diferent per a cada sistema gestor de base de dades: en què es diferencien?
3. Per a fer el diagrama entitat‑relació utilitzem la notació Crow's foot; també existeix la notació Chen. Cerca quins símbols fa servir aquesta darrera notació.
4. Consulta la Wikipedia: [Entity–relationship model](https://en.wikipedia.org/wiki/Entity%E2%80%93relationship_model) per veure les diferents notacions per al diagrama entitat‑relació.
5. El següent model entitat‑relació fa servir la notació Barker. Explica la correspondència entre aquesta notació i la Crow's foot.

![Barker's notation](http://i.imgur.com/LAHe4i4.png)
