# 08. Producte cartesià amb Sakila

**Objectiu:** interpretar el producte cartesià (×), calcular-ne la cardinalitat i relacionar-lo amb `CROSS JOIN` i amb una selecció posterior.

**Teoria:** [Producte cartesià](../Tema_2_2_2/08_algebra_II.md). **Dades:** [esquema de Sakila](./esquema.md).

Escriu l'expressió d'àlgebra relacional i la consulta SQL equivalent. Qualifica les columnes quan dues taules tinguin el mateix nom de columna. En les expressions, utilitza `taula.columna` per evitar ambigüitats.

## Exemples resolts

### 1. Totes les combinacions d'idioma i categoria

**Enunciat:** genera una fila per combinació de `language.name` i `category.name`. Anomena les columnes `idioma` i `categoria` i ordena-les ascendentment, primer per idioma.

<details>
<summary>Mostra la solució</summary>

Expressió: `π_{language.name, category.name}(language × category)`.

```sql
SELECT l.name AS idioma, c.name AS categoria
FROM language AS l
CROSS JOIN category AS c
ORDER BY idioma ASC, categoria ASC;
```

Amb 6 idiomes i 16 categories, el resultat té `6 × 16 = 96` files. Representa combinacions possibles, no assignacions reals de pel·lícules.

</details>

### 2. Del producte a una composició

**Enunciat:** combina cada pel·lícula amb el seu idioma i mostra `film_id`, `title` i el nom de l'idioma com a `idioma`.

<details>
<summary>Mostra la solució</summary>

Expressió: `π_{film.film_id, film.title, language.name}(σ_{film.language_id = language.language_id}(film × language))`.

```sql
SELECT f.film_id, f.title, l.name AS idioma
FROM film AS f
CROSS JOIN language AS l
WHERE f.language_id = l.language_id;
```

El filtre conserva només les parelles que compleixen la relació entre claus. Al següent apartat escriurem aquesta composició amb `INNER JOIN ... ON`.

</details>

## Exercicis sense solució

### 3. Cardinalitat prevista i real

Prediu el nombre de files de `store × category` i de `store × language × category` a partir dels recomptes de les taules. Escriu les expressions i comprova les prediccions amb consultes `COUNT(*)` sobre els productes cartesians corresponents.

### 4. Selecció sobre combinacions

A partir de `language × category`, conserva només les combinacions amb categories el nom de les quals comença per `'S'`. Mostra els noms amb els àlies `idioma` i `categoria`, ordenats per idioma i categoria ascendents.

### 5. Clients i adreces

Escriu una expressió amb producte cartesià, selecció i projecció que retorni `customer.customer_id`, `customer.last_name` i `address.address` de cada client amb la seva adreça. Tradueix-la a SQL amb `CROSS JOIN` i un filtre d'igualtat. Explica què passaria si ometessis aquest filtre.

### 6. Combinacions possibles i existències reals

Genera totes les combinacions de `store.store_id` i `film.film_id`. Indica per què el resultat no permet saber si cada botiga té còpies de cada pel·lícula i quina taula caldria consultar per comprovar-ho.

[Torna a l'índex](./readme.md) · [Següent: JOIN](./09_joins_exercicis.md)
