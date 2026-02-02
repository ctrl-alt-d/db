# Vistes

## Introducció

Una **vista** és una taula virtual basada en el resultat d'una consulta SQL. No emmagatzema dades físicament (excepte les vistes materialitzades), sinó que guarda la definició de la consulta i l'executa cada vegada que s'accedeix a la vista.

Podem pensar en una vista com una "consulta guardada amb nom" que es comporta com si fos una taula.

```sql
-- Crear una vista senzilla
CREATE VIEW vw_ClientsActius AS
SELECT Id, Nom, Cognom, Email
FROM Client
WHERE Actiu = 1;
```

Ara podem consultar la vista com si fos una taula:

```sql
SELECT * FROM vw_ClientsActius;
```

## Per què utilitzar vistes?

### 1. Simplificar consultes complexes

En lloc de repetir una consulta complexa amb múltiples JOINs:

```sql
-- Sense vista: consulta complexa que es repeteix
SELECT 
    c.Nom, c.Cognom,
    co.Data, co.Total,
    p.Nom AS Producte
FROM Client c
INNER JOIN Comanda co ON c.Id = co.ClientId
INNER JOIN LiniaComanda lc ON co.Id = lc.ComandaId
INNER JOIN Producte p ON lc.ProducteId = p.Id
WHERE co.Data >= DATEADD(MONTH, -1, GETDATE());
```

Creem una vista i la reutilitzem:

```sql
-- Amb vista: encapsulem la complexitat
CREATE VIEW vw_ComandesRecents AS
SELECT 
    c.Nom, c.Cognom,
    co.Data, co.Total,
    p.Nom AS Producte
FROM Client c
INNER JOIN Comanda co ON c.Id = co.ClientId
INNER JOIN LiniaComanda lc ON co.Id = lc.ComandaId
INNER JOIN Producte p ON lc.ProducteId = p.Id
WHERE co.Data >= DATEADD(MONTH, -1, GETDATE());

-- Ara la consulta és simple
SELECT * FROM vw_ComandesRecents WHERE Total > 100;
```

### 2. Seguretat i control d'accés

Les vistes permeten mostrar només certes columnes o files als usuaris:

```sql
-- Vista que oculta informació sensible
CREATE VIEW vw_EmpleatsPublic AS
SELECT Id, Nom, Cognom, Departament, Email
FROM Empleat;
-- Nota: no inclou Salari, DNI, DataNaixement...

-- Donem accés només a la vista
GRANT SELECT ON vw_EmpleatsPublic TO rol_consulta;
```

### 3. Abstracció de l'esquema

Si canvia l'estructura de les taules, podem mantenir la vista igual:

```sql
-- Abans: una taula Client
-- Després: dues taules ClientPersona i ClientEmpresa

-- La vista manté la compatibilitat
CREATE VIEW vw_Clients AS
SELECT Id, Nom, Email, 'Persona' AS Tipus FROM ClientPersona
UNION ALL
SELECT Id, RaoSocial AS Nom, Email, 'Empresa' AS Tipus FROM ClientEmpresa;
```

### 4. Càlculs predefinits

```sql
CREATE VIEW vw_ProductesAmbIVA AS
SELECT 
    Id,
    Nom,
    Preu AS PreuSenseIVA,
    Preu * 1.21 AS PreuAmbIVA,
    Stock,
    Preu * Stock AS ValorStock
FROM Producte;
```

## Sintaxi completa

### Crear una vista

```sql
CREATE VIEW nom_vista
AS
SELECT columnes
FROM taules
WHERE condicions;
```

### Crear o modificar (si existeix)

```sql
CREATE OR ALTER VIEW vw_ClientsVIP AS
SELECT Id, Nom, Cognom, Email, TotalCompres
FROM Client
WHERE TotalCompres > 10000;
```

### Modificar una vista existent

```sql
ALTER VIEW vw_ClientsVIP AS
SELECT Id, Nom, Cognom, Email, Telefon, TotalCompres
FROM Client
WHERE TotalCompres > 5000;  -- Canviem el llindar
```

### Eliminar una vista

```sql
DROP VIEW vw_ClientsVIP;

-- Amb comprovació d'existència
DROP VIEW IF EXISTS vw_ClientsVIP;
```

## Vistes actualitzables

