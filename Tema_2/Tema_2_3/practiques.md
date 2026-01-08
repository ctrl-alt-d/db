# Pràctiques: Nivells d'Aïllament i Transaccions

## Taula de Nivells d'Aïllament i Anomalíes

| Nivell d'Aïllament | Dirty Read | Non-Repeatable Read | Phantom Read |
|-------------------|------------|---------------------|--------------|
| **READ UNCOMMITTED** | ✅ Possible | ✅ Possible | ✅ Possible |
| **READ COMMITTED** | ❌ No | ✅ Possible | ✅ Possible |
| **REPEATABLE READ** | ❌ No | ❌ No | ✅ Possible |
| **SERIALIZABLE** | ❌ No | ❌ No | ❌ No |

---

## Pràctiques per Nivell d'Aïllament

### ℹ️ Nota sobre com executar les pràctiques

En aquest manual es fan servir dues estratègies per simular transaccions que s'executen en paral·lel:

**Opció 1: Automàtic amb WAITFOR** (Més ràpid)
- Utilitza la comanda `WAITFOR DELAY '00:00:10'` per simular retards i mantenir les transaccions actives
- Executa la transacció sencera sense parar
- Ideals si vols una demostració ràpida

**Opció 2: Manual pas a pas** (Recomanat per aprendre)
- Executa **una línia o bloc a la vegada** en cada finestra
- **ELIMINA els `WAITFOR`** del codi
- En la Finestra 1, executes fins al `WAITFOR`, però sense executar-lo
- En la Finestra 2, executes la teva transacció
- Torna a la Finestra 1 i continua amb la resta
- Aquesta forma és **molt més didàctica** perquè veus exactament quan s'executa cada operació


### 1. READ UNCOMMITTED

**Descripció:** El nivell menys restrictiu. Permet la lectura de dades no confirmades (dirty reads).

**Cas d'ús:** Informes de lectura ràpida on la precisió exacta no és crítica.

#### Pràctica: Saldo Bancari No Confirmat

**Setup inicial:**
```sql
CREATE TABLE comptes_bancaris (
    id_compte INT PRIMARY KEY,
    numero_compte VARCHAR(20),
    saldo DECIMAL(10, 2)
);

INSERT INTO comptes_bancaris VALUES 
    (1, 'ES0001', 1000.00),
    (2, 'ES0002', 500.00);
```

**Transacció 1 (Finestra 1) - Transferència:**
```sql

BEGIN TRANSACTION;
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    UPDATE comptes_bancaris 
    SET saldo = saldo - 300 
    WHERE id_compte = 1;
    
    -- Simular delay (10 segons)
    WAITFOR DELAY '00:00:10';
    
    UPDATE comptes_bancaris 
    SET saldo = saldo + 300 
    WHERE id_compte = 2;
    
COMMIT;
```

**Transacció 2 (Finestra 2) - Consulta (mentre la transacció 1 està en marxa):**
```sql
BEGIN TRANSACTION;
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    WAITFOR DELAY '00:00:02'; -- Esperar perquè la T1 comenci
    
    SELECT saldo FROM comptes_bancaris WHERE id_compte = 1;
    -- 🔴 PROBLEMA: Pot llegir 700 (dada no confirmada!)
    
COMMIT;
```

**Què observes:** La Transacció 2 llegeix el saldo actualitzat de la T1 **ABANS** de ser confirmada. Si la T1 falla i fa rollback, la T2 ha llegit una dada "bruta" que ja no existeix.

---

### 2. READ COMMITTED

**Descripció:** Evita dirty reads. Només permet la lectura de dades confirmades, però pot comportar non-repeatable reads.

**Cas d'ús:** La majoria de les aplicacions. Balanç entre seguretat i rendiment.

#### Pràctica: Lectura No Repetible en Venda de Productes

**Setup inicial:**
```sql
CREATE TABLE productes (
    id_producte INT PRIMARY KEY,
    nom VARCHAR(50),
    quantitat INT,
    preu DECIMAL(8, 2)
);

INSERT INTO productes VALUES 
    (1, 'Laptop', 5, 1000.00),
    (2, 'Ratolí', 50, 25.00);
```

