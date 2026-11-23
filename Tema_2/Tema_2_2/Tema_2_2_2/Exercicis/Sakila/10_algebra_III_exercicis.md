# 10. Operacions de conjunts i composicions en àlgebra relacional amb Sakila

> **Entorn:** si encara no tens la base de dades Sakila en marxa, segueix la [guia d'instal·lació i connexió](./readme.md#entorn-de-treball).

**Objectiu:** raonar sobre unió (∪), intersecció (∩) i diferència (−) amb conjunts compatibles, i expressar composicions internes (`INNER JOIN`) com una projecció d'una selecció d'un producte cartesià.

**Teoria:** [Operacions de conjunts](../../10_algebra_III.md), [producte cartesià](../../08_algebra_II.md) i [JOIN](../../09_joins.md). **Dades:** [esquema de Sakila](./esquema.md).

Treballarem amb aquests dos conjunts d'identificadors de pel·lícules:

- `A = π_{film_id}(σ_{store_id = 1}(inventory))`: títols amb alguna còpia a la botiga 1.
- `B = π_{film_id}(σ_{store_id = 2}(inventory))`: títols amb alguna còpia a la botiga 2.

Els dos conjunts tenen el mateix atribut i domini. La projecció elimina les còpies repetides d'un mateix títol. Als exercicis 3 a 6, escriu l'expressió d'àlgebra relacional i la consulta SQL equivalent. Als exercicis 7 a 10, escriu l'expressió d'àlgebra relacional amb π, σ i ×.

## Exemples resolts

### 1. Pel·lícules presents en alguna botiga

**Enunciat:** obtén els identificadors de les pel·lícules amb còpies a la botiga 1, a la botiga 2 o a totes dues, sense repeticions i ordenats ascendentment.

<details>
<summary>Mostra la solució</summary>

Expressió: `A ∪ B`.

```sql
SELECT film_id FROM inventory WHERE store_id = 1
UNION
SELECT film_id FROM inventory WHERE store_id = 2
ORDER BY film_id ASC;
```

`UNION` elimina les repeticions dins de cada branca i entre les dues.

</details>

### 2. Pel·lícules presents a totes dues botigues

**Enunciat:** obtén els identificadors comuns a les dues botigues, sense repeticions i ordenats ascendentment.

<details>
<summary>Mostra la solució</summary>

Expressió: `A ∩ B`.

```sql
SELECT film_id FROM inventory WHERE store_id = 1
INTERSECT
SELECT film_id FROM inventory WHERE store_id = 2
ORDER BY film_id ASC;
```

No comparem `inventory_id`: dues còpies diferents poden correspondre al mateix `film_id`.

</details>

## Exercicis sense solució

### Bloc A. Operacions de conjunts

#### 3. Només a la botiga 1

Obtén les pel·lícules de `A` que no són a `B`. Escriu també la consulta amb els operands intercanviats. Ordena els identificadors ascendentment i explica per què les dues diferències no representen el mateix conjunt.

#### 4. En una sola de les botigues

Obtén les pel·lícules que tenen còpies exactament en una de les dues botigues. Construeix l'expressió amb dues diferències i una unió. Utilitza parèntesis en SQL per reflectir l'ordre de les operacions i ordena per `film_id` ascendent.

#### 5. Sense cap còpia

Defineix `F = π_{film_id}(film)` i obtén les pel·lícules del catàleg que no tenen còpies en cap botiga. Pots utilitzar `I = π_{film_id}(inventory)` com a conjunt dels títols amb còpies. Ordena els identificadors ascendentment.

#### 6. Compatibilitat i significat

Analitza si té sentit unir `π_{actor_id}(actor)` amb `π_{film_id}(film)`. Tot i que SQL admeti la unió de dos identificadors enters, què significaria una fila del resultat? Proposa una unió entre taules diferents que tingui un significat clar i escriu-ne la consulta, amb àlies de columna compatibles.

### Bloc B. INNER JOIN amb projecció, selecció i producte cartesià

Una composició interna amb condició es pot expressar com una selecció sobre un producte cartesià. Si només volem alguns atributs, hi afegim una projecció:

`π_{atributs}(σ_{condició d'enllaç ∧ filtres}(R × S))`

El producte cartesià genera les combinacions; la selecció conserva les que compleixen les condicions d'enllaç i els filtres; la projecció conserva els atributs demanats. Qualifica els atributs amb el nom de la relació, com ara `film.language_id`, per evitar ambigüitats.

Als exercicis següents, desenvolupa la composició amb **π, σ i ×**. La selecció ha de contenir les igualtats entre les claus que relacionen les taules. Com en qualsevol projecció de l'àlgebra relacional clàssica, el resultat és un conjunt sense duplicats.

#### 7. Pel·lícules amb el seu idioma

Escriu l'expressió en àlgebra relacional per obtenir `film.title` i `language.name` de cada pel·lícula amb el seu idioma. Parteix del producte cartesià de `film` i `language`, selecciona les parelles que corresponen i projecta els dos atributs demanats.

#### 8. Clients actius amb la seva adreça

Escriu l'expressió en àlgebra relacional per obtenir `customer.first_name`, `customer.last_name` i `address.address` dels clients actius de la botiga 1. Parteix de `customer × address` i inclou a la selecció tant la condició d'enllaç com els filtres sobre el client.

#### 9. Actors de pel·lícules llargues

Escriu l'expressió en àlgebra relacional per obtenir `film.title`, `actor.first_name` i `actor.last_name` dels actors que participen en pel·lícules de més de 120 minuts. Utilitza el producte cartesià de `film`, `film_actor` i `actor`, les dues condicions d'enllaç i el filtre de durada.

#### 10. Clients d'un país

Escriu l'expressió en àlgebra relacional per obtenir `customer.first_name`, `customer.last_name` i `city.city` dels clients actius amb adreça a `'Spain'`. Utilitza `customer × address × city × country`, inclou totes les condicions d'enllaç i aplica els filtres abans de la projecció.

[Torna a l'índex](./readme.md) · [Següent: subconsultes](./11_subconsultes_exercicis.md)
