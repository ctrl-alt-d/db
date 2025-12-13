# Tema 2.3: Transaccions (RA4)

## Introducció

Les **transaccions** són un dels conceptes fonamentals en la gestió de bases de dades. Una transacció és una seqüència d'operacions que s'executen com una **unitat indivisible de treball**: o bé s'executen totes les operacions correctament, o bé no s'executa cap.

Imagina que estàs fent una transferència bancària: si el sistema resta els diners del teu compte però falla abans d'afegir-los al compte de destí, et quedaries sense els diners! Les transaccions eviten aquest tipus de situacions garantint que les operacions es completen de manera coherent.

En aquest tema aprendràs:
- Com funcionen les transaccions en SQL
- Les propietats ACID que garanteixen la integritat de les dades
- Com gestionar transaccions amb `BEGIN`, `COMMIT` i `ROLLBACK`
- Els problemes de concurrència i els nivells d'aïllament
- Com implementar transaccions a MS SQL Server

---

## Índex de continguts

1. **[Concepte de transacció](./concepte-transaccio.md)**
   - Què és una transacció?
   - Per què necessitem transaccions?
   - Exemples pràctics: transferències bancàries, reserves de seients

2. **[Propietats ACID](./propietats-acid.md)**
   - Atomicitat (Atomicity)
   - Consistència (Consistency)
   - Aïllament (Isolation)
   - Durabilitat (Durability)

3. **[Problemes de concurrència](./problemes-concurrencia.md)**
   - Dirty Read (Lectura bruta)
   - Non-Repeatable Read (Lectura no repetible)
   - Phantom Read (Lectura fantasma)
   - Lost Update (Actualització perduda)

4. **[Nivells d'aïllament](./nivells-aillament.md)**
   - READ UNCOMMITTED
   - READ COMMITTED
   - REPEATABLE READ
   - SERIALIZABLE
   - SNAPSHOT (específic de SQL Server)

5. **[Bloquejos (Locks)](./bloquejos.md)**
   - Bloquejos compartits (Shared Locks)
   - Bloquejos exclusius (Exclusive Locks)
   - Deadlocks i com evitar-los

6. **[Pràctiques](./practiques.md)**
   - Exercicis guiats amb MS SQL Server
   - Casos pràctics de transaccions
   - Simulació de problemes de concurrència
