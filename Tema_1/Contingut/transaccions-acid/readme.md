# Components ACID en un SGBD

## Què és una transacció?

Una **transacció** en un Sistema de Gestió de Bases de Dades (SGBD) és una seqüència d'operacions que es realitzen com una unitat lògica de treball. Aquestes operacions poden incloure instruccions d'inserció, actualització, eliminació o consulta. La transacció ha de complir amb les propietats ACID (Atomicitat, Consistència, Aïllament i Durabilitat) per garantir que la base de dades es manté en un estat coherent, fins i tot en cas d'errors o fallades.

## Components ACID

1. **Atomicitat (Atomicity)**  
   - Garantitza que una transacció es realitzi de manera completa o no es realitzi en absolut. Si una part de la transacció falla, el sistema ha de revertir tots els canvis fets fins aquell moment, mantenint la base de dades en un estat coherent.

2. **Consistència (Consistency)**  
   - Assegura que una transacció porta la base de dades d'un estat vàlid a un altre estat vàlid, seguint totes les regles i restriccions definides (com ara claus foranes, restriccions d'integritat, etc.).

3. **Aïllament (Isolation)**  
   - Permet a una transacció aïllar-se, si ho desitja, dels canvis que realitzen altres transaccions a la base de dades. La transacció pot triar el seu nivell d'isolació, des de veure dades no confirmades (dirty read) fins a actuar com si fos l'única transacció en curs a la base de dades.  Això evita efectes laterals d'altres transaccions en execució, assegurant que es comportin com si es processessin de manera seqüencial.

4. **Durabilitat (Durability)**  
   - Un cop una transacció s'ha completat correctament, els canvis són permanents i es mantenen fins i tot en cas de fallades del sistema. Això significa que els resultats de les transaccions es guarden de manera fiable en l'emmagatzematge permanent.



### Exemple financer: transferència de diners

Imagina una transferència de 100 € entre dos comptes bancaris: el compte A (el de la Maria) i el compte B (el del Joan). Aquesta operació implica dues accions principals:
1. **Restar 100 € del compte A**.
2. **Afegir 100 € al compte B**.

Aquesta transferència ha de ser una **transacció** perquè totes dues operacions es realitzin conjuntament de manera correcta. Si només es resta el diners del compte A, però per algun error no s’afegeixen al compte B, la base de dades quedarà en un estat incoherent, i Joan no rebria els diners mentre Maria ja els ha perdut.

Gràcies a les propietats ACID, el sistema assegura que la transacció és **atòmica** (les dues operacions es fan o cap d'elles es fa), **consistent** (es manté l'equilibri entre els comptes), **aïllada** (altres transaccions no interferiran fins que es completi la transferència) i **durable** (un cop completada, els canvis són permanents).


### Exemple: canvi de seient en un avió

Imagina que un viatger vol canviar el seu seient en un avió. Per fer-ho, el sistema ha de seguir dos passos principals:
1. **Alliberar el seient actual del viatger.**
2. **Assignar-li el nou seient.**

Si el sistema no utilitza transaccions, podrien sorgir problemes greus. Per exemple, el sistema allibera el seient actual del viatger, però abans que es completi l'assignació del nou seient, un altre viatger ocupa aquest nou seient. En aquest cas, el viatger original es queda sense seient assignat i el sistema es troba en un estat incoherent, ja que ha alliberat un seient però no ha completat l'assignació del nou.

Sense transaccions, no es pot garantir que totes les operacions associades al canvi de seient es facin de manera conjunta i correcta, el que podria provocar conflictes en les assignacions de seients i insatisfacció dels viatgers.
