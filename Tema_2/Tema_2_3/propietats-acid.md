# Propietats ACID

Les propietats **ACID** són els quatre principis fonamentals que garanteixen que les transaccions en una base de dades es processen de manera fiable. L'acrònim ACID prové de:

- **A**tomicitat (Atomicity)
- **C**onsistència (Consistency)
- **I** (Aïllament) (Isolation)
- **D**urabilitat (Durability)

Aquestes propietats asseguren que la base de dades es manté en un estat coherent fins i tot en cas d'errors, fallades del sistema o accés concurrent.

---

## 1. Atomicitat (Atomicity)

### Definició

L'atomicitat garanteix que una transacció es tracta com una **unitat indivisible**: o bé s'executen **totes** les operacions de la transacció, o bé **no s'executa cap**.

> 💡 El nom prové del grec *átomos* (indivisible), com els àtoms que es creien indivisibles.

### Exemple: Transferència bancària

```sql
BEGIN TRANSACTION

    -- Operació 1: Restar diners del compte origen
    UPDATE Comptes SET saldo = saldo - 500 WHERE id = 'A';
    
    -- Operació 2: Afegir diners al compte destí
    UPDATE Comptes SET saldo = saldo + 500 WHERE id = 'B';

COMMIT
```

**Sense atomicitat**: Si el sistema falla després de l'Operació 1 però abans de l'Operació 2, el compte A perd 500 € que mai arriben al compte B.

**Amb atomicitat**: Si qualsevol operació falla, **totes** es desfan automàticament. Els 500 € mai "desapareixen".

### Com ho implementa el SGBD?

El SGBD utilitza un **log de transaccions** (transaction log) que registra:
- Totes les operacions realitzades
- Els valors anteriors de les dades modificades

Si cal fer `ROLLBACK`, el SGBD utilitza aquest log per restaurar l'estat anterior.

---

## 2. Consistència (Consistency)

### Definició

La consistència garanteix que una transacció porta la base de dades d'un **estat vàlid a un altre estat vàlid**, respectant totes les regles d'integritat definides:

- Claus primàries i foranes
- Restriccions `CHECK`
- Restriccions `UNIQUE`
- Triggers
- Regles de negoci

### Exemple: Restricció de saldo mínim

Imagina que els comptes bancaris no poden tenir saldo negatiu:

```sql
-- Restricció definida a la taula
ALTER TABLE Comptes ADD CONSTRAINT CK_SaldoPositiu CHECK (saldo >= 0);
```

```sql
BEGIN TRANSACTION

    -- Intent de retirar més diners dels disponibles
    UPDATE Comptes SET saldo = saldo - 1000 WHERE id = 'A';
    -- Si el saldo resultant és negatiu, la transacció FALLA
    
COMMIT
```

**Resultat**: Si el compte A té 500 €, la transacció fallarà perquè violaria la restricció `CHECK`. La base de dades mai quedarà en un estat inconsistent (saldo negatiu).

### Exemple: Clau forana

```sql
BEGIN TRANSACTION

    -- Inserir una factura per a un client que no existeix
    INSERT INTO Factures (id, client_id, total) 
    VALUES (1, 999, 150.00);  -- client_id 999 no existeix!
    
COMMIT
```

**Resultat**: La transacció falla perquè viola la restricció de clau forana. No es poden crear factures "òrfenes".

### Responsabilitat compartida

La consistència és una responsabilitat compartida entre:
- **El SGBD**: Verifica les restriccions definides a l'esquema
- **L'aplicació**: Ha de garantir que les operacions tenen sentit a nivell de negoci

---

## 3. Aïllament (Isolation)

### Definició

L'aïllament garanteix que les transaccions concurrents s'executen com si fossin **seqüencials**, sense interferir entre elles. Cada transacció "veu" la base de dades com si fos l'única que s'està executant.

### El problema de la concurrència

Imagina dues transaccions que s'executen simultàniament:

```
Temps    Transacció A              Transacció B
─────    ────────────              ────────────
  1      SELECT saldo FROM         
         Comptes WHERE id='X'      
         → saldo = 1000            
                                   
  2                                SELECT saldo FROM
                                   Comptes WHERE id='X'
                                   → saldo = 1000
                                   
  3      UPDATE Comptes            
         SET saldo = 1000 + 100    
         WHERE id='X'              
                                   
  4                                UPDATE Comptes
                                   SET saldo = 1000 + 200
                                   WHERE id='X'
                                   
  5      COMMIT                    
                                   
  6                                COMMIT
```

