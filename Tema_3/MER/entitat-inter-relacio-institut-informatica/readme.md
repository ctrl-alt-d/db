## [Aules d'informàtica. By Joan Queralt](https://gitlab.com/joanq/DAM-M2-BasesDeDades/-/blob/master/UF1/2-model_ER/activitats/aules_informatica.adoc)

Un institut de secundària vol poder gestionar els alumnes de cicles que
treballen en cadascuna de les aules d’informàtica del centre, i els ordinadors
que fan servir cadascun d’ells.


De cada aula d’informàtica es volen guardar algunes dades: el nom de l’aula
(per exemple, Info1), la quantitat d’alumnes que hi caben (per exemple,
20 alumnes), la seva mida (per exemple, 30 metres quadrats), la quantitat
d’ordinadors que hi ha (per exemple, 20 ordinadors). També es vol saber quines
aules tenen projector i quines tenen aire condicionat.


Pel que fa a l’alumnat es vol guardar el seu nom i cognoms, el seu DNI, i quin
curs i cicle estan fent (per exemple, 1r SMX A).


Dels ordinadors volem guardar-ne la seva adreça IP (que sempre serà la mateixa
per a un mateix ordinador, per exemple 192.168.1.100), l’adreça MAC de la seva
targeta de xarxa (per exemple, 60:02:80:a2:1c:f1), i el seu nom (per exemple,
info2-03). També guardarem el tipus de processador que tenen (per exemple,
i5), i la quantitat de memòria instal·lada (per exemple, 8 GB).


De cada ordinador volem saber a quina aula es troba, i de cada alumne volem
saber per quines aules passa i quins ordinadors utilitza (un alumne pot
utilitzar diverses aules al llarg de la setmana, però sempre que està en una
mateixa aula ha d’utilitzar el mateix ordinador). Igualment, un ordinador pot
ésser utilitzat per més d’un alumne en horaris diferents.