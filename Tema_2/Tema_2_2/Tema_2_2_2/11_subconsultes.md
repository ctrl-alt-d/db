# Subconsultes en SQL

## Introducció

Les **subconsultes** (o subqueries) són consultes SQL que s'inclouen dins d'una altra consulta. Són una eina poderosa que permet resoldre problemes complexos descomponent-los en parts més simples.

Una subconsulta és essencialment una consulta SELECT que apareix dins de:
- La clàusula WHERE
- La clàusula FROM
- La clàusula SELECT
- La clàusula HAVING

Les subconsultes permeten fer consultes dinàmiques on els criteris de filtrat depenen dels resultats d'altres consultes.

## Sintaxi bàsica

```sql
SELECT columnes
FROM taula
WHERE columna operador (SELECT columna FROM taula WHERE condició);
```

La subconsulta va entre parèntesis. Per entendre una subconsulta no correlacionada, podem calcular-ne primer el resultat i utilitzar-lo a la consulta externa. Aquest és un model de raonament: l'optimitzador decideix com executar realment la consulta completa.

## Tipus de subconsultes

### 1. Subconsultes que retornen un sol valor (escalar)

Una subconsulta escalar retorna una columna i, com a màxim, una fila. Es pot utilitzar amb operadors de comparació (`=`, `>`, `<`, etc.). Si no retorna cap fila, el seu valor és `NULL`; si en retorna més d'una, PostgreSQL dona error.

Una subconsulta amb `AVG`, `MAX` o `COUNT` sense `GROUP BY` retorna una sola fila. Si no hi ha valors per agregar, `AVG` i `MAX` retornen `NULL`, mentre que `COUNT` retorna `0`. Una comparació com `preu > NULL` dona un resultat desconegut i no supera el filtre `WHERE`.

#### Exemple 1: Trobar productes més cars que la mitjana

```sql
SELECT nom, preu
FROM Productes
WHERE preu > (SELECT AVG(preu) FROM Productes);
```

**Explicació:**
1. Primer s'executa `SELECT AVG(preu) FROM Productes` → retorna, per exemple, 250
2. Després s'executa la consulta principal: `WHERE preu > 250`

#### Exemple 2: Trobar l'empleat amb el salari més alt

```sql
SELECT nom, cognom, salari
FROM Empleats
WHERE salari = (SELECT MAX(salari) FROM Empleats);
```

### 2. Subconsultes que retornen múltiples valors

Quan la subconsulta pot retornar més d'un valor, utilitzem operadors especials com `IN`, `ANY`, `ALL`.

#### Operador IN

Comprova si un valor està dins d'un conjunt de valors.

```sql
-- Trobar clients que han fet comandes
SELECT id, nom, cognom
FROM Clients
WHERE id IN (SELECT client_id FROM Comandes);
```

**Equivalent amb JOIN:**
```sql
SELECT DISTINCT c.id, c.nom, c.cognom
FROM Clients c
INNER JOIN Comandes co ON c.id = co.client_id;
```

#### Exemple: Productes de categories específiques

```sql
-- Trobar productes de categories amb més de 10 productes
SELECT nom, categoria_id
FROM Productes
WHERE categoria_id IN (
    SELECT categoria_id
    FROM Productes
    WHERE categoria_id IS NOT NULL
    GROUP BY categoria_id
    HAVING COUNT(*) > 10
);
```

La subconsulta retorna una columna amb les categories seleccionades després d'agrupar. El `WHERE` exterior comprova si cada producte pertany a alguna d'aquestes categories. Els duplicats a la subconsulta no canvien la comprovació de pertinença d'`IN`.

#### Operador ANY

Comprova si la condició és certa per ALMENYS UN dels valors retornats.

```sql
-- Trobar productes més cars que almenys un producte de la categoria 'Ofertes'
SELECT nom, preu
FROM Productes
WHERE preu > ANY (
    SELECT preu
    FROM Productes
    WHERE categoria = 'Ofertes'
);
```

Si el conjunt de referència no és buit i tots els seus preus són no nuls, `> ANY` equival a superar-ne el mínim. No significa superar tots els preus.