Algunes vistes permeten operacions INSERT, UPDATE i DELETE. Per ser actualitzable, una vista ha de complir:

### Requisits per a vistes actualitzables

| Requisit | Descripció |
|----------|------------|
| Una sola taula | No pot tenir JOINs |
| Sense agregacions | No pot tenir SUM, COUNT, AVG, etc. |
| Sense DISTINCT | No pot eliminar duplicats |
| Sense GROUP BY | No pot agrupar dades |
| Sense subconsultes | Al SELECT ni al FROM |
| Columnes directes | No expressions calculades |

### Exemple de vista actualitzable

```sql
CREATE VIEW vw_ClientsBarcelona AS
SELECT Id, Nom, Cognom, Email, Ciutat
FROM Client
WHERE Ciutat = 'Barcelona'
WITH CHECK OPTION;

-- Podem inserir
INSERT INTO vw_ClientsBarcelona (Nom, Cognom, Email, Ciutat)
VALUES ('Joan', 'Garcia', 'joan@email.com', 'Barcelona');

-- Podem actualitzar
UPDATE vw_ClientsBarcelona
SET Email = 'joan.garcia@email.com'
WHERE Id = 1;

-- Podem eliminar
DELETE FROM vw_ClientsBarcelona WHERE Id = 1;
```


### WITH CHECK OPTION

Assegura que les operacions INSERT/UPDATE a través de la vista compleixin la condició WHERE:

```sql
CREATE VIEW vw_ProductesBarats AS
SELECT Id, Nom, Preu
FROM Producte
WHERE Preu < 50
WITH CHECK OPTION;

-- Això funcionarà:
INSERT INTO vw_ProductesBarats (Nom, Preu) VALUES ('Ratolí', 25);

-- Això fallarà (preu >= 50):
INSERT INTO vw_ProductesBarats (Nom, Preu) VALUES ('Teclat', 75);
-- Error: The attempted insert or update failed because the target view 
-- either specifies WITH CHECK OPTION...
```

### Vistes no actualitzables

```sql
-- Aquesta vista NO és actualitzable (té JOIN i agregació)
CREATE VIEW vw_ResumVendes AS
SELECT 
    c.Nom AS Client,
    COUNT(*) AS NumComandes,
    SUM(co.Total) AS TotalVendes
FROM Client c
INNER JOIN Comanda co ON c.Id = co.ClientId
GROUP BY c.Nom;

-- Això fallarà:
UPDATE vw_ResumVendes SET TotalVendes = 1000 WHERE Client = 'Joan';
-- Error: View or function 'vw_ResumVendes' is not updatable...
```

## Vistes indexades (materialitzades)

Les **vistes indexades** emmagatzemen físicament el resultat de la consulta. Són útils per a consultes complexes que s'executen freqüentment.

## Exercicis pràctics

### Exercici 1: Vista simple
Crea una vista `vw_ProductesSenseStock` que mostri els productes amb stock igual a 0.

### Exercici 2: Vista amb JOIN
Crea una vista `vw_ComandesDetall` que mostri les comandes amb el nom del client i el total de línies.

### Exercici 3: Vista actualitzable
Crea una vista `vw_ClientsGirona` que mostri els clients de Girona i permeti inserir nous clients (amb CHECK OPTION).

### Exercici 4: Vista indexada
Crea una vista indexada `vw_VendesPerCategoria` que mostri el total de vendes per categoria de producte.

## Resum

| Concepte | Descripció |
|----------|------------|
| **Vista** | Taula virtual basada en una consulta |
| **Avantatges** | Simplifica consultes, seguretat, abstracció |
| **CREATE VIEW** | Crea una nova vista |
| **ALTER VIEW** | Modifica una vista existent |
| **DROP VIEW** | Elimina una vista |
| **SCHEMABINDING** | Vincula la vista a l'esquema |
| **CHECK OPTION** | Valida INSERT/UPDATE contra el WHERE |
| **Vista indexada** | Emmagatzema físicament el resultat |
| **Actualitzable** | Vista que permet INSERT/UPDATE/DELETE |

> 💡 **Consell final**: Les vistes són una eina potent per organitzar i protegir les dades. Utilitza-les per simplificar l'accés a dades complexes i per implementar polítiques de seguretat a nivell de files i columnes.
