# Nivells d'aïllament

Els **nivells d'aïllament** (isolation levels) defineixen el grau en què una transacció s'aïlla de les modificacions fetes per altres transaccions concurrents. Com més alt és el nivell d'aïllament, més protecció contra problemes de concurrència, però també menys rendiment.

L'estàndard SQL defineix quatre nivells d'aïllament, i SQL Server n'afegeix un cinquè (SNAPSHOT).

---

## Comparativa dels nivells d'aïllament

| Nivell | Dirty Read | Non-Repeatable Read | Phantom Read | Rendiment |
|--------|------------|---------------------|--------------|-----------|
| READ UNCOMMITTED | ✅ Possible | ✅ Possible | ✅ Possible | ⚡⚡⚡⚡ Molt alt |
| READ COMMITTED | ❌ Evitat | ✅ Possible | ✅ Possible | ⚡⚡⚡ Alt |
| REPEATABLE READ | ❌ Evitat | ❌ Evitat | ✅ Possible | ⚡⚡ Mitjà |
| SERIALIZABLE | ❌ Evitat | ❌ Evitat | ❌ Evitat | ⚡ Baix |
| SNAPSHOT | ❌ Evitat | ❌ Evitat | ❌ Evitat | ⚡⚡⚡ Alt |

---

## 1. READ UNCOMMITTED

### Descripció

El nivell més **permissiu**. Permet llegir dades que altres transaccions han modificat però **encara no han confirmat** (COMMIT).

### Característiques

- ✅ Màxim rendiment
- ✅ No bloqueja altres transaccions
- ❌ Permet **Dirty Reads** (lectures brutes)
- ❌ Permet **Non-Repeatable Reads**
- ❌ Permet **Phantom Reads**

### Sintaxi a SQL Server

```sql
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
```

### Quan utilitzar-lo?

- Informes aproximats on la precisió no és crítica
- Consultes de monitoratge que no han de bloquejar
- Entorns de desenvolupament per a proves ràpides

### Exemple pràctic

```sql
-- Transacció A: Modifica però no confirma
BEGIN TRANSACTION
    UPDATE Productes SET preu = 999 WHERE id = 1;
    -- Encara no fem COMMIT...

-- Transacció B: Llegeix la dada "bruta"
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SELECT preu FROM Productes WHERE id = 1;
-- → Retorna 999 (encara que A no ha fet COMMIT!)

-- Si A fa ROLLBACK, B ha llegit un valor que mai va existir realment
```

## 2. READ COMMITTED

### Descripció

El nivell **per defecte** a SQL Server. Només permet llegir dades que han estat **confirmades** (COMMIT) per altres transaccions.

### Característiques

- ✅ Evita **Dirty Reads**
- ✅ Bon equilibri entre consistència i rendiment
- ❌ Permet **Non-Repeatable Reads**
- ❌ Permet **Phantom Reads**

### Sintaxi a SQL Server

```sql
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
```

### Com funciona?