#### Operador ALL

Comprova si la condició és certa per TOTS els valors retornats.

```sql
-- Trobar productes més cars que TOTS els productes de la categoria 'Ofertes'
SELECT nom, preu
FROM Productes
WHERE preu > ALL (
    SELECT preu
    FROM Productes
    WHERE categoria = 'Ofertes'
);
```

Si el conjunt de referència no és buit i tots els seus preus són no nuls, `> ALL` equival a superar-ne el màxim.

#### ANY i ALL amb conjunts buits o valors nuls

| Situació | `preu > ANY (subconsulta)` | `preu > ALL (subconsulta)` |
| --- | --- | --- |
| La subconsulta no retorna cap fila | `FALSE`: no hi ha cap valor que satisfaci la comparació. | `TRUE`: no hi ha cap valor que la contradigui. |
| Hi ha almenys una comparació certa | `TRUE`, encara que hi hagi altres comparacions amb `NULL`. | Cal examinar les altres comparacions. |
| Hi ha almenys una comparació falsa | Cal examinar les altres comparacions. | `FALSE`, encara que hi hagi altres comparacions amb `NULL`. |

Si `ANY` no troba cap comparació certa i alguna és desconeguda, el resultat és `NULL`. Si `ALL` no troba cap comparació falsa i alguna és desconeguda, també és `NULL`. Per treballar només amb preus coneguts, exclou els nuls amb `IS NOT NULL` tant a la consulta externa com a la subconsulta.

`WHERE 1 = 0` permet provar expressament el cas d'un conjunt buit. Les equivalències amb `MIN` i `MAX` no s'hi poden aplicar sense matisos: aquests agregats retornen `NULL` quan no hi ha valors.

### 3. Subconsultes correlacionades

Una subconsulta correlacionada fa referència a columnes de la consulta externa. Per interpretar-la, considerem el seu resultat per a cada fila externa; això no obliga l'optimitzador a executar-la físicament una vegada per fila.

#### Exemple: Empleats que guanyen més que la mitjana del seu departament

```sql
SELECT nom, cognom, departament, salari
FROM Empleats e1
WHERE salari > (
    SELECT AVG(salari)
    FROM Empleats e2
    WHERE e2.departament = e1.departament
);
```

**Explicació:**
- Per cada empleat de la consulta externa, la subconsulta calcula la mitjana salarial del seu departament
- Es compara el salari de l'empleat amb aquesta mitjana

#### Exemple: Productes més cars de cada categoria

```sql
SELECT nom, categoria, preu
FROM Productes p1
WHERE preu = (
    SELECT MAX(preu)
    FROM Productes p2
    WHERE p2.categoria = p1.categoria
);
```

La condició `p2.categoria = p1.categoria` limita l'agregat a la categoria de la fila externa. Si dos productes comparteixen el preu màxim, tots dos compleixen la igualtat: no cal triar-ne un amb `LIMIT 1`. Per excloure productes sense categoria o sense preu conegut, afegeix `p1.categoria IS NOT NULL` i `p1.preu IS NOT NULL` al filtre exterior.

### 4. Subconsultes a la clàusula FROM

Una subconsulta al `FROM` produeix una **taula derivada** (*derived table*), que la consulta externa pot consultar com una relació. No crea una taula temporal desada a la base de dades.

```sql
-- Trobar categories amb preu mitjà superior a 100
SELECT categoria, preu_mitjà
FROM (
    SELECT categoria, AVG(preu) AS preu_mitjà
    FROM Productes
    GROUP BY categoria
) AS categories_mitjanes
WHERE preu_mitjà > 100;
```

Assignarem sempre un àlies a les taules derivades per identificar-ne les columnes amb claredat. PostgreSQL 16 i versions posteriors permeten ometre'l en alguns casos, però fer-lo explícit facilita la lectura i la compatibilitat amb altres gestors.

Una taula derivada també permet separar dos nivells d'agregació. Per exemple, podem obtenir primer una suma per client i després calcular la mitjana d'aquests totals:

