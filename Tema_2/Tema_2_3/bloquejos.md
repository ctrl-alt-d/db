# Bloquejos (Locks)

Els **bloquejos** són el mecanisme principal que utilitzen els SGBD per gestionar l'accés concurrent a les dades. Quan una transacció accedeix a una dada, el sistema pot col·locar un bloqueig per controlar com altres transaccions poden interactuar amb aquesta dada.

---

## Per què necessitem bloquejos?

Sense bloquejos, múltiples transaccions podrien modificar les mateixes dades simultàniament, causant:
- Pèrdua d'actualitzacions
- Lectures inconsistents
- Corrupció de dades

Els bloquejos actuen com a "semàfors" que regulen l'accés a les dades.

---

## Tipus de bloquejos

### 1. Bloqueig compartit (Shared Lock - S)

- S'utilitza per a operacions de **lectura** (`SELECT`)
- **Múltiples** transaccions poden tenir bloqueigs compartits sobre la mateixa dada
- Impedeix que altres transaccions **modifiquin** la dada mentre es llegeix

```
Transacció A: SELECT → Bloqueig S ✅
Transacció B: SELECT → Bloqueig S ✅  (Compatible!)
Transacció C: UPDATE → ⏳ Espera (No pot obtenir bloqueig X)
```

### 2. Bloqueig exclusiu (Exclusive Lock - X)

- S'utilitza per a operacions d'**escriptura** (`INSERT`, `UPDATE`, `DELETE`)
- Només **una** transacció pot tenir un bloqueig exclusiu sobre una dada
- Impedeix qualsevol altra operació (lectura o escriptura)

```
Transacció A: UPDATE → Bloqueig X ✅
Transacció B: SELECT → ⏳ Espera (No pot obtenir bloqueig S)
Transacció C: UPDATE → ⏳ Espera (No pot obtenir bloqueig X)
```

### 3. Bloqueig d'actualització (Update Lock - U)

- Bloqueig intermedi per a operacions que **llegeixen i després escriuen**
- Evita un tipus específic de deadlock
- Es converteix en bloqueig exclusiu (X) quan comença l'escriptura

```sql
-- Escenari típic d'ús
SELECT * FROM Productes WITH (UPDLOCK) WHERE id = 1;
-- Bloqueig U: altres poden llegir, però no poden obtenir U ni X
UPDATE Productes SET preu = 100 WHERE id = 1;
-- El bloqueig U es converteix en X
```

### Matriu de compatibilitat

| Bloqueig existent | S (Compartit) | U (Actualització) | X (Exclusiu) |
|-------------------|---------------|-------------------|--------------|
| **S (Compartit)** | ✅ Compatible | ✅ Compatible | ❌ Incompatible |
| **U (Actualització)** | ✅ Compatible | ❌ Incompatible | ❌ Incompatible |
| **X (Exclusiu)** | ❌ Incompatible | ❌ Incompatible | ❌ Incompatible |

---

## Granularitat dels bloquejos

Els bloquejos es poden aplicar a diferents nivells:

```
┌─────────────────────────────────────────────┐
│               BASE DE DADES                 │  ← Menys concurrent
├─────────────────────────────────────────────┤
│                  TAULA                      │
├─────────────────────────────────────────────┤
│                 PÀGINA                      │
│            (8KB de dades)                   │
├─────────────────────────────────────────────┤
│                  FILA                       │  ← Més concurrent
└─────────────────────────────────────────────┘
```

| Granularitat | Avantatge | Desavantatge |
|--------------|-----------|--------------|
| **Base de dades** | Menys overhead | Bloqueja tot |
| **Taula** | Simple | Baixa concurrència |
| **Pàgina** | Equilibrat | Pot bloquejar files no necessàries |
| **Fila** | Alta concurrència | Més overhead de gestió |

