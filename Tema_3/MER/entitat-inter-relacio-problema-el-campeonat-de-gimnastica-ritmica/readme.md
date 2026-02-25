# El campeonat de gimnàstica rítmica
## DAW-MP02-UF1 - Exercici de Introducció a les bases de dades
**Enunciat**

[El campeonat de gimnàstica rítmica](https://gitlab.com/joanq/DAM-M2-BasesDeDades/blob/master/UF1/2-model_ER/ritmica.adoc) by Joan Queralt

La "Real Federación Española de Gimnasia" organitza cada any el Campionat
Nacional de Clubs de Gimnàstica Rítmica en la modalitat d'individuals i
necessita dissenyar una base de dades que permeti informatitzar la gestió del
campionat d'aquest any. A la base de dades volen recollir informació sobre les
gimnastes, els clubs, les entrenadores, les jutgesses i les qualificacions
obtingudes.

Per poder participar les gimnastes han d'estar federades i, per tant, tenen una
fitxa federativa amb un número que serveix per a identificar-les a nivell
nacional. De cada gimnasta volen conèixer el número de fitxa federativa, el
nom, els cognoms, la data de naixement, a quin club pertany, quina és
l'entrenadora que la presenta a la competició i quina és la seva gimnasta
suplent. Cada gimnasta pot tenir com a màxim una suplent però una mateixa
gimnasta podria ser la suplent de diverses titulars. Hi ha gimnastes que no
tenen suplent i gimnastes que no supleixen a cap altra.

En el moment del campionat cada gimnasta pertany a un únic club que és on
entrena habitualment. Cada club pot presentar al campionat tres gimnastes
com a màxim. Dels clubs volen saber el seu nom, l'adreça de la seva seu,
la seva província, el nom del seu president/a i les entrenadores que hi
treballen. Els noms dels clubs no poden repetir-se.

Les entrenadores han d'estar federades. De les entrenadores ens interessa
saber el DNI, nom, cognoms, número de fitxa federativa (que és únic a nivell
nacional), adreça, titulació i les gimnastes que presenten a la competició.

La Federació vol aprofitar també per anar fent un històric dels clubs en què
treballa i/o ha treballat cada entrenadora. S'ha de tenir en compte que cada
entrenadora pot treballar en més d'un club alhora i que podria treballar un
temps en un club, marxar-ne i tornar després al mateix club.

Les jutgesses també han d'estar federades. El número de fitxa federativa les
identifica a nivell nacional. No poden entrenar en cap club ni presentar
gimnastes a les competicions. D'elles volen saber el número de fitxa, DNI, nom,
cognoms, adreça, si tenen la titulació adequada per ser jutgessa internacional
o no i els idiomes que parlen.

Al campionat cada gimnasta fa quatre exercicis (coreografies) dels aparells
que s'hagin fixat per a aquest any (per exemple, "corda", "pilota", "cinta" i
"mans lliures"). En cada exercici que fa rep una nota de 0 a 10 de cadascuna
de les 4 jutgesses que puntuen cada exercici. Es vol guardar quina nota ha
posat cada jutgessa a cada exercici que ha puntuat.

El càlcul de les classificacions el farà després un programa que llegirà les
dades guardades.

<details>
    <summary>Resolució MCD</summary>
      <p>
        <img src="https://i.imgur.com/ZhoBtlw.png" alt="Resolució MCD">
      </p>

    

</details>