```sql
SELECT AVG(t.total_client) AS mitjana_totals
FROM (
    SELECT client_id, SUM(import) AS total_client
    FROM Comandes
    GROUP BY client_id
) AS t;
```

La consulta interna retorna una fila per client amb comandes; l'externa retorna una sola fila. `AVG(import)` sobre `Comandes` calcularia, en canvi, la mitjana per comanda. No podem substituir aquests dos nivells per `AVG(SUM(import))` dins del mateix nivell d'agregació.

#### Exemple complex: Vendes per trimestre

```sql
SELECT trimestre, SUM(total) AS vendes_totals
FROM (
    SELECT 
        CASE 
            WHEN EXTRACT(MONTH FROM data) BETWEEN 1 AND 3 THEN 'Q1'
            WHEN EXTRACT(MONTH FROM data) BETWEEN 4 AND 6 THEN 'Q2'
            WHEN EXTRACT(MONTH FROM data) BETWEEN 7 AND 9 THEN 'Q3'
            ELSE 'Q4'
        END AS trimestre,
        import AS total
    FROM Comandes
) AS comandes_per_trimestre
GROUP BY trimestre;
```

En PostgreSQL, `EXTRACT(MONTH FROM data)` extreu el número de mes. `CASE` avalua les condicions en ordre i retorna el valor del primer `WHEN` cert, o el d'`ELSE` si cap no ho és. Aquest exemple combina els mateixos trimestres de tots els anys; per conservar l'any en un resum temporal, consulta l'agrupació amb `date_trunc` al tema de [GROUP BY](./06_group_by.md#agrupar-per-una-expressió-o-per-mes).

### 5. Subconsultes a la clàusula SELECT

Podem utilitzar subconsultes per calcular valors per cada fila del resultat.

```sql
SELECT 
    nom,
    preu,
    (SELECT AVG(preu) FROM Productes) AS preu_mitjà,
    preu - (SELECT AVG(preu) FROM Productes) AS diferència_mitjana
FROM Productes;
```

#### Exemple: Comptar comandes per client

```sql
SELECT 
    c.nom,
    c.cognom,
    (SELECT COUNT(*) 
     FROM Comandes co 
     WHERE co.client_id = c.id) AS num_comandes
FROM Clients c;
```

La subconsulta amb `COUNT(*)`, sense `GROUP BY`, retorna una sola fila fins i tot si el client no té comandes. Per això mostra `0` i no cal substituir un valor nul amb `COALESCE`. Un àlies com `num_comandes` es pot utilitzar a l'`ORDER BY` de la consulta externa.

## Operador EXISTS

L'operador `EXISTS` comprova si una subconsulta retorna almenys una fila. Retorna TRUE o FALSE.

```sql
-- Trobar clients que han fet almenys una comanda
SELECT nom, cognom
FROM Clients c
WHERE EXISTS (
    SELECT 1
    FROM Comandes co
    WHERE co.client_id = c.id
);
```

**Nota:** Dins d'EXISTS, és comú utilitzar `SELECT 1` perquè només importa si hi ha files, no quins valors retorna.

### NOT EXISTS

Podem utilitzar `NOT EXISTS` per trobar files que NO compleixen la condició.

```sql
-- Trobar clients que NO han fet cap comanda
SELECT nom, cognom
FROM Clients c
WHERE NOT EXISTS (
    SELECT 1
    FROM Comandes co
    WHERE co.client_id = c.id
);
```

#### Exemple: Productes sense vendes

```sql
SELECT nom, codi
FROM Productes p
WHERE NOT EXISTS (
    SELECT 1
    FROM LíniesComanda lc
    WHERE lc.producte_id = p.id
);
```

### Una subconsulta EXISTS també pot contenir JOIN

Una subconsulta pot consultar diverses taules. En Northwind, `orders` conté la capçalera i la data de la comanda; `order_details` en conté les línies i els productes. Les dues taules es relacionen per `order_id`.

Per exemple, podem cercar els clients que no tenen cap comanda amb una línia de 50 unitats o més:

