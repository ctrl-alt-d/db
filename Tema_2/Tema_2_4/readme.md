# Tema 2.4. Procediments emmagatzemats (RA5)

## Introducció — l'extensió procedimental a la base de dades

Les bases de dades relacionals acostumen a oferir una extensió procedimental (T‑SQL, PL/pgSQL, PL/SQL, etc.) que permet definir codi executable dins mateix del servidor: procediments emmagatzemats, funcions i triggers. Aquest codi s'executa prop de les dades i pot encapsular lògica de negoci, validacions i operacions transaccionals.


## Execució a la BD vs execució dins d'un llenguatge d'alt nivell

A continuació trobareu una comparativa pensada per ajudar a decidir on col·locar la lògica de negoci: a la base de dades (procediments) o a l'aplicació (C#, Java, Python, etc.).

- **Rendiment i latència**: executar codi al servidor redueix l'intercanvi de dades (menys round‑trips), útil per operacions que manipulen grans volums o que necessiten agregacions a la BD.
- **Atomicitat i integritat**: la BD pot garantir una transacció atòmica fàcilment; si l'operació necessita modificar diverses taules de forma consistent, un procediment dins la BD simplifica el control transaccional. Això també es pot fer des de'aplicació'.
- **Escalabilitat i mantenibilitat**: la lògica a l'aplicació permet escalar horizontalment el nivell de procés i aprofitar eines del llenguatge (test, depuració, control de versions). El codi a la BD pot complicar deployments i proves automatitzades.
- **Portabilitat**: procedural SQL sol ser específic del SGBD (T‑SQL, PL/pgSQL), mentre que l'aplicació pot ser més portable entre BD diferents.
- **Complexitat del domini**: lògica simple (validacions, constraints) és còmoda a la BD; lògica complexa (algorismes, integracions externes) acostuma a ser millor en l'aplicació.

Recomanació pràctica per a les pràctiques d'aquest tema:
- Useu procediments emmagatzemats per a casos on hi ha moltes transaccions per segon i cal un alt rendiment.
- Mantingueu la lògica de presentació, API externa i integracions amb serveis externs fora de la BD.

## Contingut

Treballarem aquest tema a partir de dues pràctiques guiades:

- [Venta entrades espectacles](practica_venta_entrades.md) — modelatge, `nou_esdeveniment` i `Comprar_entrades` amb comprovacions d'aïllament.
- [Reserva visita veterinari](practica_veterinari.md) — modelatge, `Add_reserva` i variant amb comptador desnormalitzat.

Tota la documentació de T-SQL està disponible on-line i de manera gratuita. Aquí us he fet una petita [xuleta de T-SQL](./xuleta_tsql.md).

## Pla de treball:

No volgueu fer tot el codi de cop. Cal anar construint i provant:

1. Llegiu la descripció i les comprovacions de cada pràctica.
2. Creeu una BD de treball i executeu els blocs DDL per crear les taules.
1. Declarar les variables que després seran paràmetres  
2. Escriure i provar cada validació i fer l'insert
3. Afegir la tx  
4. Triar i argumentar el nivell d’aïllació  
5. Posar-ho dins el TRY–CATCH  
6. Crear el procediment emmagatzemat  
7. Provar el procediment emmagatzemat  


