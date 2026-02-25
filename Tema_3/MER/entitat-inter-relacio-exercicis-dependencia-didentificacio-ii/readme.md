# Entitat inter-relació - Exercicis dependència d'identificació II
## DAW-MP02-UF1 - Exercici de Introducció a les bases de dades
**Observa aquest Univers de discurs i el seu MCD corresponent:**

*En una escola els professors imparteixen docència a diferents grups. Del professor emmagatzemem les inicials, el nom, el DNI i el seu correu electrònic. Dels grups emmagatzemem el nivell (exemple: ESO ) el curs ( exemple: 2 ), la lletra ( exemple 'E') i l'aula on són habitualment (exemple: 315 ). Ens interessa saber quantes ( no quines ) hores imparteix cada professor a cada grup. Hi ha professors que no imparteixen docència, tots els grups tenen professor*

![Inter-relació n:M amb dependència en identificació](http://i.imgur.com/MpUoGWy.png)

**Anem a variar una mica l'enunciat per veure com camvia el MCD:**

*En una escola els professors imparteixen docència a diferents grups. Del professor emmagatzemem les inicials, el nom, el DNI i el seu correu electrònic. Dels grups emmagatzemem el nivell (exemple: ESO ) el curs ( exemple: 2 ), la lletra ( exemple 'E') i l'aula on són habitualment (exemple: 315 ). Ens interessa saber **quantes hores imparteix cada professor a cada grup els diferents dies de la setmana**. Hi ha professors que no imparteixen docència, tots els grups tenen professor*

![Inter-relació n:M amb dependència en identificació i atributs](http://i.imgur.com/kSyiPqw.png)

**Fes el MCD d'aquest univers de discurs:**

*Una màquina (exemple: 'fressadora 1' ) està formada per peces. Cada màquina té un codi, any de posada en funcionament, data de la darrera revisió. Cada peça ( exemple: 'cargol 4mm rosca fina') té una referència, un nom, un pes i un preu. Ens interessa saber quines peces apareixen a cada màquina i en quina quantitat. Una peça pot estar en diferents màquines. Totes les màquines tenen peces, hi ha peces que no les fa servir cap màquina.*