SQL Server decideix automàticament la granularitat, però pot fer **lock escalation** (passar de bloquejos de fila a taula si n'hi ha molts).

---

## Bloquejos explícits a SQL Server

### Hints de bloqueig en SELECT

```sql
-- Sense bloqueig (dirty read possible)
SELECT * FROM Productes WITH (NOLOCK);

-- Bloqueig compartit mantingut fins al final de la transacció
SELECT * FROM Productes WITH (HOLDLOCK);

-- Bloqueig d'actualització (per a read-then-update)
SELECT * FROM Productes WITH (UPDLOCK);

-- Bloqueig exclusiu en lectura
SELECT * FROM Productes WITH (XLOCK);

-- Bloqueig de taula
SELECT * FROM Productes WITH (TABLOCK);

-- Bloqueig exclusiu de taula
SELECT * FROM Productes WITH (TABLOCKX);
```

### Exemple pràctic: Evitar Lost Update

```sql
BEGIN TRANSACTION

    -- Sense UPDLOCK: risc de Lost Update
    -- SELECT estoc FROM Productes WHERE id = 1;
    
    -- Amb UPDLOCK: segur
    SELECT estoc FROM Productes WITH (UPDLOCK) WHERE id = 1;
    
    -- Altres transaccions no poden llegir per actualitzar
    -- mentre nosaltres processem
    
    UPDATE Productes SET estoc = estoc - 1 WHERE id = 1;

COMMIT
```

---

## Deadlocks

### Què és un deadlock?

Un **deadlock** (bloqueig mutu) es produeix quan dues o més transaccions s'esperen mútuament, creant un cicle sense sortida.

```
┌─────────────┐         ┌─────────────┐
│Transacció A │         │Transacció B │
│             │         │             │
│ Té bloqueig │         │ Té bloqueig │
│   sobre X   │         │   sobre Y   │
│             │         │             │
│   Espera    │────────►│             │
│   bloqueig  │         │   Espera    │
│   sobre Y   │◄────────│   bloqueig  │
│             │         │   sobre X   │
└─────────────┘         └─────────────┘
      💀 DEADLOCK! Cap transacció pot avançar
```

### Exemple de deadlock

```sql
-- Transacció A
BEGIN TRANSACTION
    UPDATE Comptes SET saldo = saldo - 100 WHERE id = 1;  -- Bloqueig X sobre compte 1
    WAITFOR DELAY '00:00:05';  -- Simula processament
    UPDATE Comptes SET saldo = saldo + 100 WHERE id = 2;  -- Espera bloqueig sobre compte 2

-- Transacció B (simultània)
BEGIN TRANSACTION
    UPDATE Comptes SET saldo = saldo - 50 WHERE id = 2;   -- Bloqueig X sobre compte 2
    WAITFOR DELAY '00:00:05';  -- Simula processament
    UPDATE Comptes SET saldo = saldo + 50 WHERE id = 1;   -- Espera bloqueig sobre compte 1

-- 💀 DEADLOCK!
-- A té compte 1, espera compte 2
-- B té compte 2, espera compte 1
```

### Com detecta SQL Server els deadlocks?

SQL Server té un procés anomenat **Lock Monitor** que:
1. Comprova periòdicament si hi ha cicles de bloquejos
2. Quan detecta un deadlock, tria una "víctima" (normalment la transacció més barata de revertir)
3. Fa `ROLLBACK` automàtic de la víctima
4. Retorna l'error 1205 a l'aplicació

```sql
-- Error típic de deadlock
Msg 1205, Level 13, State 51, Line X
Transaction (Process ID XX) was deadlocked on lock resources with another process 
and has been chosen as the deadlock victim. Rerun the transaction.
```

---

## Com evitar deadlocks

### 1. Accedir als recursos en el mateix ordre

```sql
-- ❌ MAL: Ordre diferent
-- Transacció A: Compte 1 → Compte 2
-- Transacció B: Compte 2 → Compte 1

-- ✅ BÉ: Mateix ordre sempre
-- Transacció A: Compte 1 → Compte 2
-- Transacció B: Compte 1 → Compte 2
```

```sql
-- Exemple: Ordenar per ID
BEGIN TRANSACTION
    -- Sempre accedim primer al compte amb ID més baix
    DECLARE @id1 INT = 1, @id2 INT = 2;
    
    IF @id1 < @id2
    BEGIN
        UPDATE Comptes SET saldo = saldo - 100 WHERE id = @id1;
        UPDATE Comptes SET saldo = saldo + 100 WHERE id = @id2;
    END
    ELSE
    BEGIN
        UPDATE Comptes SET saldo = saldo + 100 WHERE id = @id2;
        UPDATE Comptes SET saldo = saldo - 100 WHERE id = @id1;
    END
COMMIT
```

### 2. Transaccions curtes

```sql
-- ❌ MAL: Transacció llarga
BEGIN TRANSACTION
    SELECT * FROM Comandes WHERE client = 'X';
    -- Processament llarg a l'aplicació...
    -- Espera input de l'usuari...
    UPDATE Comandes SET estat = 'Processat' WHERE client = 'X';
COMMIT

-- ✅ BÉ: Transacció curta
-- Fer el processament FORA de la transacció
BEGIN TRANSACTION
    UPDATE Comandes SET estat = 'Processat' WHERE client = 'X';
COMMIT
```

### 3. Utilitzar el nivell d'aïllament adequat

```sql
-- Si no necessites consistència total, utilitza un nivell més baix
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- O utilitza SNAPSHOT per evitar bloquejos en lectures
SET TRANSACTION ISOLATION LEVEL SNAPSHOT;
```

### 4. Utilitzar UPDLOCK per a patrons read-update

```sql
BEGIN TRANSACTION
    -- Adquirir bloqueig d'actualització des del principi
    SELECT * FROM Productes WITH (UPDLOCK) WHERE id = 1;
    
    -- Processar...
    
    UPDATE Productes SET estoc = estoc - 1 WHERE id = 1;
COMMIT
```

### 5. Gestionar deadlocks a l'aplicació

```sql
-- T-SQL amb retry
DECLARE @retry INT = 0;
DECLARE @maxRetries INT = 3;

WHILE @retry < @maxRetries
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            -- Les teves operacions aquí
            UPDATE Comptes SET saldo = saldo - 100 WHERE id = 1;
            UPDATE Comptes SET saldo = saldo + 100 WHERE id = 2;
        COMMIT
        BREAK;  -- Èxit, sortim del bucle
    END TRY
    BEGIN CATCH
        IF ERROR_NUMBER() = 1205  -- Deadlock
        BEGIN
            SET @retry = @retry + 1;
            IF @retry < @maxRetries
            BEGIN
                WAITFOR DELAY '00:00:01';  -- Esperar abans de reintentar
                CONTINUE;
            END
        END
        -- Si no és deadlock o hem superat els reintents, propagar l'error
        THROW;
    END CATCH
END
```

---

## Monitoritzar bloquejos

### Veure bloquejos actuals

```sql
-- Consulta bàsica de bloquejos
SELECT 
    resource_type,
    resource_database_id,
    resource_associated_entity_id,
    request_mode,
    request_status
FROM sys.dm_tran_locks
WHERE resource_database_id = DB_ID();
```

### Veure transaccions bloquejades

```sql
-- Qui bloqueja a qui?
SELECT 
    blocking.session_id AS blocking_session,
    blocked.session_id AS blocked_session,
    blocked.wait_type,
    blocked.wait_time,
    blocked.wait_resource
FROM sys.dm_exec_requests blocked
JOIN sys.dm_exec_sessions blocking 
    ON blocked.blocking_session_id = blocking.session_id
WHERE blocked.blocking_session_id <> 0;
```

### Activity Monitor

SQL Server Management Studio inclou l'**Activity Monitor** que permet veure gràficament:
- Processos actius
- Bloquejos
- Esperes
- Recursos consumits

---

## Resum

| Concepte | Descripció |
|----------|------------|
| **Shared Lock (S)** | Per lectura, compatible amb altres S |
| **Exclusive Lock (X)** | Per escriptura, incompatible amb tot |
| **Update Lock (U)** | Per read-then-update, evita deadlocks |
| **Deadlock** | Bloqueig mutu entre transaccions |
| **Lock escalation** | Passar de bloquejos de fila a taula |

### Bones pràctiques

1. ✅ Mantenir transaccions **curtes**
2. ✅ Accedir als recursos sempre en el **mateix ordre**
3. ✅ Utilitzar el **nivell d'aïllament mínim** necessari
4. ✅ Utilitzar `UPDLOCK` per a patrons read-then-update
5. ✅ Implementar **lògica de retry** per a deadlocks
6. ❌ Evitar **esperes** dins de transaccions (input usuari, crides externes)

---

## Exercici pràctic

Analitza el següent codi i identifica:
1. Quin tipus de bloquejos s'adquireixen?
2. Hi ha risc de deadlock? Per què?
3. Com el milloraries?

```sql
-- Transacció A
BEGIN TRANSACTION
    SELECT * FROM Clients WHERE id = 100;
    WAITFOR DELAY '00:00:10';
    UPDATE Comandes SET estat = 'Enviat' WHERE client_id = 100;
COMMIT

-- Transacció B (simultània)
BEGIN TRANSACTION
    UPDATE Comandes SET estat = 'Pendent' WHERE client_id = 100;
    SELECT * FROM Clients WHERE id = 100;
COMMIT
```

<details>
<summary>Veure solució</summary>

**1. Bloquejos adquirits:**
- Transacció A: Bloqueig S sobre Clients (SELECT), després bloqueig X sobre Comandes (UPDATE)
- Transacció B: Bloqueig X sobre Comandes (UPDATE), després bloqueig S sobre Clients (SELECT)

**2. Risc de deadlock:**
Sí! Si A adquireix S sobre Clients i B adquireix X sobre Comandes simultàniament:
- A espera X sobre Comandes (que té B)
- B espera S sobre Clients (que té A, si és REPEATABLE READ o superior)

**3. Millores:**
```sql
-- Opció 1: Mateix ordre d'accés
-- Transacció A
BEGIN TRANSACTION
    UPDATE Comandes SET estat = 'Enviat' WHERE client_id = 100;
    SELECT * FROM Clients WHERE id = 100;
COMMIT

-- Opció 2: Transacció més curta (treure el WAITFOR)
-- Opció 3: Utilitzar SNAPSHOT isolation
```

</details>
