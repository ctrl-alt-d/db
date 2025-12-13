# Problemes de concurrència

Quan múltiples transaccions s'executen simultàniament sobre les mateixes dades, poden sorgir diversos problemes si no es gestiona correctament l'**aïllament**. Aquests problemes són coneguts com a **anomalies de concurrència**.

En aquest capítol veurem els quatre problemes principals:

1. **Dirty Read** (Lectura bruta)
2. **Non-Repeatable Read** (Lectura no repetible)
3. **Phantom Read** (Lectura fantasma)
4. **Lost Update** (Actualització perduda)

---

## 1. Dirty Read (Lectura bruta)

### Definició

Un **Dirty Read** es produeix quan una transacció llegeix dades que han estat modificades per una altra transacció **que encara no ha fet COMMIT**.

El problema és que aquestes dades són "brutes" perquè la transacció que les ha modificat encara podria fer `ROLLBACK`, i llavors hauríem llegit dades que mai van existir realment.

### Exemple: Sistema de reserves

Imagina un sistema de reserves d'hotel:

```
Temps    Transacció A                    Transacció B
─────    ────────────                    ────────────
  1      BEGIN TRANSACTION               
         
  2      UPDATE Habitacions              
         SET disponible = 0              
         WHERE num = 101                 
         -- Reservem l'habitació 101     
                                         
  3                                      BEGIN TRANSACTION
                                         
  4                                      SELECT disponible 
                                         FROM Habitacions
                                         WHERE num = 101
                                         → disponible = 0  ← DIRTY READ!
                                         -- "L'habitació no està disponible"
                                         
  5      ROLLBACK                        
         -- Ops! Cancel·lem la reserva   
                                         
  6                                      -- La transacció B creu que
                                         -- l'habitació 101 està ocupada
                                         -- però en realitat està LLIURE!
```

### Conseqüències

- La **Transacció B** ha pres decisions basant-se en dades **incorrectes**
- L'habitació 101 estava disponible, però el client no la va poder reservar
- Pèrdua d'ingressos i mala experiència d'usuari

### Com evitar-ho?

Utilitzar un nivell d'aïllament de **READ COMMITTED** o superior:

```sql
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
```

---

## 2. Non-Repeatable Read (Lectura no repetible)

### Definició

Un **Non-Repeatable Read** es produeix quan una transacció llegeix la mateixa fila **dues vegades** i obté **valors diferents** perquè una altra transacció ha modificat i confirmat les dades entre les dues lectures.

### Exemple: Consulta de saldo bancari

```
Temps    Transacció A                    Transacció B
─────    ────────────                    ────────────
  1      BEGIN TRANSACTION               
         
  2      SELECT saldo FROM Comptes       
         WHERE id = 'X'                  
         → saldo = 1000 €                
                                         
  3                                      BEGIN TRANSACTION
                                         
  4                                      UPDATE Comptes 
                                         SET saldo = 500
                                         WHERE id = 'X'
                                         
  5                                      COMMIT
                                         
  6      -- Tornem a llegir el saldo     
         SELECT saldo FROM Comptes       
         WHERE id = 'X'                  
         → saldo = 500 €  ← DIFERENT!    
         
  7      -- Què ha passat? El saldo
         -- ha canviat durant la 
         -- meva transacció!
```

### Conseqüències

- La transacció A obté resultats **inconsistents** dins de la mateixa transacció
- Pot causar errors en càlculs o informes que depenen de múltiples lectures
- Per exemple: un informe financer que suma saldos podria donar resultats incorrectes

### Diferència amb Dirty Read

| Dirty Read | Non-Repeatable Read |
|------------|---------------------|
| Llegim dades **no confirmades** | Llegim dades **confirmades** |
| L'altra transacció pot fer ROLLBACK | L'altra transacció ha fet COMMIT |
| Les dades "brutes" mai van ser reals | Les dades eren reals, però han canviat |