**Transacció 1 (Finestra 1) - Restock (Actualització de quantitat):**
```sql
BEGIN TRANSACTION;
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

    UPDATE productes 
    SET quantitat = quantitat + 100 
    WHERE id_producte = 1;
    
    WAITFOR DELAY '00:00:05'; -- Delay per deixar que T2 executi
    
COMMIT;
```

**Transacció 2 (Finestra 2) - Consulta (Lectura dues vegades):**
```sql
BEGIN TRANSACTION;
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

    SELECT quantitat FROM productes WHERE id_producte = 1;
    -- Primera lectura: 5 unitats
    
    WAITFOR DELAY '00:00:03'; -- Esperar al mig
    
    SELECT quantitat FROM productes WHERE id_producte = 1;
    -- 🟡 PROBLEMA: Segona lectura: 105 unitats (Lectura no repetible!)
    
COMMIT;
```

**Què observes:** La mateixa consulta dins de la mateixa transacció retorna valors diferents. Entre les dues lectures, la T1 ha modificat i confirmat les dades.

---

### 3. REPEATABLE READ

**Descripció:** Evita dirty reads i non-repeatable reads. Es creen snapshots de les dades llegides. Però pot comportar phantom reads.

**Cas d'ús:** Transaccions que necessiten consistència en lectures múltiples dins de la mateixa transacció.

#### Pràctica: Phantom Read en Sistema de Reservas

**Setup inicial:**
```sql
CREATE TABLE reserves_vol (
    id_reserva INT PRIMARY KEY IDENTITY,
    numero_vol VARCHAR(10),
    passatger VARCHAR(50),
    data_reserva DATETIME
);

INSERT INTO reserves_vol VALUES 
    (1, 'AA100', 'Joan Garcia', '2026-01-08'),
    (2, 'AA100', 'Maria Lopez', '2026-01-08');
```

**Transacció 1 (Finestra 1) - Informe de reserves (lectura de comptatge):**
```sql
BEGIN TRANSACTION;
    SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

    SELECT COUNT(*) as total_reserves 
    FROM reserves_vol 
    WHERE numero_vol = 'AA100';
    -- Primera lectura: 2 reserves
    
    WAITFOR DELAY '00:00:04';
    
    SELECT COUNT(*) as total_reserves 
    FROM reserves_vol 
    WHERE numero_vol = 'AA100';
    -- 🟠 PROBLEMA: Segona lectura: 3 reserves (Phantom Read!)
    
COMMIT;
```

**Transacció 2 (Finestra 2) - Inserció de nova reserva:**
```sql
BEGIN TRANSACTION;
    SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

    WAITFOR DELAY '00:00:02'; -- Esperar perquè T1 comenci
    
    INSERT INTO reserves_vol (numero_vol, passatger, data_reserva) 
    VALUES ('AA100', 'Carlos Martinez', '2026-01-08');
    
COMMIT;
```

**Què observes:** Malgrat que la T1 no fa UPDATE/DELETE, la T2 afegeix una nova fila que coincideix amb la clàusula WHERE. Quan la T1 llegeix de nou, veu una fila nova que no havia vist.

---

### 4. SERIALIZABLE

**Descripció:** El nivell més restrictiu. Evita totes les anomalíes aplicant bloquejos de rang (range locks).

**Cas d'ús:** Transaccions crítics on la consistència és essencial (operacions financeres, comptes de systema).

#### Pràctica: Aïllament Total en Transferència de Fons

**Setup inicial:**
```sql
CREATE TABLE transaccions_criticas (
    id_transaccio INT PRIMARY KEY IDENTITY,
    id_comte INT,
    tipus_operacio VARCHAR(20), -- 'Debit' o 'Credit'
    import DECIMAL(10, 2),
    data_transaccio DATETIME
);

CREATE TABLE compte_saldes (
    id_comte INT PRIMARY KEY,
    saldo_actual DECIMAL(15, 2)
);

INSERT INTO compte_saldes VALUES 
    (100, 10000.00),
    (200, 5000.00);
```

