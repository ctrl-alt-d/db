# Indexos

## Introducció

El sistema gestor de base de dades (SGBD)  organitza les dades en taules, l'accés a les dades per clau primària és molt ràpid, perquè el SGBD crea una estructura anomenada índex per localitzar ràpidament les tuples a partir del valor de la clau primària. Seria com ho fa un índex d'un llibre.

Podem crear indexos per altres camps o combinacions de camps.

Imaginem una pizzeria que quan truquen els clients els localitza a la base de dades pel telèfon i d'aquesta manera ja té preparades les dades (adreça, nom del client, etc). La clau primària de client no serà el telèfon, però interessa localitzar-los ràpid. Llavors, mitjançant Data Definitio Language (DDL) creem un índex per aquest camp:

```sql
create index client_telefon_idx
on Client (Telefon)
```

## Pla d'accés a les dades

Anem a estudiar la diferència d'accés a les dades amb i sense índex.

### Creem la taula de clients

Creem la taula de clients, on el telèfon no té índex:

```sql
CREATE TABLE Client (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nom NVARCHAR(100) NOT NULL,
    Cognom NVARCHAR(100) NOT NULL,
    Telefon NVARCHAR(15) NOT NULL,
    Email NVARCHAR(200),
    Adreca NVARCHAR(300),
    DataAlta DATE DEFAULT GETDATE()
);
```

### Insertem 100.000 clients random

Insertem 100.000 clients amb dades aleatòries:

```sql
-- Insertem 100.000 clients amb dades random
DECLARE @i INT = 1;

WHILE @i <= 100000
BEGIN
    INSERT INTO Client (Nom, Cognom, Telefon, Email, Adreca)
    VALUES (
        CONCAT('Nom', @i),
        CONCAT('Cognom', @i),
        CONCAT('6', RIGHT('00000000' + CAST(ABS(CHECKSUM(NEWID())) % 100000000 AS VARCHAR), 8)),
        CONCAT('client', @i, '@email.com'),
        CONCAT('Carrer ', @i, ', ', (@i % 100) + 1)
    );
    SET @i = @i + 1;
END;
```


### Consulta sense índex

Ara fem una consulta a la taula per número de telèfon. Per veure el pla d'execució, a DBeaver fes clic a **Explain Execution Plan** (Ctrl+Shift+E) o afegeix `SET STATISTICS IO ON` abans de la consulta:

```sql
SET STATISTICS IO ON;

SELECT * 
FROM Client 
WHERE Telefon = '612345678';
```

O podem demanar el pla d'execució estimat:

Activem el `showplan`

```sql
SET SHOWPLAN_TEXT ON;
```

Fem la consulta:

```sql
SELECT * 
FROM Client 
WHERE Telefon = '612345678';
```

Desactivem el `showplan`


```sql
SET SHOWPLAN_TEXT OFF;
```

### Interpretació del resultat sense índex

Quan no hi ha índex pel camp `Telefon`, el SGBD ha de fer un **Table Scan** (o **Clustered Index Scan** si la taula té clau primària):

- **Table Scan / Clustered Index Scan**: El motor de base de dades recorre **TOTES** les files de la taula per trobar les que coincideixen amb el criteri de cerca.
- **Cost**: Molt alt quan la taula té moltes files (100.000 en el nostre cas).
- **Logical Reads**: Nombre de pàgines de dades llegides. Serà molt alt.

Exemple de sortida de `STATISTICS IO`:
```
Table 'Client'. Scan count 1, logical reads 1523, physical reads 0...
```

Això significa que ha hagut de llegir 1523 pàgines de dades per trobar un sol registre!

### Creem l'índex per telèfon

Ara creem un índex pel camp `Telefon`:

```sql
CREATE INDEX idx_client_telefon
ON Client (Telefon);
```

### Consulta amb índex

Repetim la mateixa consulta:

```sql
SET STATISTICS IO ON;

SELECT * 
FROM Client 
WHERE Telefon = '612345678';
```

### Interpretació del resultat amb índex

Ara el pla d'execució mostra un **Index Seek**:

- **Index Seek**: El motor utilitza l'índex per localitzar directament les files que compleixen el criteri, sense recórrer tota la taula.
- **Cost**: Molt més baix.
- **Logical Reads**: Molt menor (típicament 2-4 lectures).

Exemple de sortida de `STATISTICS IO`:
```
Table 'Client'. Scan count 1, logical reads 3, physical reads 0...
```

De 1523 lectures a només 3! Això representa una millora de rendiment enorme.

## Tipus d'índexs en SQL Server

### Índex Clustered (Agrupat)

L'índex clustered **ordena físicament** les dades de la taula segons l'índex. Només pot haver-hi **un** índex clustered per taula (normalment és la clau primària).