### Com evitar-ho?

Utilitzar un nivell d'aïllament de **REPEATABLE READ** o superior:

```sql
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
```

---

## 3. Phantom Read (Lectura fantasma)

### Definició

Un **Phantom Read** es produeix quan una transacció executa la mateixa consulta **dues vegades** i obté un **conjunt diferent de files** perquè una altra transacció ha inserit o eliminat files que compleixen la condició de cerca.

> 💡 La diferència amb Non-Repeatable Read: allà canvia el **valor** d'una fila, aquí canvia el **nombre** de files.

### Exemple: Llistat de productes

```
Temps    Transacció A                    Transacció B
─────    ────────────                    ────────────
  1      BEGIN TRANSACTION               
         
  2      SELECT COUNT(*) FROM Productes  
         WHERE categoria = 'Electrònica' 
         → 10 productes                  
                                         
  3                                      BEGIN TRANSACTION
                                         
  4                                      INSERT INTO Productes 
                                         (nom, categoria)
                                         VALUES ('Tablet', 'Electrònica')
                                         
  5                                      COMMIT
                                         
  6      -- Tornem a comptar             
         SELECT COUNT(*) FROM Productes  
         WHERE categoria = 'Electrònica' 
         → 11 productes  ← FANTASMA!     
         
  7      -- Ha aparegut un producte
         -- "fantasma" durant la
         -- meva transacció!
```

### Conseqüències

- Informes inconsistents dins de la mateixa transacció
- Problemes en operacions que depenen del nombre de registres
- Per exemple: calcular percentatges, mitjanes o totals

### Exemple pràctic: Assignació de descomptes

```sql
BEGIN TRANSACTION

    -- Comptem quants clients VIP tenim
    SELECT @total = COUNT(*) FROM Clients WHERE tipus = 'VIP';
    -- → 100 clients
    
    -- Calculem el pressupost per client
    SET @descompte_per_client = 10000 / @total;  -- 100 € per client
    
    -- AQUÍ una altra transacció insereix 10 clients VIP nous
    
    -- Apliquem el descompte a TOTS els VIP
    UPDATE Clients SET descompte = @descompte_per_client WHERE tipus = 'VIP';
    -- S'aplica a 110 clients! Ens passem del pressupost!

COMMIT
```

### Com evitar-ho?

Utilitzar un nivell d'aïllament **SERIALIZABLE**:

```sql
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
```

---

## 4. Lost Update (Actualització perduda)

### Definició

Un **Lost Update** es produeix quan dues transaccions llegeixen el mateix valor, el modifiquen independentment, i després una de les actualitzacions **sobreescriu** l'altra.

### Exemple: Actualització de comptador

```
Temps    Transacció A                    Transacció B
─────    ────────────                    ────────────
  1      BEGIN TRANSACTION               BEGIN TRANSACTION
         
  2      SELECT visualitzacions          
         FROM Videos WHERE id = 1        
         → 1000                          
                                         
  3                                      SELECT visualitzacions
                                         FROM Videos WHERE id = 1
                                         → 1000
                                         
  4      -- Incrementem en 1             
         UPDATE Videos                   
         SET visualitzacions = 1001      
         WHERE id = 1                    
                                         
  5                                      -- Incrementem en 1
                                         UPDATE Videos
                                         SET visualitzacions = 1001
                                         WHERE id = 1
                                         
  6      COMMIT                          
                                         
  7                                      COMMIT
```

### Resultat

- Les **dues** transaccions volien incrementar el comptador
- El valor final és **1001** en lloc de **1002**
- L'actualització de la Transacció A s'ha **perdut**!

### Exemple real: Carret de compra