Quan una transacció vol llegir una fila:
1. Comprova si la fila té un bloqueig exclusiu (d'una altra transacció)
2. Si sí → **espera** fins que l'altra transacció acabi
3. Si no → llegeix la dada

### Exemple: Evita Dirty Read

```
Temps    Transacció A                    Transacció B (READ COMMITTED)
─────    ────────────                    ─────────────────────────────
  1      BEGIN TRANSACTION               
         
  2      UPDATE Comptes                  
         SET saldo = 500                 
         WHERE id = 1                    
         -- Bloqueig exclusiu sobre la fila
                                         
  3                                      BEGIN TRANSACTION
                                         SELECT saldo FROM Comptes
                                         WHERE id = 1
                                         -- ⏳ ESPERA! La fila està bloquejada
                                         
  4      ROLLBACK                        
         -- Alliberem el bloqueig        
                                         
  5                                      -- Ara pot llegir
                                         → saldo = 1000 (valor original)
                                         -- ✅ No ha llegit la dada "bruta"
```

### Variant: READ COMMITTED SNAPSHOT

SQL Server ofereix una variant que utilitza versionat de files en lloc de bloquejos:

```sql
-- Activar a nivell de base de dades
ALTER DATABASE MevaDB SET READ_COMMITTED_SNAPSHOT ON;
```

Amb aquesta opció:
- Les lectures no bloquegen les escriptures
- Les escriptures no bloquegen les lectures
- Es llegeix l'última versió confirmada de la fila

---

## 3. REPEATABLE READ

### Descripció

Garanteix que si una transacció llegeix una fila, cap altra transacció pot **modificar** aquella fila fins que la primera acabi.

### Característiques

- ✅ Evita **Dirty Reads**
- ✅ Evita **Non-Repeatable Reads**
- ❌ Permet **Phantom Reads** (noves files poden aparèixer)
- ⚠️ Pot causar més bloquejos i esperes

### Sintaxi a SQL Server

```sql
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
```

### Com funciona?

- Manté **bloquejos compartits** sobre totes les files llegides
- Aquests bloquejos es mantenen fins al final de la transacció
- Altres transaccions no poden modificar aquestes files

### Exemple: Evita Non-Repeatable Read

```
Temps    Transacció A (REPEATABLE READ)     Transacció B
─────    ──────────────────────────────     ────────────
  1      BEGIN TRANSACTION                  
         
  2      SELECT saldo FROM Comptes          
         WHERE id = 1                       
         → saldo = 1000                     
         -- Bloqueig compartit mantingut    
                                            
  3                                         BEGIN TRANSACTION
                                            UPDATE Comptes
                                            SET saldo = 500
                                            WHERE id = 1
                                            -- ⏳ ESPERA! Fila bloquejada per A
                                            
  4      -- Segona lectura                  
         SELECT saldo FROM Comptes          
         WHERE id = 1                       
         → saldo = 1000                     
         -- ✅ Mateix valor! Lectura repetible
         
  5      COMMIT                             
         -- Alliberem bloquejos             
                                            
  6                                         -- Ara pot actualitzar
                                            → UPDATE completat
```

### ⚠️ Atenció amb Phantom Reads

```sql
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN TRANSACTION

    -- Primera lectura: 10 productes d'electrònica
    SELECT COUNT(*) FROM Productes WHERE categoria = 'Electrònica';
    -- → 10
    
    -- Una altra transacció INSEREIX un nou producte d'electrònica (COMMIT)
    
    -- Segona lectura: 11 productes!
    SELECT COUNT(*) FROM Productes WHERE categoria = 'Electrònica';
    -- → 11 (PHANTOM READ!)

COMMIT
```

REPEATABLE READ bloqueja les files **llegides**, però no impedeix que s'insereixin **noves** files.

---

## 4. SERIALIZABLE

### Descripció

El nivell més **restrictiu**. Les transaccions s'executen com si fossin completament **seqüencials**, una darrere l'altra.

### Característiques

- ✅ Evita **tots** els problemes de concurrència
- ✅ Màxima consistència
- ❌ Mínim rendiment
- ❌ Alt risc de **deadlocks**
- ❌ Pot bloquejar moltes transaccions

### Sintaxi a SQL Server

```sql
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
```

### Com funciona?

- Utilitza **bloquejos de rang** (range locks)
- Bloqueja no només les files llegides, sinó també el "rang" de valors
- Impedeix insercions que compleixin la condició de cerca

### Exemple: Evita Phantom Read

```
Temps    Transacció A (SERIALIZABLE)        Transacció B
─────    ───────────────────────────        ────────────
  1      BEGIN TRANSACTION                  
         
  2      SELECT * FROM Productes            
         WHERE categoria = 'Electrònica'    
         -- Bloqueig de rang sobre           
         -- categoria = 'Electrònica'       
                                            
  3                                         BEGIN TRANSACTION
                                            INSERT INTO Productes
                                            (nom, categoria)
                                            VALUES ('TV', 'Electrònica')
                                            -- ⏳ ESPERA! Rang bloquejat
                                            
  4      -- Segona lectura                  
         SELECT * FROM Productes            
         WHERE categoria = 'Electrònica'    
         -- ✅ Mateix nombre de files!      
         
  5      COMMIT                             
                                            
  6                                         -- Ara pot inserir
                                            COMMIT
```

### Quan utilitzar-lo?

- Operacions financeres crítiques
- Quan la consistència és absolutament prioritària
- Transaccions curtes i poc freqüents

### ⚠️ Riscos

```sql
-- Escenari de DEADLOCK potencial
-- Transacció A
BEGIN TRANSACTION
    SELECT * FROM Taula1 WHERE x = 1;  -- Bloqueig rang
    SELECT * FROM Taula2 WHERE y = 2;  -- Espera bloqueig de B

-- Transacció B (simultània)
BEGIN TRANSACTION
    SELECT * FROM Taula2 WHERE y = 2;  -- Bloqueig rang
    SELECT * FROM Taula1 WHERE x = 1;  -- Espera bloqueig de A
    
-- 💀 DEADLOCK! SQL Server cancel·larà una de les transaccions
```

---

## 5. SNAPSHOT (Específic de SQL Server)

### Descripció

Utilitza **versionat de files** per proporcionar una vista consistent de les dades **en el moment en què va començar la transacció**.

### Característiques

- ✅ Evita **tots** els problemes de concurrència
- ✅ Les lectures **no bloquegen** les escriptures
- ✅ Les escriptures **no bloquegen** les lectures
- ✅ Bon rendiment per a lectures
- ⚠️ Requereix espai addicional per versions (tempdb)
- ⚠️ Conflictes d'actualització possibles

### Activació

```sql
-- Pas 1: Activar a nivell de base de dades
ALTER DATABASE MevaDB SET ALLOW_SNAPSHOT_ISOLATION ON;

-- Pas 2: Utilitzar en una transacció
SET TRANSACTION ISOLATION LEVEL SNAPSHOT;
```

### Com funciona?

1. Quan comença una transacció, es "fotografia" l'estat de la BD
2. Totes les lectures veuen aquesta "foto", independentment dels canvis d'altres transaccions
3. SQL Server guarda versions anteriors de les files a **tempdb**

### Exemple visual

```
Temps    Transacció A (SNAPSHOT)            Transacció B
─────    ──────────────────────             ────────────
  1      BEGIN TRANSACTION                  
         -- 📸 Foto de la BD en aquest moment
         
  2      SELECT preu FROM Productes         
         WHERE id = 1                       
         → preu = 100                       
                                            
  3                                         BEGIN TRANSACTION
                                            UPDATE Productes
                                            SET preu = 200
                                            WHERE id = 1
                                            COMMIT
                                            
  4      -- Segona lectura                  
         SELECT preu FROM Productes         
         WHERE id = 1                       
         → preu = 100                       
         -- ✅ Veu la "foto" original!      
         -- No veu l'actualització de B     
         
  5      COMMIT                             
```

### Conflictes d'actualització

Si dues transaccions SNAPSHOT intenten modificar la mateixa fila:

```sql
-- Transacció A (SNAPSHOT)
BEGIN TRANSACTION
    UPDATE Productes SET preu = 150 WHERE id = 1;
    -- ✅ OK (si B no ha modificat)
    
-- Transacció B (SNAPSHOT) - simultània
BEGIN TRANSACTION
    UPDATE Productes SET preu = 200 WHERE id = 1;
    COMMIT
    
-- Transacció A
COMMIT
-- ❌ ERROR! Conflicte d'actualització
-- Msg 3960: Snapshot isolation transaction aborted due to update conflict
```

### Diferència amb SERIALIZABLE

| SERIALIZABLE | SNAPSHOT |
|--------------|----------|
| Usa bloquejos | Usa versions |
| Bloqueja altres transaccions | No bloqueja |
| Espera si hi ha conflicte | Falla si hi ha conflicte d'escriptura |
| Garanteix ordre seqüencial | Garanteix vista consistent |

---

## Resum visual

```
         Menys restrictiu ─────────────────────► Més restrictiu
         Més rendiment    ─────────────────────► Menys rendiment

┌──────────────────┬──────────────────┬──────────────────┬──────────────────┐
│ READ UNCOMMITTED │  READ COMMITTED  │ REPEATABLE READ  │   SERIALIZABLE   │
├──────────────────┼──────────────────┼──────────────────┼──────────────────┤
│                  │                  │                  │                  │
│  Dirty Read ✅   │  Dirty Read ❌   │  Dirty Read ❌   │  Dirty Read ❌   │
│  Non-Rep.   ✅   │  Non-Rep.   ✅   │  Non-Rep.   ❌   │  Non-Rep.   ❌   │
│  Phantom    ✅   │  Phantom    ✅   │  Phantom    ✅   │  Phantom    ❌   │
│                  │                  │                  │                  │
└──────────────────┴──────────────────┴──────────────────┴──────────────────┘

                              ┌──────────────────┐
                              │     SNAPSHOT     │
                              ├──────────────────┤
                              │  Dirty Read ❌   │
                              │  Non-Rep.   ❌   │
                              │  Phantom    ❌   │
                              │  (Via versions)  │
                              └──────────────────┘
```

---

## Guia ràpida: Quin nivell escollir?

| Escenari | Nivell recomanat |
|----------|------------------|
| Informes aproximats, estadístiques | READ UNCOMMITTED |
| Aplicacions web generals | READ COMMITTED |
| Operacions que requereixen dades estables | REPEATABLE READ |
| Transaccions financeres crítiques | SERIALIZABLE |
| Moltes lectures, poques escriptures | SNAPSHOT |
| Alta concurrència amb consistència | SNAPSHOT |

---

## Consultar el nivell actual

```sql
-- Veure el nivell d'aïllament de la sessió actual
DBCC USEROPTIONS;

-- O amb aquesta consulta
SELECT CASE transaction_isolation_level 
    WHEN 0 THEN 'Unspecified' 
    WHEN 1 THEN 'ReadUncommitted' 
    WHEN 2 THEN 'ReadCommitted' 
    WHEN 3 THEN 'Repeatable' 
    WHEN 4 THEN 'Serializable' 
    WHEN 5 THEN 'Snapshot' 
END AS IsolationLevel
FROM sys.dm_exec_sessions 
WHERE session_id = @@SPID;
```

---

## Exercici pràctic

Tria el nivell d'aïllament adequat per a cada escenari:

1. Una aplicació de xat que mostra el nombre d'usuaris connectats (no cal precisió exacta).

2. Un sistema bancari que processa transferències entre comptes.

3. Una botiga online que mostra l'estoc disponible (pot variar en temps real).

4. Un sistema de reserves de seients que no pot permetre duplicats.

5. Un sistema d'informes que genera balanços mensuals (les dades no han de canviar durant el procés).

<details>
<summary>Veure solucions</summary>

1. **READ UNCOMMITTED** - No importa si el nombre és exacte, prioritzem rendiment
2. **SERIALIZABLE** o **SNAPSHOT** - Màxima consistència per a diners
3. **READ COMMITTED** - Equilibri entre actualitat i rendiment
4. **SERIALIZABLE** - Cal evitar phantom reads i lost updates
5. **SNAPSHOT** o **REPEATABLE READ** - Vista consistent durant tot l'informe

</details>
