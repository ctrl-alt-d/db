# Concepte de transacció

## Què és una transacció?

Una **transacció** és una seqüència d'operacions sobre una base de dades que s'executen com una **unitat indivisible de treball**. Això vol dir que:

- **O bé s'executen totes les operacions correctament** → la transacció es **confirma** (`COMMIT`)
- **O bé no s'executa cap** → la transacció es **desfà** (`ROLLBACK`)

No hi ha terme mig: no pot ser que algunes operacions s'executin i d'altres no.

```sql
-- Exemple conceptual d'una transacció
BEGIN TRANSACTION
    Operació 1
    Operació 2
    Operació 3
    ...
COMMIT  -- Confirmar tots els canvis
-- o bé
ROLLBACK  -- Desfer tots els canvis
```

---

## Per què necessitem transaccions?

Sense transaccions, les bases de dades podrien quedar en **estats inconsistents** quan:

1. **Es produeix un error** a mig d'una operació complexa
2. **El sistema falla** (tall de llum, error de hardware, etc.)
3. **Múltiples usuaris** accedeixen simultàniament a les mateixes dades

Les transaccions garanteixen la **integritat de les dades** en tots aquests escenaris.

---

## Exemple 1: Transferència bancària

Imagina que la Maria vol transferir **100 €** al Joan. Aquesta operació requereix dos passos:

```sql
-- Pas 1: Restar 100 € del compte de la Maria
UPDATE Comptes SET saldo = saldo - 100 WHERE titular = 'Maria';

-- Pas 2: Afegir 100 € al compte del Joan
UPDATE Comptes SET saldo = saldo + 100 WHERE titular = 'Joan';
```

### Què passa si NO utilitzem transaccions?

Si el sistema falla entre el Pas 1 i el Pas 2:
- ❌ La Maria perd 100 € del seu compte
- ❌ El Joan no rep els 100 €
- ❌ Els 100 € han "desaparegut" del sistema!

### Què passa si SÍ utilitzem transaccions?

```sql
BEGIN TRANSACTION

    UPDATE Comptes SET saldo = saldo - 100 WHERE titular = 'Maria';
    UPDATE Comptes SET saldo = saldo + 100 WHERE titular = 'Joan';

COMMIT
```

Si el sistema falla en qualsevol moment abans del `COMMIT`:
- ✅ Es desfan automàticament tots els canvis
- ✅ La Maria conserva els seus 100 €
- ✅ La base de dades queda en un estat coherent

---

## Exemple 2: Reserva de seient en un avió

Un passatger vol canviar del seient 12A al seient 15C.

```sql
-- Pas 1: Alliberar el seient actual
UPDATE Seients SET passatger = NULL WHERE seient = '12A';

-- Pas 2: Assignar el nou seient
UPDATE Seients SET passatger = 'Joan Garcia' WHERE seient = '15C';
```

### Problema sense transaccions

1. S'allibera el seient 12A
2. ⚡ Un altre passatger reserva el 15C (concurrència!)
3. El sistema intenta assignar el 15C però ja està ocupat
4. **Resultat**: El passatger es queda sense cap seient!

### Solució amb transaccions

```sql
BEGIN TRANSACTION

-- Comprovem que el seient destí està disponible
IF EXISTS (SELECT 1 FROM Seients WHERE seient = '15C' AND passatger IS NULL)
BEGIN
    UPDATE Seients SET passatger = NULL WHERE seient = '12A';
    UPDATE Seients SET passatger = 'Joan Garcia' WHERE seient = '15C';
    COMMIT
END
ELSE
BEGIN
    ROLLBACK  -- El seient no està disponible, desfem tot
END

```

---

## Exemple 3: Comanda en una botiga online

Quan un client fa una comanda, cal:

1. Crear el registre de la comanda
2. Afegir les línies de comanda (productes)
3. Reduir l'estoc dels productes
4. Processar el pagament

```sql
BEGIN TRANSACTION

    -- 1. Crear la comanda
    INSERT INTO Comandes (client, data, total) 
    VALUES ('Maria', GETDATE(), 150.00);
    
    DECLARE @IdComanda INT = SCOPE_IDENTITY();

    -- 2. Afegir els productes
    INSERT INTO LiniesComanda (comanda, producte, quantitat, preu)
    VALUES (@IdComanda, 'PROD001', 2, 50.00);
    
    INSERT INTO LiniesComanda (comanda, producte, quantitat, preu)
    VALUES (@IdComanda, 'PROD002', 1, 50.00);

    -- 3. Reduir l'estoc
    UPDATE Productes SET estoc = estoc - 2 WHERE codi = 'PROD001';
    UPDATE Productes SET estoc = estoc - 1 WHERE codi = 'PROD002';

    -- 4. Si tot ha anat bé, confirmar
COMMIT
```

Si qualsevol pas falla (per exemple, no hi ha prou estoc), tot es desfà i el client no es queda amb una comanda a mitges.

---

## Transaccions implícites vs explícites

### Transaccions implícites (autocommit)

Per defecte, molts SGBD executen cada sentència SQL com una transacció individual:

```sql
-- Cada sentència és una transacció independent
INSERT INTO Clients VALUES ('001', 'Maria');  -- COMMIT automàtic
INSERT INTO Clients VALUES ('002', 'Joan');   -- COMMIT automàtic
```

### Transaccions explícites

Quan necessitem agrupar múltiples operacions, declarem explícitament la transacció:

```sql
BEGIN TRANSACTION
    INSERT INTO Clients VALUES ('001', 'Maria');
    INSERT INTO Clients VALUES ('002', 'Joan');
COMMIT  -- Els dos INSERT es confirmen junts
```

---

## Resum

| Concepte | Descripció |
|----------|------------|
| **Transacció** | Conjunt d'operacions que s'executen com una unitat indivisible |
| **COMMIT** | Confirma els canvis de la transacció (es fan permanents) |
| **ROLLBACK** | Desfà tots els canvis de la transacció |
| **Atomicitat** | Tot o res: o s'executen totes les operacions o cap |

---

## Exercici pràctic

Dissenya una transacció per al següent escenari:

> Un alumne es matricula a un curs. Cal:
> 1. Afegir l'alumne a la taula `Matricules`
> 2. Incrementar el comptador de places ocupades del curs
> 3. Comprovar que no se superi el màxim de places

Pensa:
- Què passaria si no utilitzéssim una transacció?
- En quin ordre faries les operacions?
- Quan faries `COMMIT` i quan `ROLLBACK`?