**Resultat sense aïllament**: El saldo final és 1200 € en lloc de 1300 €! L'actualització de la Transacció A s'ha perdut.

### Nivells d'aïllament

L'aïllament es pot configurar amb diferents nivells (de menys a més restrictiu):

| Nivell | Dirty Read | Non-Repeatable Read | Phantom Read |
|--------|------------|---------------------|--------------|
| READ UNCOMMITTED | ✅ Possible | ✅ Possible | ✅ Possible |
| READ COMMITTED | ❌ Evitat | ✅ Possible | ✅ Possible |
| REPEATABLE READ | ❌ Evitat | ❌ Evitat | ✅ Possible |
| SERIALIZABLE | ❌ Evitat | ❌ Evitat | ❌ Evitat |

> 📚 Veurem els nivells d'aïllament en detall al capítol [Nivells d'aïllament](./nivells-aillament.md)

### Com ho implementa el SGBD?

- **Bloquejos (Locks)**: Impedeixen que altres transaccions accedeixin a les dades mentre s'estan modificant
- **MVCC (Multi-Version Concurrency Control)**: Cada transacció treballa amb una "foto" de les dades en un moment concret

---

## 4. Durabilitat (Durability)

### Definició

La durabilitat garanteix que un cop una transacció s'ha confirmat amb `COMMIT`, els canvis són **permanents** i sobreviuran a qualsevol fallada posterior del sistema:

- Talls de llum
- Errors de hardware
- Reinicis del servidor
- Errors del sistema operatiu

### Com ho implementa el SGBD?

1. **Write-Ahead Logging (WAL)**: Abans de modificar les dades, el SGBD escriu els canvis al log de transaccions en disc.

2. **Checkpoints**: Periòdicament, el SGBD sincronitza les dades de memòria amb el disc.

3. **Recuperació automàtica**: Quan el servidor es reinicia després d'una fallada, el SGBD:
   - Llegeix el log de transaccions
   - **Refà** (redo) les transaccions confirmades que no s'havien escrit al disc
   - **Desfà** (undo) les transaccions no confirmades

### Exemple

```sql
BEGIN TRANSACTION
    UPDATE Comptes SET saldo = saldo + 1000 WHERE id = 'A';
COMMIT  -- ← En aquest moment, el canvi és PERMANENT
```

Encara que el servidor s'apagui 1 mil·lisegon després del `COMMIT`, quan es reiniciï, el saldo del compte A tindrà els 1000 € afegits.

---

## Resum visual

```
┌─────────────────────────────────────────────────────────────────┐
│                        PROPIETATS ACID                          │
├─────────────────┬───────────────────────────────────────────────┤
│   ATOMICITAT    │  Tot o res: totes les operacions o cap        │
│                 │  → Garanteix unitat indivisible               │
├─────────────────┼───────────────────────────────────────────────┤
│  CONSISTÈNCIA   │  D'estat vàlid a estat vàlid                  │
│                 │  → Respecta totes les restriccions            │
├─────────────────┼───────────────────────────────────────────────┤
│   AÏLLAMENT     │  Transaccions independents                    │
│                 │  → Com si fossin seqüencials                  │
├─────────────────┼───────────────────────────────────────────────┤
│   DURABILITAT   │  Canvis permanents després del COMMIT         │
│                 │  → Sobreviu a fallades del sistema            │
└─────────────────┴───────────────────────────────────────────────┘
```

---

## Taula resum

| Propietat | Pregunta que respon | Exemple de problema que evita |
|-----------|---------------------|-------------------------------|
| **Atomicitat** | S'han executat totes les operacions? | Transferència parcial (diners perduts) |
| **Consistència** | La BD segueix sent vàlida? | Saldo negatiu, factura sense client |
| **Aïllament** | Altres transaccions interfereixen? | Actualitzacions perdudes, lectures brutes |
| **Durabilitat** | Els canvis són permanents? | Pèrdua de dades després d'un tall de llum |

---

## Exercici de reflexió

Analitza el següent escenari i identifica quines propietats ACID podrien estar en risc:

> Una botiga online processa una comanda:
> 1. Redueix l'estoc del producte
> 2. Crea el registre de la comanda
> 3. Cobra la targeta de crèdit del client
> 4. Envia un correu de confirmació
>
> El servidor es reinicia inesperadament després del pas 3.

Preguntes:
- Què passaria sense atomicitat?
- El correu de confirmació hauria de formar part de la transacció de base de dades?
- Com garantiries la consistència si el pagament es processa en un servei extern?
