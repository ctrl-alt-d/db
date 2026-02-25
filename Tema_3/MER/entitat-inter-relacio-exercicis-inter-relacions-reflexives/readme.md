# Entitat inter-relació — Exercicis: interrelacions reflexives
## DAW‑MP02‑UF1 — Exercici: introducció a les bases de dades

**Concepte**

Una entitat pot estar **interrelacionada amb ella mateixa** amb qualsevol tipus de correspondència.

**Exemple: interrelació reflexiva amb tipus de correspondència 1:N**

"En una empresa, els treballadors tenen un cap. Un treballador pot ser cap d'altres treballadors i cada treballador té, com a màxim, un cap."

El diagrama entitat‑relació seria el següent:

![Interrelacions reflexives](http://i.imgur.com/0XEZSa9.png)

**Exemple: interrelació reflexiva amb tipus de correspondència N:M (sense atributs)**

"Una xarxa social permet establir amistats. Un usuari pot sol·licitar amistat a altres usuaris, i aquests poden acceptar o rebutjar la petició. Un usuari pot sol·licitar amistat entre 0 i n usuaris i pot rebre sol·licituds entre 0 i n usuaris."

![Interrelació N:M sense atributs](http://i.imgur.com/ne5lPd2.png)

**Exemple: interrelació reflexiva amb tipus de correspondència N:M (amb atributs)**

"En la mateixa xarxa social, de cada sol·licitud d'amistat ens interessa conèixer la data en què es va enviar la sol·licitud i la data d'acceptació o de rebuig."

![Interrelació N:M amb atributs](http://i.imgur.com/x1sxX30.png)

*Nota: cal fixar-se que la notació del tipus de correspondència 1:N és lleugerament diferent quan l'entitat intermèdia és dèbil i necessita les entitats relacionades per identificar unívocament les seves instàncies.*

**Exercici**

Fes el MCD (model conceptual de dades) del següent univers de discurs:

1. "Una xarxa social a Internet permet que els seus usuaris convidin amics que encara no hi són. Això es fa enviant un enllaç amb una invitació. Si l'amic fa clic a la invitació i s'hi subscriu, la base de dades registra l'alta del nou usuari i quin usuari l'ha convidat. En aquest exercici ens centrem en els usuaris: volem el MCD dels usuaris amb la relació de qui els ha convidat. Així, un usuari és convidat per 0 o 1 usuaris i un usuari convida entre 0 i n usuaris."

2. "Una empresa de càtering ofereix menjars (ex.: ració de patates fregides, hamburguesa amb extra de pollastre, amanida César, gelat, etc.). Cada menjar té un nom, un codi identificador i una quantitat (ex.: 100 grams, 2 litres). Alguns menjars estan formats per altres menjars (per exemple: el menú MkAuto està format per una ració de patates fregides i una hamburguesa amb extra de pollastre). En resum: un menjar pot formar part d'entre 0 i n altres menjars."

3. "Variante del cas anterior: un mateix menjar pot aparèixer amb diferents quantitats en altres menjars (per exemple: dues racions de patates fregides més una hamburguesa). En aquest cas, un menjar pot formar part d'entre 0 i n altres menjars amb quantitats diferents."
