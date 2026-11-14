# 01. Selecció i projecció amb Sakila

**Objectiu:** distingir la selecció de files (σ) de la projecció de columnes (π) i combinar-les.

**Teoria:** [Selecció i projecció](../Tema_2_2_2/01_algebra.md). **Dades:** [esquema de Sakila](./esquema.md).

Escriu les respostes amb expressions d'àlgebra relacional. Utilitza σ per seleccionar files i π per projectar columnes; escriurem el subíndex entre claus. En l'àlgebra relacional clàssica, una relació és un conjunt: la projecció elimina duplicats.

## Exemples resolts

### 1. Cognoms diferents dels actors

**Enunciat:** escriu l'expressió en àlgebra relacional per fer una projecció de `actor` que conservi només el cognom (`last_name`).

<details>
<summary>Mostra la solució</summary>

Expressió: `π_{last_name}(actor)`.

Dos actors poden tenir el mateix cognom; projectar-lo com a conjunt només el conserva una vegada.

</details>

### 2. Títols de pel·lícules llargues

**Enunciat:** escriu l'expressió en àlgebra relacional per seleccionar les pel·lícules amb una durada superior a 120 minuts i projectar-ne només el títol (`title`).

<details>
<summary>Mostra la solució</summary>

Expressió: `π_{title}(σ_{length > 120}(film))`.

La selecció s'aplica a les files de `film` i després es projecta el títol.

</details>

## Exercicis sense solució

### Bloc A. Selecció

#### 3. Pel·lícules per classificació

Escriu l'expressió en àlgebra relacional per fer una selecció de `film` que conservi només les pel·lícules amb `rating = 'PG-13'`. Mantén tots els atributs de la relació original. Indica si aquesta operació canvia el nombre de columnes.

#### 4. Clients actius d'una botiga

Escriu l'expressió en àlgebra relacional per fer una selecció de `customer` que conservi només els clients actius (`active = TRUE`) de la botiga 1 (`store_id = 1`). Mantén tots els atributs i combina les condicions amb una conjunció (∧).

### Bloc B. Projecció

#### 5. Idiomes utilitzats

Escriu l'expressió en àlgebra relacional per fer una projecció de `film` que conservi només `language_id`. Explica per què el resultat no conté necessàriament tots els idiomes de la relació `language`.

#### 6. Classificacions i tarifes

Escriu l'expressió en àlgebra relacional per fer una projecció de `film` que conservi els atributs `rating` i `rental_rate`. Si dues pel·lícules tenen la mateixa classificació i la mateixa tarifa, quantes vegades apareix aquest parell al resultat?

### Bloc C. Combinacions de selecció i projecció

#### 7. Noms de clients seleccionats

Escriu l'expressió en àlgebra relacional per seleccionar els clients actius de la botiga 1 i projectar-ne només `first_name` i `last_name`. Explica quina operació s'aplica primer.

#### 8. Títols i tarifes de pel·lícules seleccionades

Escriu l'expressió en àlgebra relacional per seleccionar les pel·lícules amb `length >= 90` i `rental_rate < 3` i projectar-ne només `title` i `rental_rate`. Escriu una versió amb una única selecció i una altra amb dues seleccions successives. Explica per què no pots projectar només `title` abans d'aplicar aquests filtres.

[Torna a l'índex](./readme.md) · [Següent: SELECT](./02_intro_select_exercicis.md)