```sql
SELECT c.customer_id, c.company_name
FROM customers AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders AS o
    INNER JOIN order_details AS od ON od.order_id = o.order_id
    WHERE o.customer_id = c.customer_id
      AND od.quantity >= 50
)
ORDER BY c.customer_id ASC;
```

L'`ON` relaciona les taules internes. La condició `o.customer_id = c.customer_id` correlaciona la subconsulta amb el client exterior. El filtre addicional defineix quines coincidències volem descartar. Si la pregunta es refereix a un període, el filtre de data també ha d'anar dins de la subconsulta, sobre `o.order_date`.

Per expressar «no hi ha cap compra des de X», cal comprovar l'absència de compres amb data igual o posterior a X. Trobar una compra anterior a X no és suficient: el mateix producte pot tenir també compres posteriors.

### NOT IN i els valors NULL

`NOT IN` i `NOT EXISTS` no són intercanviables en tots els casos. Per exemple, `5 NOT IN (1, NULL)` dona `NULL`: no podem assegurar que el valor desconegut sigui diferent de 5. Una condició desconeguda no supera el `WHERE`.

Si volem comparar identificadors coneguts amb `NOT IN`, hem d'excloure els nuls de la subconsulta i, si escau, de l'expressió externa. Amb `NOT EXISTS`, formulem directament la condició d'igualtat que descartaria la fila exterior. En tots dos casos cal decidir què significa un identificador nul en el problema que estem resolent.

## Comparació: Subconsultes vs JOINs

Moltes subconsultes es poden reescriure amb JOINs i viceversa.

### Exemple: Mateix resultat amb ambdós mètodes

**Amb subconsulta:**
```sql
SELECT id, nom, cognom
FROM Clients
WHERE id IN (SELECT client_id FROM Comandes);
```

**Amb JOIN:**
```sql
SELECT DISTINCT c.id, c.nom, c.cognom
FROM Clients c
INNER JOIN Comandes co ON c.id = co.client_id;
```

### Quan utilitzar subconsultes vs JOINs?

**Subconsultes són preferibles quan:**
- La lògica és més clara i llegible
- Necessitem EXISTS/NOT EXISTS
- Volem comparar amb agregacions (MAX, AVG, etc.)
- La subconsulta retorna un únic valor

**JOINs són preferibles quan:**
- Necessitem columnes de múltiples taules
- Millor rendiment (en alguns casos)
- Operacions més complexes de combinació

## Subconsultes amb HAVING

Podem utilitzar subconsultes a la clàusula HAVING per filtrar grups.

```sql
-- Trobar categories amb més productes que la categoria 'Electrònica'
SELECT categoria, COUNT(*) AS num_productes
FROM Productes
GROUP BY categoria
HAVING COUNT(*) > (
    SELECT COUNT(*)
    FROM Productes
    WHERE categoria = 'Electrònica'
);
```

## Exemples pràctics amb gossos i races

Assumint les taules:
- `gossos(num_xip, nom, raça, data_naixement)`
- `raça(id, nom, tamany)`

### Exemple 1: Gossos de la raça més popular

```sql
SELECT nom, raça
FROM gossos
WHERE raça IN (
    SELECT raça
    FROM gossos
    GROUP BY raça
    ORDER BY COUNT(*) DESC
    LIMIT 1
);
```

### Exemple 2: Gossos més grans que la mitjana de la seva raça

```sql
SELECT g1.nom, g1.raça, g1.data_naixement
FROM gossos g1
WHERE CURRENT_DATE - g1.data_naixement > (
    SELECT AVG(CURRENT_DATE - g2.data_naixement)
    FROM gossos g2
    WHERE g2.raça = g1.raça
);
```

Aquí `data_naixement` és de tipus `date`: `CURRENT_DATE - data_naixement` calcula l'edat en dies. Agreguem aquest nombre perquè PostgreSQL no defineix `AVG(date)`.

### Exemple 3: Races que tenen més de 5 gossos

```sql
SELECT nom
FROM raça
WHERE id IN (
    SELECT raça
    FROM gossos
    GROUP BY raça
    HAVING COUNT(*) > 5
);
```

### Exemple 4: Gossos de races de tamany gran

