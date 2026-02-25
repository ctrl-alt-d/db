## Atributs identificadors (candidates)
### Exercici: atributs identificadors candidats

Cada entitat ha de tenir, almenys, un atribut identificador principal (AIP). En el procés de modelatge apareixen altres atributs que també podrien identificar les instàncies; aquests són atributs identificadors candidats o alternatius.

Exemple: suposem el següent enunciat:

En un institut cal emmagatzemar les dades dels professors. Cada professor té un codi intern que el cap d'estudis utilitza per fer horaris. Per exemple: el professor Ramon Pérez del departament Administratiu té el codi ADRP. També es recollirà el DNI, el nom complet, el correu electrònic institucional (ex.: rperez999@xtec.cat) i la data de naixement.

En aquest cas identifiquem l'entitat PROFESSOR i diversos atributs identificadors candidats: el codi intern, el DNI, el correu electrònic, el nom complet. En triarem un com a principal i la resta quedaran com a alternatius.

![Atribut identificador candidat](http://i.imgur.com/HDAqNll.png)

### Exercicis

1) Fes el MCD de l'enunciat següent:

Un taller mecànic vol una base de dades dels seus mecànics. Emmagatzemen: especialitat (ex.: pneumàtics), data d'incorporació a l'empresa, número de treballador, número de la Seguretat Social, DNI, telèfon mòbil, nom i cognoms.

2) Fes el MCD de l'enunciat següent:

Una web vol emmagatzemar usuaris. Les dades són: nom d'usuari (per accedir), adreça de correu electrònic, contrasenya (preferiblement emmagatzemada com un hash), data de naixement, nom complet, nacionalitat (codi ISO de dues lletres, ex.: BR) i la data de la darrera connexió.

3) Fes el MCD de l'enunciat següent:

Una empresa té diferents delegacions. L'adreça es compon de carrer i número, porta, CP, província i ciutat. Cada vegada que s'obre una nova delegació en una ciutat se li assigna un número (Barcelona 1, Barcelona 2, ...). També es podrien identificar per coordenades (latitud/longitud), però això no sempre és pràctic.

Ves amb compte: en aquest exercici els atributs identificadors poden ser compostos.