**Transacció 1 (Finestra 1) - Verificació i transferència:**
```sql
BEGIN TRANSACTION;
    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

    -- Lectura del saldo
    DECLARE @saldo_origen DECIMAL(10, 2);
    SELECT @saldo_origen = saldo_actual 
    FROM compte_saldes 
    WHERE id_comte = 100;
    
    IF @saldo_origen >= 1000
    BEGIN
        UPDATE compte_saldes 
        SET saldo_actual = saldo_actual - 1000 
        WHERE id_comte = 100;
        
        WAITFOR DELAY '00:00:03';
        
        UPDATE compte_saldes 
        SET saldo_actual = saldo_actual + 1000 
        WHERE id_comte = 200;
        
        INSERT INTO transaccions_criticas VALUES 
            (100, 'Debit', 1000, GETDATE()),
            (200, 'Credit', 1000, GETDATE());
    END
    
COMMIT;
```

**Transacció 2 (Finestra 2) - Intent d'altra operació:**
```sql
BEGIN TRANSACTION;
    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
    
    WAITFOR DELAY '00:00:01'; -- Esperar perquè T1 comenci
    
    -- Aquesta consulta s'ESPERARÀ bloquejada
    SELECT SUM(saldo_actual) as total_saldes 
    FROM compte_saldes 
    WHERE id_comte IN (100, 200);
    
    -- Es desbloquejarà només després de que T1 acabi
    
COMMIT;
```

**Què observes:** La T2 s'espera bloquejada fins que la T1 finalitza. No hi ha Dirty Reads, Non-Repeatable Reads, ni Phantom Reads. El sistema actua com si les transaccions s'executessin seqüencialment (serialment).

---

## Exercici Pràctic Complet

### Simulació: Sistema de Compra en Línia

**Objectiu:** Observar el comportament dels nivells d'aïllament en un escenari real.

#### Escenari: Compra de últimes unitats en stock

**Setup:**
```sql
CREATE TABLE articles (
    id INT PRIMARY KEY,
    codi_producte VARCHAR(20),
    stock INT,
    preu DECIMAL(8, 2)
);

CREATE TABLE comandes (
    id INT PRIMARY KEY IDENTITY,
    id_article INT,
    quantitat INT,
    data_comanda DATETIME
);

INSERT INTO articles VALUES 
    (1, 'PROD-001', 2, 99.99);  -- Només 2 unitats!
```

#### Preguntes per resoldre:

1. **Amb READ UNCOMMITTED:**
   - Què passa si dues transaccions intenten comprar simultàniament 2 unitats?
   - Es pot vendre més que el stock disponible?

2. **Amb READ COMMITTED:**
   - Les lectures són consistents?
   - Quina és la diferència?

3. **Amb REPEATABLE READ:**
   - Passa alguna anomalia?

4. **Amb SERIALIZABLE:**
   - Com es resol el problema?
   - Quins són els costos de rendiment?

---

## Comandes SQL per Executar les Pràctiques

### En MS SQL Server Management Studio o dbeaver:

**Per executar dues finestres simultàniament:**

1. Obre dues pestanyes/finestres d'SQL Server Management Studio o dbeaver
2. En la **Finestra 1**, executa els comandos de la **Transacció 1**
3. En la **Finestra 2**, executa els comandos de la **Transacció 2**
4. Observa els resultats i els comportaments

**Comandos útils:**
```sql
-- Per veure el nivell d'aïllament actual:
SELECT CASE transaction_isolation_level
    WHEN 0 THEN 'Unspecified'
    WHEN 1 THEN 'ReadUncommitted'
    WHEN 2 THEN 'ReadCommitted'
    WHEN 3 THEN 'Repeatable'
    WHEN 4 THEN 'Serializable'
    WHEN 5 THEN 'Snapshot'
END
FROM sys.dm_exec_sessions
WHERE session_id = @@SPID;

-- Per veure transaccions actives:
SELECT * FROM sys.dm_tran_active_transactions;
```

---

## Conclusions

- **READ UNCOMMITTED:** Més ràpid però **permet dirty reads**. Només apropiat per a consultes informatives no crítiques (estadístiques, aproximacions). Desaconsellat per a operacions de negoci importants.
- **READ COMMITTED:** La majoria de bases de dades per defecte. Bon balanç entre rendiment i integritat per a la majoria de casos.
- **REPEATABLE READ:** Evita anomalies però permet phantom reads. Util quan necessites consistència en lectures múltiples dins de la transacció.
- **SERIALIZABLE:** El més restrictiu, evita totes les anomalies però pot afectar el rendiment significativament. Usar només quan les dades són crítiques.

**Recorda:** Tria el nivell d'aïllament segons el context de negoci i la naturalesa de les dades, no només segons la velocitat!