```sql
SELECT nom, num_xip
FROM gossos
WHERE raça IN (
    SELECT id
    FROM raça
    WHERE tamany = 'Gran'
);
```

## Subconsultes imbricades

Podem tenir subconsultes dins de subconsultes (fins a diversos nivells, tot i que pot afectar el rendiment).

```sql
-- Trobar productes de la mateixa categoria que el producte més car
SELECT nom, categoria, preu
FROM Productes
WHERE categoria IN (
    SELECT categoria
    FROM Productes
    WHERE preu = (
        SELECT MAX(preu)
        FROM Productes
    )
);
```

## Consideracions de rendiment

El rendiment depèn de les dades, els índexs i el pla d'execució. No es pot afirmar, només per la sintaxi, que un `JOIN` sigui més ràpid que una subconsulta o que `EXISTS` sigui més ràpid que `IN`.

L'optimitzador pot transformar aquestes consultes i evitar càlculs repetits. Primer comprova que expressen la mateixa pregunta i tracten els duplicats i els nuls de la mateixa manera. Després pots comparar-ne els plans amb `EXPLAIN`; no cal fer aquesta anàlisi per resoldre les pràctiques.

### Optimització: EXISTS vs IN

**Comprovació de pertinença amb IN:**
```sql
SELECT nom FROM Clients
WHERE id IN (SELECT client_id FROM Comandes);
```

**Comprovació d'existència amb EXISTS:**
```sql
SELECT nom FROM Clients c
WHERE EXISTS (SELECT 1 FROM Comandes co WHERE co.client_id = c.id);
```

Aquestes dues consultes expressen una comprovació d'existència per a identificadors de client no nuls. Tria la forma més clara; qualsevol diferència de rendiment s'ha de mesurar.

## Errors comuns

### ❌ Error 1: Subconsulta retorna més d'un valor

```sql
-- ERROR si la subconsulta retorna més d'una fila.
SELECT nom
FROM Empleats
WHERE departament = (SELECT departament FROM Empleats WHERE salari > 50000);
```

**Solució:** Utilitzar IN en lloc de =
```sql
SELECT nom
FROM Empleats
WHERE departament IN (SELECT departament FROM Empleats WHERE salari > 50000);
```

### ❌ Error 2: Referenciar una taula derivada amb un àlies inexistent

```sql
-- ERROR: no s'ha definit l'àlies t.
SELECT t.categoria, t.preu_mitjà
FROM (SELECT categoria, AVG(preu) AS preu_mitjà FROM Productes GROUP BY categoria);
```

**Solució:**
```sql
SELECT t.categoria, t.preu_mitjà
FROM (SELECT categoria, AVG(preu) AS preu_mitjà FROM Productes GROUP BY categoria) AS t;
```

### ❌ Error 3: Tractar un resultat NULL com si fos zero

Si una subconsulta amb `AVG` no té valors per calcular la mitjana, retorna `NULL`. Una comparació amb aquest resultat és desconeguda i no selecciona la fila. Això és diferent de comparar amb zero.

Utilitza `IS NULL` si vols comprovar explícitament l'absència de valor. Utilitza `COALESCE` només si el context justifica un valor alternatiu: no és una correcció automàtica aplicable a qualsevol subconsulta.

## Exercicis pràctics

Per treballar amb Northwind, consulta els [exercicis de subconsultes](./Exercicis/Northwind/11_subconsultes_exercicis.md), amb exemples resolts i activitats per resoldre. També tens una [pràctica amb Sakila](./Exercicis/Sakila/11_subconsultes_exercicis.md).

Assumeix les següents taules:

**Taula Empleats:**
| id | nom    | cognom  | departament | salari | supervisor_id |
|----|--------|---------|-------------|--------|---------------|
| 1  | Anna   | Garcia  | Vendes      | 30000  | NULL          |
| 2  | Marc   | Lopez   | IT          | 45000  | 1             |
| 3  | Laura  | Martí   | IT          | 42000  | 1             |
| 4  | Pere   | Vila    | Vendes      | 32000  | 1             |
| 5  | Joan   | Puig    | Vendes      | 28000  | 4             |

