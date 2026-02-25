## [El consorci sanitari. By Joan Queralt](https://gitlab.com/joanq/DAM-M2-BasesDeDades/-/blob/master/UF1/2-model_ER/activitats/sanitat.adoc)

Es vol dissenyar una base de dades que servirà per gestionar alguns dels
aspectes del funcionament d’un conjunt d’hospitals.


Els hospitals s’identifiquen per un codi. A més del codi hem de conèixer el seu
nom, l’adreça, un telèfon i el nombre total de llits de què disposa.


Dins de cada hospital hi ha una sèrie de sales d’hospitalització. Cada sala
s’identifica per un codi dins de cada hospital. Això vol dir que no es
repetiran els codis de sala dins d’un mateix hospital però sí podria haver-hi
sales amb el mateix codi que estiguin en hospitals diferents. De cada sala
necessitem saber també l’especialitat mèdica a la qual es dedica (maternitat,
cardiologia etc.) i el nombre de llits de què disposa.


Als hospitals treballen dos col·lectius diferents. Un dels col·lectius són els
metges. Cada doctor treballa exclusivament per a un hospital. Dins de cada
hospital es numeren els seus doctors. Aquest número servirà per identificar els
doctors dins de cada hospital però en hospitals diferents podria haver-hi
doctors amb el mateix número. Dels doctors en necessitem conèixer la seva
especialitat, el cognom i l’hospital pel qual treballen. Cada doctor treballa
per a un únic hospital.


L’altre col·lectiu de treballadors inclou tots els empleats que no són doctors.
Cada empleat està assignat a una sala. Dins de cada sala se’ls assigna un
número per diferenciar-los. De cada empleat haurem de saber doncs el seu
número, la sala on treballa i també el seu cognom, torn al qual està assignat
(matí, tarda o nit) i el seu salari brut mensual en euros. Cada treballador
treballa en una única sala.


Volem també enregistrar les dades dels pacients que atén aquest consorci
hospitalari. A cada pacient li assignen un nombre d’inscripció la primera
vegada que va a algun dels hospitals. Aquests pacients poden ser atesos en
consultes externes o bé ser hospitalitzats. De cada pacient en necessitem el
cognom, l’adreça, la data de naixement i el NSS.


Si la malaltia del pacient és prou greu i ha de ser ingressat, haurem de saber
en quina sala se l’ingressa, quin llit ocupa, la data en què arriba i la data
en què marxa, així com l’import de les despeses que genera en cadascuna de les
seves estades a l’hospital. S’ha de tenir en compte que, evidentment, un mateix
pacient pot ser ingressat i donat d’alta en diverses ocasions en la mateixa o
en diferents sales.


Volem guardar les visites que es fan a consultes externes. De cada visita volem
saber-ne el pacient visitat, el metge que ha fet la visita, la data i hora de la
visita, i les anotacions que ha fet el metge.