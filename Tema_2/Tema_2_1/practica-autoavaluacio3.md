# Pràctica autoavaluació 3 - El zoològic

## Context

Un zoològic vol anotar la dieta que ha de menjar cada animal. Cada animal pertany a una espècie i té les seves pròpies necessitats alimentàries. 

La dieta es compon de diferents `components` (aliments), i cada animal pot tenir una quantitat específica de cada component assignada.

## Estructura de la base de dades

Observa aquestes taules:

* especies(id pk, nom)
* animals(id_especie pk fk1 ak1, id_animal_especie pk, nom ak1)
* components(id pk, nom ak1)
* dietes(id_component pk fk1, id_especie pk fk2, id_animal_especie pk fk2, quantitat)

### Diccionari de dades:

* `especies`: Espècie animal del zoològic. Cada espècie té un identificador únic i un nom.
* `animals`: Animal individual del zoològic. S'identifica per l'espècie i un identificador propi dins l'espècie. El nom de l'animal és clau alternativa juntament amb l'espècie.
* `components`: Component alimentari (tipus d'aliment), per exemple: `carn`, `peix`, `fruita`, `verdura`, `pinso`. Cada component té un identificador únic i un nom que és clau alternativa.
* `dietes`: Relació que indica quina quantitat d'un component alimentari ha de consumir un animal concret. Relaciona animals i components amb la quantitat assignada.

Fes el diagrama Physical Data Model a la teva llibreta. Mira d'entendre per a què serveix aquesta base de dades. Mira d'entendre també quina informació podem emmagatzemar. Respon a tu mateix a aquestes preguntes:

* Per què la clau primària d'`animals` està formada per dos atributs (`id_especie`, `id_animal_especie`)? no en fariem prou amb `id_animal_especie` ?
* Què significa que `id_especie` i `nom` formin una clau alternativa a `animals`? Posa un exemple de valors que poguem entrar i de valors que no poguem entrar a la base de dades.
* Per què la clau primària de `dietes` inclou tres atributs (`id_component`, `id_especie`, `id_animal_especie`)?
* Pot un mateix animal tenir diversos components a la seva dieta?
* Poden dos animals diferents de la mateixa espècie tenir dietes diferents?
* Pot un component alimentari estar present a la dieta de diversos animals?

## Exercicis

* Pensa quin comportament és el més adient per a cada clau forana:

| clau | on update | on delete |
|--|--|--|
| animals a especies | | |
| dietes a components | | |
| dietes a animals | | |

* Crea les taules amb tots els camps NOT NULL excepte quan s'indiqui el contrari.
* Insereix les següents dades:
   * **Espècies**:
     * Lleó (id= 100)
     * Tigre (id= 101)
     * Elefant
     * Pingüí
   * **Animals**:
     * Lleó 1 - Simba
     * Lleó 2 - Nala
     * Tigre 1 - Rajah
     * Elefant 1 - Dumbo
     * Pingüí 1 - Pingu
     * Pingüí 2 - Rico
   * **Components**:
     * Carn vermella (id= 1000)
     * Carn blanca (id= 1001)
     * Peix
     * Fruita
     * Verdura
     * Pinso
   * **Dietes**:
     * Simba (Lleó 1): 5 kg de Carn vermella (Les unitats, els `Kg`, no cal entrar-les)
     * Simba (Lleó 1): 1 kg de Verdura
     * Nala (Lleó 2): 4.5 kg de Carn vermella
     * Rajah (Tigre 1): 6 kg de Carn vermella
     * Rajah (Tigre 1): 2 kg de Carn blanca
     * Dumbo (Elefant 1): 10 kg de Fruita
     * Dumbo (Elefant 1): 15 kg de Verdura
     * Dumbo (Elefant 1): 5 kg de Pinso
     * Pingu (Pingüí 1): 3 kg de Peix
     * Rico (Pingüí 2): 2.5 kg de Peix

* Comprova el comportament de les claus foranes:
   * Intenta esborrar una espècie que té animals associats.
   * Intenta esborrar un component que forma part d'alguna dieta.
   * Intenta esborrar un animal que té dieta assignada.
   * Intenta actualitzar l'`id` d'una espècie que té animals.
   * Intenta actualitzar l'`id` d'un component que forma part d'alguna dieta.

* Modificacions de l'esquema:
   * Afegeix una columna `continent` (nullable) a la taula `especies`.
   * Crea una taula `zones` amb els camps `id` pk i `nom` ak1.
   * Insereix tres zones: Savana, Aquàtic, Bosc.
   * Afegeix un camp `zona_id` (nullable) a `animals`, és una clau forana cap a `zones`. Defineix la restricció d'integritat referencial (constraint de foreign key).
   * Si s'esborra una zona, els animals d'aquella zona haurien de quedar amb `zona_id` NULL.
   * Si s'actualitza l'`id` d'una zona, cal propagar el canvi als animals.
   * Assigna zones als animals existents.
   * Crea una restricció CHECK a la taula `dietes` per assegurar que `quantitat` és sempre major que 0. (`CONSTRAINT quantitat_major_0 CHECK(quantitat > 0)`)
   * Afegeix una columna `unitat_mesura` (NOT NULL amb valor per defecte 'kg') a la taula `dietes`.
   * Afegeix una columna `data_naixement` (nullable, tipus DATE) a la taula `animals`.

* Neteja final:
   * Elimina la restricció CHECK de `dietes`.
   * Esborra les restriccions d'integritat referencial de totes les taules.
   * Trunca totes les dades de totes les taules.
   * Esborra totes les taules.

## Entregables

* Fes un markdown documentant tota la pràctica amb:
   * Diagrama PDM (pots fer-lo en text o descriure'l).
   * Tot l'SQL necessari per crear les taules amb les restriccions adequades.
   * L'SQL d'inserció de dades.
   * L'SQL de les modificacions de l'esquema.
   * Explicació de com funciona la clau primària composta d'`animals` i per què s'estructura així.
   * Explicació de la relació entre animals i components a través de `dietes`.
   * Documentació dels comportaments de les claus foranes i per què s'han triat.
   * Reflexions sobre les preguntes plantejades.
   * Captures de pantalla o sortides de les proves de comportament de les claus foranes.