**Taula Departaments:**
| id | nom        | pressupost |
|----|------------|------------|
| 1  | Vendes     | 150000     |
| 2  | IT         | 200000     |
| 3  | Màrqueting | 100000     |

**Exercicis:**

1. Troba els empleats que guanyen més que la mitjana de l'empresa

2. Troba els empleats del departament amb el pressupost més alt

3. Troba els empleats que guanyen més que el seu supervisor

4. Troba els departaments que NO tenen empleats

5. Troba l'empleat amb el salari més alt de cada departament

6. Compte quants empleats té cada departament (utilitzant subconsulta a SELECT)

7. Troba els empleats que guanyen més que TOTS els empleats del departament de Vendes

8. Troba els departaments on el salari mitjà dels empleats supera 35000

### Solucions

<details>
<summary>Fes clic per veure les solucions</summary>

```sql
-- 1. Empleats per sobre la mitjana
SELECT nom, cognom, salari
FROM Empleats
WHERE salari > (SELECT AVG(salari) FROM Empleats);

-- 2. Empleats del departament amb més pressupost
SELECT nom, cognom, departament
FROM Empleats
WHERE departament = (
    SELECT nom
    FROM Departaments
    ORDER BY pressupost DESC
    LIMIT 1
);

-- 3. Empleats que guanyen més que el seu supervisor
SELECT e1.nom, e1.cognom, e1.salari
FROM Empleats e1
WHERE e1.salari > (
    SELECT e2.salari
    FROM Empleats e2
    WHERE e2.id = e1.supervisor_id
);

-- 4. Departaments sense empleats
SELECT nom
FROM Departaments d
WHERE NOT EXISTS (
    SELECT 1
    FROM Empleats e
    WHERE e.departament = d.nom
);

-- 5. Empleat amb salari més alt per departament
SELECT nom, cognom, departament, salari
FROM Empleats e1
WHERE salari = (
    SELECT MAX(salari)
    FROM Empleats e2
    WHERE e2.departament = e1.departament
);

-- 6. Comptar empleats per departament amb subconsulta
SELECT 
    d.nom,
    (SELECT COUNT(*) 
     FROM Empleats e 
     WHERE e.departament = d.nom) AS num_empleats
FROM Departaments d;

-- 7. Empleats que guanyen més que TOTS els de Vendes
SELECT nom, cognom, salari
FROM Empleats
WHERE salari > ALL (
    SELECT salari
    FROM Empleats
    WHERE departament = 'Vendes'
);

-- 8. Departaments amb salari mitjà > 35000
SELECT nom
FROM Departaments d
WHERE 35000 < (
    SELECT AVG(salari)
    FROM Empleats e
    WHERE e.departament = d.nom
);
```

</details>

## Resum

En aquesta sessió hem après:

- Què són les **subconsultes** i quan utilitzar-les
- **Subconsultes escalars** (retornen un valor)
- **Subconsultes amb múltiples valors** (IN, ANY, ALL)
- **Subconsultes correlacionades** (fan referència a la consulta externa)
- Subconsultes a **FROM**, **SELECT** i **HAVING**
- L'operador **EXISTS** i **NOT EXISTS**
- Comparació entre **subconsultes i JOINs**
- **Consideracions de rendiment**
- **Errors comuns** i com evitar-los

Les subconsultes són una eina poderosa que permet resoldre problemes complexos de manera elegant. Combinades amb JOINs, GROUP BY i altres clàusules, permeten fer consultes molt sofisticades.

## Referències

- [PostgreSQL: expressions amb subconsultes, EXISTS, IN, ANY i ALL](https://www.postgresql.org/docs/current/functions-subquery.html).
- [PostgreSQL: SELECT i taules derivades](https://www.postgresql.org/docs/current/sql-select.html).
- [PostgreSQL: operacions amb dates](https://www.postgresql.org/docs/current/functions-datetime.html).

---

[Anterior: Àlgebra relacional III](./10_algebra_III.md) | [Següent: Unions i operacions avançades](./12_unions.md) | [Torna a l'índex](./readme.md)
