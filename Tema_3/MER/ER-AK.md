# Entitat inter-relació - Exercicis Atributs Identificadors Candidats
## DAW-MP02-UF1 - Exercici de Introducció a les bases de dades
Cada entitat al menys ha de tenir un [Atribut Identificador Principal](/DAW/DAW-MP02/DAW-MP02-UF1/el-model-entitat-inter-relacio-conceptes/readme.md). Però pot ser que a l'hora de buscar-lo en trobem d'altres que també ens serveixin. Finalment n'haurem de triar un que serà el principal. Però el model conceptual de dades ens diu que cal informar també quins són els altres atributs identificadors que hem descartat. Són els atributs identificadors alternatius.

Suposem el seguent univers de discurs: 

*En un institut cal emmagatzemar a la base de dades les dades dels professors. Cada professor té un codi assignat que és el que el cap d'estudis utilitza per fer horaris, etc. Per exemple el professor Ramon Pérez d'ADministratiu té el codi ADRP. A més emmagatzemem el DNI, el nom complet, el correu electrònic de l'XTEC (ex: rperez999@xtec.cat ) i la data de neixement.* 

En aquest cas identifiquem **professor** com a entitat i les altres dades com atributs de professor. I ens fixem que hi ha un munt d'atributs identificadors candidats: les inicials, el DNI, el correu electrònic, el nom complet. En triem un de principal i els altres seran alternatius:

![Atribut Identificador Candidat](http://i.imgur.com/HDAqNll.png)

**Exercici**

1) Fes el MCD d'aquest univers de discurs:

*Un taller mecànic vol una base de dades dels seus mecànics. Emmagatzemen els següents camps: Especialitat (exemple: neumàtics ), Data incorporació a l'empresa, Número de treballador al llibre de treballadors de l'empresa, número de la seguretat social, dni, número de telèfon mòbil, nom i cognoms.*

2) Fes el MCD d'aquest univers de discurs:

*Una web d'internet desitja emmagatzemar usuaris. Les dades a emmagatzemar són: el 'usuari' per entrar a la web. L'email d'aquest usuari. La password ( naturalment una hash de la password ). Data de neixement. Nom complert. Nacionalitat ( codi Iso de dues lletres del seu pais, ex: BR ). I la data de la darrera connexió.*

3) Fes el MCD d'aquest univers de discurs:

*Una empresa té diferents delegacions. S'emmagatzema l'adreça que són els camps: carrer i número, porta, CP. També la provincia i la ciutat. Cada cop que s'obre una delegació nova en una ciutat se li posa un número començant per 1. Tenim per exemple: Barcelona 1, Barcelona 2 i Barcelona 3 i també Bellcaire 1 i Albons 1. Els treballadors estan acostumats a identificar les delegacions d'aquesta manera. També podrien identificar-les per la longitud i latitud que també es guarda a la base de dades, però no sembla tant pràctic.*

Ves amb compte, en aquest exercici els atributs identificadors són compostos.


