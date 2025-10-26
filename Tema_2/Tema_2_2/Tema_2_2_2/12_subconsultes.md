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

La subconsulta va entre parèntesis i s'executa abans que la consulta principal.

## Tipus de subconsultes

### 1. Subconsultes que retornen un sol valor (escalar)

Aquestes subconsultes retornen un únic valor i es poden utilitzar amb operadors de comparació (`=`, `>`, `<`, etc.).

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
SELECT nom, cognom
FROM Clients
WHERE id IN (SELECT client_id FROM Comandes);
```

**Equivalent amb JOIN:**
```sql
SELECT DISTINCT c.nom, c.cognom
FROM Clients c
INNER JOIN Comandes co ON c.id = co.client_id;
```

#### Exemple: Productes de categories específiques

```sql
-- Trobar productes de categories amb més de 10 productes
SELECT nom, categoria_id
FROM Productes
WHERE categoria_id IN (
    SELECT id
    FROM Categories
    WHERE (SELECT COUNT(*) FROM Productes WHERE categoria_id = Categories.id) > 10
);
```

#### Operador ANY

Comprova si la condició és certa per ALMENYS UN dels valors retornats.

```sql
-- Trobar productes més cars que QUALSEVOL producte de la categoria 'Ofertes'
SELECT nom, preu
FROM Productes
WHERE preu > ANY (
    SELECT preu
    FROM Productes
    WHERE categoria = 'Ofertes'
);
```

Això és equivalent a ser més car que el producte MÉS BARAT de 'Ofertes'.

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

Això és equivalent a ser més car que el producte MÉS CAR de 'Ofertes'.

### 3. Subconsultes correlacionades

Una subconsulta correlacionada fa referència a columnes de la consulta externa. S'executa una vegada per cada fila de la consulta externa.

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

### 4. Subconsultes a la clàusula FROM

Les subconsultes poden actuar com a taules temporals.

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

**Important:** Quan utilitzem una subconsulta a FROM, hem de donar-li un àlies.

#### Exemple complex: Vendes per trimestre

```sql
SELECT trimestre, SUM(total) AS vendes_totals
FROM (
    SELECT 
        CASE 
            WHEN MONTH(data) BETWEEN 1 AND 3 THEN 'Q1'
            WHEN MONTH(data) BETWEEN 4 AND 6 THEN 'Q2'
            WHEN MONTH(data) BETWEEN 7 AND 9 THEN 'Q3'
            ELSE 'Q4'
        END AS trimestre,
        import AS total
    FROM Comandes
) AS comandes_per_trimestre
GROUP BY trimestre;
```

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

## Comparació: Subconsultes vs JOINs

Moltes subconsultes es poden reescriure amb JOINs i viceversa.

### Exemple: Mateix resultat amb ambdós mètodes

**Amb subconsulta:**
```sql
SELECT nom, cognom
FROM Clients
WHERE id IN (SELECT client_id FROM Comandes);
```

**Amb JOIN:**
```sql
SELECT DISTINCT c.nom, c.cognom
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
WHERE raça = (
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
WHERE g1.data_naixement < (
    SELECT AVG(g2.data_naixement)
    FROM gossos g2
    WHERE g2.raça = g1.raça
);
```

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
WHERE categoria = (
    SELECT categoria
    FROM Productes
    WHERE preu = (
        SELECT MAX(preu)
        FROM Productes
    )
);
```

## Consideracions de rendiment

1. **Les subconsultes correlacionades** poden ser lentes perquè s'executen múltiples vegades
2. En molts casos, els **JOINs són més eficients** que les subconsultes
3. Utilitzar **EXISTS** en lloc de **IN** pot ser més ràpid amb grans volums de dades
4. Amb **PostgreSQL i MySQL moderns**, l'optimitzador sovint converteix subconsultes en JOINs automàticament

### Optimització: EXISTS vs IN

**Menys eficient amb moltes dades:**
```sql
SELECT nom FROM Clients
WHERE id IN (SELECT client_id FROM Comandes);
```

**Més eficient:**
```sql
SELECT nom FROM Clients c
WHERE EXISTS (SELECT 1 FROM Comandes co WHERE co.client_id = c.id);
```

## Errors comuns

### ❌ Error 1: Subconsulta retorna més d'un valor

```sql
-- ERROR si hi ha més d'un empleat amb salari màxim
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

### ❌ Error 2: Oblidar l'àlies en subconsulta a FROM

```sql
-- ERROR: falta àlies
SELECT categoria, preu_mitjà
FROM (SELECT categoria, AVG(preu) AS preu_mitjà FROM Productes GROUP BY categoria);
```

**Solució:**
```sql
SELECT categoria, preu_mitjà
FROM (SELECT categoria, AVG(preu) AS preu_mitjà FROM Productes GROUP BY categoria) AS t;
```

### ❌ Error 3: Comparar amb NULL incorrectament

```sql
-- NO funciona si la subconsulta retorna NULL
WHERE columna = (SELECT ... );
```

**Solució:** Utilitzar IS NULL o COALESCE
```sql
WHERE columna = COALESCE((SELECT ... ), valor_per_defecte);
```

## Exercicis pràctics

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

---

[Anterior: Àlgebra relacional III](./11_algebra_III.md) | [Següent: Unions i operacions avançades](./13_unions.md) | [Torna a l'índex](./readme.md)
