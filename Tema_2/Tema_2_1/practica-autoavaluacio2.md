# Pràctica autoavaluació 2 - El servei de neteja

## Context

Una empresa de neteja té una base de dades per saber de quins `professionals` disposa i quins han `intervingut` a cada servei. 

Quan es fa un servei, cada treballador adopta un `rol` dins aquell servei. Un mateix professional només pot participar una vegada en cada servei (amb un únic rol), però pot participar en diferents serveis amb rols diferents.

## Estructura de la base de dades

Observa aquestes taules:

* serveis(id pk, dia, adreca)
* rols(nom pk, salari_base)
* professionals(nif pk, nom_complet ak1)
* intervencions(nif_professional pk fk1, nom_rol fk2, id_servei pk fk3, hores_totals)

### Diccionari de dades:

* `serveis`: Servei de neteja realitzat. Cada servei té un identificador únic, una data i una adreça on s'ha realitzat.
* `rols`: Rol que pot tenir un professional en un servei, per exemple: `supervisor`, `netejador`, `especialista`. Cada rol té un salari base per hora associat.
* `professionals`: Treballador de l'empresa de neteja. S'identifica pel NIF i té un nom complet que és clau alternativa.
* `intervencions`: Relació que indica quin professional ha participat en quin servei amb quin rol i durant quantes hores. És una taula que relaciona professionals, rols i serveis.

Fes el diagrama Physical Data Model a la teva llibreta. Mira d'entendre per a què serveix aquesta base de dades. Mira d'entendre també quina informació podem emmagatzemar. Respon a tu mateix a aquestes preguntes:

* Per què la clau primària d'`intervencions` està formada per dos atributs (`nif_professional`, `id_servei`) i no inclou `nom_rol`?
* Què implica que `nom_rol` NO sigui part de la clau primària d'`intervencions`?
* Permet la base de dades que un professional intervingui en més d'un servei?
* Pot un professional adoptar diferents rols en un mateix servei?
* Pot un mateix rol ser utilitzat per diferents professionals en un mateix servei?
* Per què `nom_complet` és clau alternativa a `professionals`?

## Exercicis

* Pensa quin comportament és el més adient per a cada clau forana:

| clau | on update | on delete |
|--|--|--|
| intervencions a professionals | | |
| intervencions a rols | | |
| intervencions a serveis | | |

* Crea les taules amb tots els camps NOT NULL excepte quan s'indiqui el contrari.
* Insereix les següents dades:
   * **Rols**:
     * Supervisor - salari base: 25.50 €/hora
     * Netejador - salari base: 15.00 €/hora
     * Especialista - salari base: 20.00 €/hora
   * **Professionals**:
     * 12345678A - Joan Martí Soler
     * 23456789B - Maria Puig Vidal
     * 34567890C - Pere Casals Font
     * 45678901D - Laura Ribas Coma
   * **Serveis**:
     * Servei 1: 15/01/2024, Carrer Major 123, Barcelona
     * Servei 2: 16/01/2024, Avinguda Diagonal 456, Barcelona
     * Servei 3: 17/01/2024, Plaça Catalunya 78, Barcelona
   * **Intervencions**:
     * Joan Martí Soler com a Supervisor al Servei 1 - 4 hores
     * Maria Puig Vidal com a Netejador al Servei 1 - 6 hores
     * Pere Casals Font com a Netejador al Servei 1 - 6 hores
     * Joan Martí Soler com a Supervisor al Servei 2 - 3 hores
     * Laura Ribas Coma com a Especialista al Servei 2 - 5 hores
     * Pere Casals Font com a Supervisor al Servei 3 - 4 hores
     * Maria Puig Vidal com a Netejador al Servei 3 - 6 hores

* Comprova el comportament de les claus foranes:
   * Intenta esborrar un professional que ha participat en algun servei.
   * Intenta esborrar un rol que s'ha utilitzat en alguna intervenció.
   * Intenta actualitzar el NIF d'un professional que té intervencions.
   * Esborra un servei i comprova què passa amb les intervencions associades.

* Modificacions de l'esquema:
   * Afegeix una columna `telefon` (nullable) a la taula `professionals`.
   * Crea una taula `zones` amb els camps `id` pk i `nom` ak1.
   * Insereix tres zones: Nord, Sud, Centre.
   * Afegeix un camp `zona_id` (nullable) a `serveis`, converteix-lo en clau forana cap a `zones`.
   * Si s'esborra una zona, els serveis d'aquella zona haurien de quedar amb `zona_id` NULL.
   * Si s'actualitza l'`id` d'una zona, cal propagar el canvi als serveis.
   * Assigna zones als serveis existents.
   * Crea una restricció CHECK a la taula `intervencions` per assegurar que `hores_totals` és sempre major que 0.
   * Afegeix una columna `observacions` (nullable, tipus TEXT) a la taula `serveis`.

* Neteja final:
   * Elimina la restricció CHECK d'`intervencions`.
   * Esborra les restriccions d'integritat referencial de totes les taules.
   * Trunca totes les dades de totes les taules.
   * Esborra totes les taules.

## Entregables

* Fes un markdown documentant tota la pràctica amb:
   * Diagrama PDM (pots fer-lo en text o descriure'l).
   * Tot l'SQL necessari per crear les taules amb les restriccions adequades.
   * L'SQL d'inserció de dades.
   * L'SQL de les modificacions de l'esquema.
   * Explicació de com funciona la relació entre professionals i serveis a través d'`intervencions`, i per què el `nom_rol` NO forma part de la PK.
   * Documentació dels comportaments de les claus foranes i per què s'han triat.
   * Reflexions sobre les preguntes plantejades.
   * Captures de pantalla o sortides de les proves de comportament de les claus foranes.