```
Temps    Sessió Navegador               Sessió Mòbil
─────    ────────────────               ─────────────
  1      SELECT quantitat               
         FROM Carret                     
         WHERE producte = 'Samarreta'   
         → quantitat = 2                 
                                         
  2                                      SELECT quantitat
                                         FROM Carret
                                         WHERE producte = 'Samarreta'
                                         → quantitat = 2
                                         
  3      -- Afegeixo 1 samarreta         
         UPDATE Carret                   
         SET quantitat = 3               
         WHERE producte = 'Samarreta'    
                                         
  4                                      -- Afegeixo 2 samarretes
                                         UPDATE Carret
                                         SET quantitat = 4
                                         WHERE producte = 'Samarreta'
                                         
  5      -- Resultat final: 4 samarretes
         -- Però el client volia 5! (2+1+2)
```

### Com evitar-ho?

**Opció 1**: Utilitzar operacions atòmiques

```sql
-- En lloc de llegir i després escriure...
UPDATE Videos 
SET visualitzacions = visualitzacions + 1 
WHERE id = 1;
```

**Opció 2**: Utilitzar bloquejos explícits

```sql
BEGIN TRANSACTION
    SELECT visualitzacions FROM Videos WITH (UPDLOCK) WHERE id = 1;
    -- El UPDLOCK impedeix que altres transaccions llegeixin per actualitzar
    UPDATE Videos SET visualitzacions = visualitzacions + 1 WHERE id = 1;
COMMIT
```

**Opció 3**: Utilitzar control optimista amb versions

```sql
-- Afegir una columna de versió
UPDATE Videos 
SET visualitzacions = @nou_valor, versio = versio + 1
WHERE id = 1 AND versio = @versio_original;

-- Si no s'actualitza cap fila, algú altre ha modificat el registre
```

---

## Resum dels problemes

| Problema | Descripció | Exemple |
|----------|------------|---------|
| **Dirty Read** | Llegir dades no confirmades | Veure una reserva que després es cancel·la |
| **Non-Repeatable Read** | El valor d'una fila canvia entre lectures | El saldo canvia mentre el consulto |
| **Phantom Read** | Apareixen o desapareixen files | El nombre de clients VIP augmenta |
| **Lost Update** | Una actualització sobreescriu una altra | El comptador de "likes" perd increments |

---

## Diagrama: Relació entre problemes i nivells d'aïllament

```
                      Dirty    Non-Repeatable   Phantom    Lost
Nivell d'aïllament    Read     Read             Read       Update
────────────────────  ───────  ───────────────  ─────────  ──────
READ UNCOMMITTED      ✅ Sí     ✅ Sí             ✅ Sí       ✅ Sí
READ COMMITTED        ❌ No     ✅ Sí             ✅ Sí       ✅ Sí
REPEATABLE READ       ❌ No     ❌ No             ✅ Sí       ❌ No
SERIALIZABLE          ❌ No     ❌ No             ❌ No       ❌ No
```

> 📚 Veurem els nivells d'aïllament en detall al capítol [Nivells d'aïllament](./nivells-aillament.md)

---

## Exercici pràctic

Identifica quin tipus de problema de concurrència es produeix en cada escenari:

1. Dues persones compren l'últim bitllet d'avió al "mateix temps" i totes dues reben confirmació.

2. Un informe de vendes mostra 1000 € de beneficis, però quan s'imprimeix 5 segons després mostra 1200 €.

3. Una transacció compta 50 comandes pendents, però quan les processa n'hi ha 55.

4. Un usuari veu un producte "En estoc" però quan intenta comprar-lo, ja no està disponible (perquè l'altra transacció que el reservava ha fet ROLLBACK).

<details>
<summary>Veure solucions</summary>

1. **Lost Update** - Les dues transaccions llegeixen "1 bitllet disponible" i el reserven
2. **Non-Repeatable Read** - El valor dels beneficis ha canviat entre lectures
3. **Phantom Read** - Han aparegut files noves (comandes) entre les dues consultes
4. **Dirty Read** - Es va llegir una reserva no confirmada que després es va cancel·lar

</details>
