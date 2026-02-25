# Entitat inter-relació - Problema: La lligueta
## Exercici de Introducció a les bases de dades
**Introducció**

Problema força tècnic amb dobles inter-relacions entre entitats, apareix inter-relació 1:1. Important determinar entitats febles i les seves dependències en identificació. Hi trobaràs 8 entitats amb 12 inter-relacions.

**Univers de Discurs**

Carles Pérez treballa a l'empresa Guaita-que-fan-ara-SA. Amb els seus companys de feina juguen a futbito a l'equip de l'empresa. L'equip competeix contra altres equips d'altres empreses. En total són uns 8 equips. De cares a la temporada vinent han decidit fer una app per gestionar partits i resultats. Per ara cal dissenyar la base de dades.

En Carles explica que a la base de dades es posaran els jugadors, empreses i els espais on juguen els partits. També quins partits es celebraran i horaris.  En Carles ens diu que hi ha una empresa molt grossa que té dos equips i que hi ha un equip de jubilats ( que no tenen empresa ).

Com que són pocs equips pensen que faran una liguilla. Jugaran tots contra tots, anada i tornada. Es considera equip local el que tria el camp.

No hi ha àrbitres ni tampoc cal emmagatzemar l'acta del partit.

La base de dades contindrà doncs les temporades ( identificador i comentaris, ex: 2015-16, "8a temporada de la lliga inter-empreses" ), els jugadors (amb número whatsapp. Els jugadors seran els usuaris de la App, el número de telèfon whatsapp farà les funcions de username ), les empreses ( nom, adreça ), els equips ( de quina empresa són, jugador capità actual, nom equip ), espais per jugar ( nom, localització, dades de contacte per fer les reserves, anotacions com el preu, etc), els partits ( equip local i visitant que juntament amb la temporada fan d'atribut identificador principal, lloc on es disputarà, data i hora). Gols ( qui fa el gol, a quin partit, per a quin equip, en quin minut de partit. Es considera que no es poden fer dos gols en el mateix minut de partit.)

No cal cap històric de quins jugadors han jugat cada partit o a quines empreses han estat. Ens interessa només la foto actual del sistema.

L'app tindrà un sistema de missatgeria. S'enviaran missatges amb subject i contingut des de un usuari a altres usuaris ja sigui per anunciar partits, resultats o el que sigui. La data-hora del missatge forma part de l'AIP, representa que un mateix usuari no pot enviar dos missatges al mateix moment.


**Exercici**

* A partir de l'Univers de Discurs fel el Model Conceptual de dades mitjançant el diagrama ER.
* Posa un contraexemple que demostri que no és suficient amb equip local + temporada per a identificar un partit. Quin AIC podriem trobar a Partit?

