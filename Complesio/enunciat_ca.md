# Enunciat

Fes el problema 8 de https://users.dcc.uchile.cl/~mnmonsal/BD/guias/g-modeloER.pdf

Es vol crear un lloc web amb informació sobre les pel·lícules en cartell a les sales d'un dubtós cinema proper a la plaça d'armes. Per a cadascuna de les pel·lícules es guarda una fitxa amb la informació següent:

- títol de distribució
- títol original
- gènere
- idioma original
- si té subtítols en espanyol o no
- països d'origen
- any de producció
- URL del lloc web de la pel·lícula
- durada (un enter que representi la durada total en minuts)
- classificació (Apta per a tot públic, +9 anys, +15 anys, +18 anys)
- data d'estrena a Santiago
- un resum
- un identificador de la pel·lícula

De cada pel·lícula interessa conèixer la llista de directors i el repartiment; per a cada actor que hi treballa es vol saber el nom de tots els personatges que interpreta. També es vol disposar d'informació sobre els directors i els actors que participen en cada pel·lícula. Per ambdues categories de persones es coneix el seu nom (que els identifica) i la seva nacionalitat. A més, es vol saber la quantitat de pel·lícules en les quals han dirigit o han actuat. Tingueu en compte que hi ha persones que exerceixen ambdós papers (actor i director).

Els cinemes poden tenir més d'una sala i cada setmana cada cinema envia la cartellera per a aquesta setmana, indicant el detall de les funcions. Per a cada funció es coneix el dia de la setmana i l'hora d'inici, i òbviament la sala i la pel·lícula que s'hi projecta. De cada sala es sap el nom, un número que l'identifica dins del cinema i la quantitat de butaques que té. De cada cinema es coneix el nom (que l'identifica), l'adreça i el telèfon per a consultes.

Alguns cinemes ofereixen promocions. Aquestes promocions depenen de la funció (per exemple: de dilluns a dijous, abans de les 18:00, 50% de descompte a la sala X del cinema Y per a la pel·lícula Z; o la funció del dilluns a les 14:00 per a la pel·lícula T en la sala S no es cobra als escolars amb túnica...). Per a cada promoció es coneix una descripció i el percentatge o valor del descompte que aplica.

A més del resum que s'inclou a la fitxa de la pel·lícula, és interessant mostrar l'opinió de les persones que han vist la pel·lícula. De cada opinió es coneix el nom de la persona que la fa, la seva edat, la data en què va registrar l'opinió, la qualificació que va donar a la pel·lícula (Obra Mestra, Molt Bona, Bona, Regular, Dolenta) i el comentari pròpiament dit. A cada opinió se li assigna un número que l'identifica respecte de la pel·lícula sobre la qual opina.

Treball a realitzar:

1. Dissenya el model conceptual de dades (MCD / model conceptual de dades). Cal usar eina PowerDesigner o similar. Preferiblement notació crow's foot. Cal que apareguin els tipus de dades, els AIP, els camps mandatory i les cardinalitats.
   1.1 https://help.sap.com/docs/SAP_POWERDESIGNER/856348b84a7c479489d5172a630f014d/c7c2fc096e1b101482f8b74517facb85.html?locale=en-US
2. Crea les taules corresponents (model físic i implementació SQL). Cal que apareguin els tipus de dades, les claus primàries, les claus foranes, les restriccions de nul·litat.
   2.1. PDM: https://help.sap.com/docs/SAP_POWERDESIGNER/856348b84a7c479489d5172a630f014d/c7c476516e1b1014aab4c4ec2e33848f.html?locale=en-US
3. Crea els indexos que consideris oportuns per a les consultes habituals.
4. Insereix dades a totes les taules (catàleg mínim per provar consultes).
5. Modifica algunes dades (update).
6. Esborra algunes dades (delete).
7. Prepara l'enunciat de les consultes i fes almenys 2 consultes de cadascuna de les categories següents (o amb exemples equivalents):
	- ORDER BY
	- JOIN
	- WHERE
	- Funcions d'una sola filera (per exemple, concatenacions, funcions de data, conversions)
	- GROUP BY
	- HAVING (exemple: pel·lícules amb més de dues opinions amb qualificació 'Molt Bona')
8. Prepara la consulta: Películes que duren més de la mitjana de durada de totes les pel·lícules.
9. Pregunta teórica: Es vol una estadística de les pel·lícules amb el nombre de valoracions. Quin serà el millor nivell d'aïllament si els nombres de l'estadística poden ser aproximats? Argumenta la resposta.
10. Pregunta teòrica: Aquest sistema és una mena de xarxa social. Ens interessa que la gent hi passi allà el màxim de temps possible. No importa gaire si mostra informació lleugerament obsoleta. Del teorema CAP, quines propietats (Consistència, Disponibilitat, Tolerància a particions) serien més importants en aquest cas? Argumenta la resposta.

Indicacions addicionals i punts a considerar:

- Penseu en com modelar les relacions many-to-many (per exemple, pel·lícules i actors, pel·lícules i directors, actors que interpreten múltiples personatges en la mateixa pel·lícula).
- Teniu en compte la identitat de persones que poden aparèixer com a actors i com a directors (mateixa entitat amb rols o entitats separades segons disseny).
- Considereu restriccions d'integritat relacional (claus primàries, claus foranes, restriccions de nul·litat, valors per defecte) i possibles indexos per a consultes habituals.
- Per a la part de concurrència i aïllament, justifiqueu l'elecció (READ UNCOMMITTED, READ COMMITTED, REPEATABLE READ, SERIALIZABLE) i les implicacions sobre consistència i rendiment.

Entregables:

S'entregarà un pdf amb tot el que es demana. S'entregarà, a més, un zip amb els fitxers del PowerDesigner (o eina similar) i un fitxer .sql amb totes les instruccions SQL per crear les taules, inserir, modificar i esborrar dades, i les consultes.


Bona feina!

