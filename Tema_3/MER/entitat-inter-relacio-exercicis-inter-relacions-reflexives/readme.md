# Entitat inter-relació - Exercicis inter-relacions reflexives
## DAW-MP02-UF1 - Exercici de Introducció a les bases de dades
**Concepte**

Una entitat pot estar **inter-relacionada amb ella mateixa** amb qualsevol tipus de correspondència. 

**Exemple inter-relació reflexiva amb tipus de correspondència 1:N**

*"A una empresa on els treballadors tenen un cap. Un treballador pot ser cap d'altres treballadors. Un treballador té com a màxim un cap."* 

El diagrama entitat inter-relació seria el següent:

![Inter-relacions reflexives](http://i.imgur.com/0XEZSa9.png)

**Exemple inter-relació reflexiva amb tipus de correspondència N:M sense atributs**

*Una xarxa social permet fer *amics*. De manera que un usuari pot fer sol·licitud d'amistad amb altres usuaris i aquests acceptar-la o no. Un usuari sol·licita amistat a entre o i n usuaris. Un usuari rep sol·licitud d'amistat d'entre 0 i n usuaris.*

![Inter-relació N:M sense atributs](http://i.imgur.com/ne5lPd2.png)

**Exemple inter-relació reflexiva amb tipus de correspondència N:M amb atributs**

*Una xarxa social permet fer *amics*. De manera que un usuari pot fer sol·licitud d'amistad amb altres usuaris i aquests acceptar-la o no. Un usuari sol·licita amistat a entre o i n usuaris. Un usuari rep sol·licitud d'amistat d'entre 0 i n usuaris. De cada sol·licitud ens interesa conèixer la data en que es va realitzar i la data d'acceptació o rebuig.*

![Inter-relació N:M amb atributs](http://i.imgur.com/x1sxX30.png)

*Nota: cal fixar-se que la notació del tipus de correspondència 1:N és lleugerament diferent, és degut a que l'entitat **sol·licitud** és dèbil i necessita de les entitats relacionades per identificar unívocament instàncies d'aquesta entitat*

**Exercici** 

Fes el MCD (model conceptual de dades) del segúent Univers de Discurs:

1) *Una xarxa social a Internet permet que els seus usuaris convidin a amics que encara no hi són. Això ho fan enviant un enllaç amb una invitació. Si l'amic fa clic a la invitació i s'hi subscriu, llavors, a la base de dades queda emmagatzemat l'alta del nou usuari i també quin usuari l'ha convidat ( quin usuari li havia enviat la invitació ). En aquest exercici ens centre en els usuaris, volem el MCD dels usuaris amb la relació de qui els ha convidat. De manera que: Un usuari és convidat per 0 ó 1 usuaris. Un usuari convida entre 0 i n usuaris.*

2) *Una emprsa de catering ofereix mejars (ex: ració patates fregides, hamburguesa extra pollastre, amanida Cesar, gelat colaget, etc ) Cada menjar té el nom, un codi que l'identifica i la seva quantitat (ex: 100 grams, 2 litres, etc). Tanmateix hi ha menjars que estan formats per altres menjars ( per exemple: menú MkAuto està format per  ració de patates fregides + hamburguesa extra pollastre). Resumint: un menjar pot formar part d'entre 0 i n altres menjars.*

3) *Una emprsa de catering ofereix mejars (ex: ració patates fregides, hamburguesa extra pollastre, amanida Cesar, gelat colaget, etc ) Cada menjar té el nom, un codi que l'identifica i la seva quantitat (ex: 100 grams, 2 litres, etc). Tanmateix hi ha menjars que estan formats per altres menjars ( per exemple: menú MkAuto està format per  **dues** racions de patates fregides + una hamburguesa extra pollastre). Resumint: un menjar pot formar part d'entre 0 i n altres menjars **amb diferents quantitats**.*


