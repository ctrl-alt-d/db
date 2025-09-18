# Base de dades distribuida - Teorema CAP

En informàtica teòrica, el teorema CAP, també conegut com a teorema de Brewer, formula que és impossible garantir simultàniament les tres característiques següents en una aplicació distribuïda: 

* **Consistència** tots els nodes veuen la mateixa dada al mateix temps
* **Disponibilitat** Cada sol·licitud rebuda per un node que no falla en el sistema ha de resultar en una resposta. Aquesta és la definició de disponibilitat en el teorema CAP tal com la defineixen Gilbert i Lynch. Cal tenir en compte que la disponibilitat tal com es defineix en el teorema CAP és diferent de l'alta disponibilitat en l'arquitectura de programari.
* **Tolerància** El sistema continua funcionant malgrat que es perdin (o es retardin) un nombre arbitrari de missatges per part de la xarxa entre nodes.


[![YouTube Logo](https://upload.wikimedia.org/wikipedia/commons/b/b8/YouTube_Logo_2017.svg)](https://youtu.be/BHqjEjzAicA?si=v90qZabd8KHwPKjU)


## Exemples d'aplicabilitat

### 1. AP (Disponibilitat i Tolerància a particions)

- **Aplicació tipus: Xarxa social tipus Instagram o TikTok**
  - **Justificació:** En aquestes aplicacions, és essencial que els usuaris puguin accedir al contingut (com veure reels o vídeos) i pujar-ne de nous, fins i tot si hi ha inconsistències temporals en les dades. El sistema prioritza que els usuaris puguin interactuar amb el contingut en tot moment (disponibilitat) i seguir funcionant durant falles de la xarxa (tolerància a particions), encara que això signifiqui que els continguts nous puguin no estar disponibles a tots els usuaris immediatament. Així, la consistència temporalment pot quedar en segon pla en benefici de la disponibilitat contínua.

### 2. CP (Consistència i Tolerància a particions)

- **Aplicació tipus: Sistema de votació en línia**
  - **Justificació:** En un sistema de votació en línia, és fonamental garantir que cada vot es compti una sola vegada i que no hi hagi inconsistències entre els nodes. Per exemple, si es produeix una interrupció a la xarxa (partició), és preferible que el sistema esperi a resoldre la connexió i assegurar-se que els vots siguin processats de manera coherent abans de continuar acceptant nous vots. La disponibilitat es pot sacrificar temporalment per garantir que els resultats de la votació siguin precisos i consistents, sobretot en processos democràtics on l'exactitud és prioritària.

### 3. CA (Consistència i Disponibilitat)

- **Aplicació tipus: Sistema de gestió d'inventari en temps real (exemple: botiga en línia com Amazon)**
  - **Justificació:** En aquest cas, és important que el sistema sigui consistent i disponible. Si un client compra un producte, l'inventari s'ha d'actualitzar de manera immediata i consistent perquè altres clients no comprin un producte que ja no està disponible. No obstant això, aquest tipus de sistema tendeix a no ser tolerant a les particions: si hi ha una partició de xarxa, el sistema podria deixar de funcionar temporalment per evitar inconsistències en les dades de l'inventari. La consistència i disponibilitat són prioritàries en aquest tipus d'aplicació.