```sql
-- La clau primària crea automàticament un índex clustered
CREATE TABLE Producte (
    Id INT PRIMARY KEY CLUSTERED,  -- Índex clustered
    Nom NVARCHAR(100),
    Preu DECIMAL(10,2)
);
```

### Índex Non-Clustered (No agrupat)

L'índex non-clustered crea una estructura separada amb punters a les dades originals. Es poden tenir **múltiples** índexs non-clustered per taula.

```sql
-- Índex non-clustered (per defecte)
CREATE NONCLUSTERED INDEX idx_producte_nom
ON Producte (Nom);
```

### Índex Únic

Garanteix que no hi hagi valors duplicats en la columna indexada:

```sql
CREATE UNIQUE INDEX idx_client_email_unic
ON Client (Email);
```

### Índex Compost (múltiples columnes)

Útil quan les consultes filtren per diverses columnes:

```sql
CREATE INDEX idx_client_nom_cognom
ON Client (Nom, Cognom);
```

> ⚠️ **Important**: L'ordre de les columnes importa! Aquest índex serà eficient per cerques per `Nom` o per `Nom + Cognom`, però **no** per cerques només per `Cognom`.

### Índex amb columnes incloses

Permet incloure columnes addicionals a l'índex per evitar haver d'accedir a la taula (cobertura de l'índex):

```sql
CREATE INDEX idx_client_telefon_cobert
ON Client (Telefon)
INCLUDE (Nom, Cognom, Email);
```

Amb aquest índex, la consulta següent es resol completament des de l'índex:

```sql
SELECT Nom, Cognom, Email 
FROM Client 
WHERE Telefon = '612345678';
```

## Gestió d'índexs

### Llistar índexs d'una taula

```sql
SELECT 
    i.name AS NomIndex,
    i.type_desc AS TipusIndex,
    i.is_unique AS EsUnic,
    COL_NAME(ic.object_id, ic.column_id) AS Columna
FROM sys.indexes i
INNER JOIN sys.index_columns ic 
    ON i.object_id = ic.object_id AND i.index_id = ic.index_id
WHERE i.object_id = OBJECT_ID('Client')
ORDER BY i.name, ic.key_ordinal;
```

### Eliminar un índex

```sql
DROP INDEX idx_client_telefon ON Client;
```

### Reconstruir un índex

Els índexs es fragmenten amb el temps. Per millorar el rendiment:

```sql
-- Reconstruir un índex específic
ALTER INDEX idx_client_telefon ON Client REBUILD;

-- Reconstruir tots els índexs d'una taula
ALTER INDEX ALL ON Client REBUILD;
```

## Quan crear índexs?

### ✅ Crear índexs quan:

- La columna s'utilitza freqüentment en clàusules `WHERE`
- La columna s'utilitza en `JOIN` entre taules
- La columna s'utilitza en `ORDER BY` o `GROUP BY`
- La taula té molts registres i les consultes retornen pocs resultats
- La columna té alta selectivitat (molts valors diferents)

### ❌ Evitar índexs quan:

- La taula és petita (pocs registres)
- La columna té poca selectivitat (pocs valors diferents, ex: "Sexe")
- La taula té moltes operacions d'escriptura (`INSERT`, `UPDATE`, `DELETE`)
- La columna es modifica freqüentment

## Impacte dels índexs

| Operació | Sense índex | Amb índex |
|----------|-------------|-----------|
| SELECT (cerca) | Lent ❌ | Ràpid ✅ |
| INSERT | Ràpid ✅ | Més lent ❌ |
| UPDATE | Variable | Variable |
| DELETE | Lent ❌ | Ràpid ✅ |
| Espai en disc | Menys | Més |

> 💡 **Consell**: Els índexs milloren les lectures però penalitzen les escriptures. Cal trobar un equilibri segons les necessitats de l'aplicació.

## Exercicis pràctics

### Exercici 1
Crea una taula `Comanda` amb els camps `Id`, `ClientId`, `Data`, `Total` i `Estat`. Crea els índexs que consideris adequats per a les consultes típiques d'una botiga.

### Exercici 2

Primer, creem les taules `Clients` i `Comandes`:

```sql
-- Taula de Clients
CREATE TABLE Clients (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nom NVARCHAR(100) NOT NULL,
    Cognom NVARCHAR(100) NOT NULL,
    Email NVARCHAR(200),
    Telefon NVARCHAR(15),
    DataAlta DATE DEFAULT GETDATE()
);

-- Taula de Comandes
CREATE TABLE Comandes (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    ClientId INT NOT NULL,
    Data DATE NOT NULL,
    Total DECIMAL(10,2) NOT NULL,
    Estat NVARCHAR(20) DEFAULT 'Pendent',
    FOREIGN KEY (ClientId) REFERENCES Clients(Id)
);
```

Ara inserim 10.000 registres aleatoris:

```sql
-- Insertem 1.000 clients aleatoris
DECLARE @i INT = 1;

WHILE @i <= 1000
BEGIN
    INSERT INTO Clients (Nom, Cognom, Email, Telefon)
    VALUES (
        CONCAT('Nom', @i),
        CONCAT('Cognom', ABS(CHECKSUM(NEWID())) % 500),
        CONCAT('client', @i, '@email.com'),
        CONCAT('6', RIGHT('00000000' + CAST(ABS(CHECKSUM(NEWID())) % 100000000 AS VARCHAR), 8))
    );
    SET @i = @i + 1;
END;

-- Insertem 10.000 comandes aleatòries
SET @i = 1;

WHILE @i <= 10000
BEGIN
    INSERT INTO Comandes (ClientId, Data, Total, Estat)
    VALUES (
        (ABS(CHECKSUM(NEWID())) % 1000) + 1,  -- ClientId aleatori entre 1 i 1000
        DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 730, GETDATE()),  -- Data dels últims 2 anys
        CAST((ABS(CHECKSUM(NEWID())) % 50000) / 100.0 + 10 AS DECIMAL(10,2)),  -- Total entre 10 i 510€
        CASE ABS(CHECKSUM(NEWID())) % 4
            WHEN 0 THEN 'Pendent'
            WHEN 1 THEN 'Enviat'
            WHEN 2 THEN 'Entregat'
            ELSE 'Cancel·lat'
        END
    );
    SET @i = @i + 1;
END;
```

Ara executa la consulta següent amb i sense índex i compara els plans d'execució:

```sql
SELECT c.Nom, c.Cognom, COUNT(*) as NumComandes
FROM Clients c
INNER JOIN Comandes co ON c.Id = co.ClientId
WHERE co.Data >= '2025-01-01'
GROUP BY c.Nom, c.Cognom
ORDER BY NumComandes DESC;
```

Pensa si pots crear indexos compostos que millorin aquesta consulta.

## Resum

- Els **índexs** acceleren les consultes de lectura però penalitzen les escriptures.
- L'índex **clustered** ordena físicament les dades (només 1 per taula).
- Els índexs **non-clustered** creen estructures separades (es poden tenir múltiples).
- Utilitza **EXPLAIN** o **STATISTICS IO** per analitzar el rendiment de les consultes.
- Crea índexs en columnes utilitzades en `WHERE`, `JOIN`, `ORDER BY` i `GROUP BY`.
- No abusis dels índexs: cada índex ocupa espai i penalitza les escriptures

## L'estructura B-Tree

Els índexs a SQL Server (i la majoria de SGBD relacionals) utilitzen una estructura de dades anomenada **B-Tree** (Balanced Tree o Arbre Equilibrat). Entendre aquesta estructura ens ajuda a comprendre per què els índexs són tan eficients.

### Què és un B-Tree?

Un B-Tree és una estructura de dades en forma d'arbre que manté les dades **ordenades** i permet cerques, insercions i eliminacions en temps logarítmic $O(\log n)$.

```
                    [50]                     ← Node arrel
                   /    \
            [20,30]      [70,80]             ← Nodes intermedis
           /   |   \    /   |   \
        [10] [25] [35] [60] [75] [90]        ← Nodes fulla (dades)
```

### Components del B-Tree

| Component | Descripció |
|-----------|------------|
| **Node arrel** | El node superior de l'arbre. Punt d'entrada per a totes les cerques. |
| **Nodes intermedis** | Contenen claus i punters als nodes fills. Guien la cerca. |
| **Nodes fulla** | Contenen les dades reals o punters a les files de la taula. |
| **Claus** | Valors de la columna indexada que determinen l'ordre. |
| **Punters** | Referències als nodes fills o a les dades de la taula. |

### Com funciona una cerca?

Quan busquem el valor **75** en l'arbre anterior:

1. **Comencem per l'arrel** [50]: 75 > 50, anem a la dreta
2. **Node intermedi** [70,80]: 70 < 75 < 80, anem al fill del mig
3. **Node fulla** [75]: Trobat! ✅

Només hem necessitat **3 passos** per trobar el valor entre potencialment milions de registres!

### Per què B-Tree és eficient?

#### Complexitat logarítmica

En un B-Tree, el nombre de passos per trobar un valor és proporcional a l'**altura de l'arbre**, que creix de forma logarítmica:

| Registres | Passos màxims (aprox.) |
|-----------|------------------------|
| 1.000 | 3-4 |
| 100.000 | 5-6 |
| 10.000.000 | 7-8 |
| 1.000.000.000 | 9-10 |

Amb només **10 lectures** podem trobar un registre entre **mil milions**!

#### Arbre equilibrat

El "B" de B-Tree significa **Balanced** (equilibrat). L'arbre es manté sempre equilibrat automàticament:
- Totes les fulles estan al mateix nivell
- No hi ha branques molt més llargues que altres
- Això garanteix un rendiment consistent

### B-Tree vs Índex Clustered i Non-Clustered

#### Índex Clustered (B-Tree amb dades)

En un índex clustered, els **nodes fulla contenen les dades reals** de la taula:

```
                    [50]
                   /    \
            [20,30]      [70,80]
           /   |   \    /   |   \
      [Fila] [Fila] [Fila] [Fila] [Fila] [Fila]
       10     25     35     60     75     90
      (totes les columnes de la taula)
```

#### Índex Non-Clustered (B-Tree amb punters)

En un índex non-clustered, els **nodes fulla contenen punters** (RID o clau clustered):

```
                    [50]
                   /    \
            [20,30]      [70,80]
           /   |   \    /   |   \
      [10→RID] [25→RID] ... [75→RID] [90→RID]
         ↓        ↓           ↓         ↓
      (punter a la fila real de la taula)
```

### Operacions i el seu impacte en el B-Tree

#### INSERT

Quan inserim un nou valor:
1. Es busca la posició correcta al node fulla
2. S'insereix el valor mantenint l'ordre
3. Si el node es desborda, es **divideix** (split) i es propaga cap amunt

```sql
-- Aquesta operació pot causar divisió de nodes
INSERT INTO Client (Telefon, ...) VALUES ('655555555', ...);
```

#### DELETE

Quan eliminem un valor:
1. Es localitza el valor al node fulla
2. S'elimina
3. Si el node queda massa buit, es **fusiona** amb un veí

```sql
-- Pot causar fusió de nodes
DELETE FROM Client WHERE Telefon = '655555555';
```

#### UPDATE de la columna indexada

És l'operació més costosa:
1. DELETE del valor antic
2. INSERT del valor nou

```sql
-- Equivalent a DELETE + INSERT a l'índex
UPDATE Client SET Telefon = '699999999' WHERE Telefon = '655555555';
```

### Fragmentació del B-Tree

Amb el temps, les operacions INSERT i DELETE causen **fragmentació**:

- **Fragmentació interna**: Pàgines mig buides per eliminacions
- **Fragmentació externa**: Pàgines fora d'ordre al disc

#### Detectar la fragmentació

```sql
SELECT 
    OBJECT_NAME(ips.object_id) AS Taula,
    i.name AS Index_Name,
    ips.avg_fragmentation_in_percent AS Fragmentacio,
    ips.page_count AS Pagines
FROM sys.dm_db_index_physical_stats(
    DB_ID(), 
    NULL, 
    NULL, 
    NULL, 
    'LIMITED'
) ips
INNER JOIN sys.indexes i 
    ON ips.object_id = i.object_id AND ips.index_id = i.index_id
WHERE ips.avg_fragmentation_in_percent > 10
ORDER BY ips.avg_fragmentation_in_percent DESC;
```

#### Solucionar la fragmentació

| Fragmentació | Acció recomanada |
|--------------|------------------|
| < 10% | No cal fer res |
| 10% - 30% | `REORGANIZE` |
| > 30% | `REBUILD` |

```sql
-- Reorganitzar (menys intensiu, online)
ALTER INDEX idx_client_telefon ON Client REORGANIZE;

-- Reconstruir (més intensiu, pot bloquejar)
ALTER INDEX idx_client_telefon ON Client REBUILD;
```

### Visualització pràctica

Podem veure l'estructura interna d'un índex amb la funció no documentada `DBCC IND`:

```sql
-- Mostra les pàgines d'un índex
DBCC IND('NomBaseDades', 'Client', 1);  -- 1 = índex clustered
```

O amb més detall:

```sql
-- Estadístiques de l'índex
DBCC SHOW_STATISTICS('Client', 'idx_client_telefon');
```

### Resum del B-Tree

| Concepte | Descripció |
|----------|------------|
| **Estructura** | Arbre equilibrat amb nodes arrel, intermedis i fulla |
| **Eficiència** | Cerca en $O(\log n)$ - molt pocs accessos a disc |
| **Clustered** | Les fulles contenen les dades reals |
| **Non-clustered** | Les fulles contenen punters a les dades |
| **Fragmentació** | Es produeix amb INSERT/DELETE, cal mantenir |
| **Manteniment** | REORGANIZE (lleu) o REBUILD (intens) |

> 💡 **Curiositat**: El B-Tree va ser inventat el 1970 per Rudolf Bayer i Edward McCreight als laboratoris de Boeing. Encara avui, més de 50 anys després, continua sent l'estructura de dades més utilitzada per als índexs de bases de dades. Més informació [Arbre-B]https://ca.wikipedia.org/wiki/Arbre-B)

