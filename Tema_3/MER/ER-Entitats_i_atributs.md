# El model Entitat Inter-relació  - Entitats i Atributs
## DAW-MP02-UF1 - Exercici de Introducció a les bases de dades
**Entitats i Atributs**:

Anem a introduir el primer concepte del model entitat inter-relació. Les **entitats** i els seus **atributs**.

* Les **Entitats**, també anomenada 'entitats tipus', són els objectes principals sobre els quals cal recollir informació. Generalment denoten persones, llocs, coses o esdeveniments d'interès. Normalment, A l'univers de discurs les entitats apareixeran reflectides com a 'noms' ( producte, factura, comanda, nòmina, ... ).A cada possible ocurrència de l'entitat se la denomina 'instància' ( altres autors també ho anomenen 'exemplar', 'ocurrència', 'instància d'entitat', ... ). Un exemple d'instància de producte pot ser 'Bolígraf referència 847372J', un possible exemple d'instància de persona pot ser 'Joan amb DNI 50777666R'. Al diagrama entitat inter-relació apareixen les 'entitats tipus', mai les 'instàncies d'entitat'.

* Els **Atributs** són cadascuna de les propietats d'una entitat. Per exemple, els atributs de l'entitat *persona* podrien ser el nom, dni, data naixement, etc. 

**Entitats vs. atributs**

Llegint un Univers de Discurs, no sempre és fàcil saber si estem davant una entitat o un atribut. Alguns criteris que ens ajudaran a decidir:

* **Els atributs no tenen existència per ells mateixos**. Suposem l'entitat 'ciutat' amb els atributs 'nom' i 'nombre d'habitants'. Veiem que aquest darrer atribut no té sentit per ell mateix, que necessàriament ha d'estar inclòs a la ciutat.
* **Per regla general, una entitat ha d'estar caracteritzada per alguna cosa més que el seu Identificador Principal**. Exemple, a l'Univers de Discurs *"Els magatzems es troben a ciutats"*, podem tenir dubtes si 'ciutat' és atribut o entitat. Llavors ens preguntarem si existeix alguna informació descriptiva sobre la ciutat ( província, nombre d'habitants, ... ) si és així llavors serà entitat, en cas contrari serà simplement un atribut de magatzem.


L'**Atribut Identificador Principal (AIP)**

No podem trobar dues entitats amb tots els valors dels seus atributs iguals, no les podríem diferenciar. Sempre hi **ha d'haver un atribut o un conjunt d'atributs que els seus valors diferenciïn una entitat de totes les altres**. Per exemple, pel cas de persona, podríem decidir que el DNI és suficient per a distingir una instància d'entitat persona d'una altra. Pel cas d'una vivenda, potser necessitaríem un conjunt d'atributs: país, ciutat, carrer, número, porta, pis. A aquest atribut o conjunt d'atributs se l'anomena *Atribut identificador*. Fixem-nos que podem trobar més d'un atribut identificador en una mateixa entitat, per exemple en una empresa podriem identificar les instàncies de l'entitat treballador pel 'número de la seguretat social' i també pel 'dni'. En triarem un que serà l'**atribut identificador principal**.

És important remarcar que **cada entitat té un únic AIP** i que aquest pot estar format per diversos atributs.

**Representació gràfica**

La representació gràfica de les entitats es realitza mitjançant una caixeta, a la part de dalt de la caixeta hi posem el nom de l'entitat tipus, a la part de sota posem els atributs i marquem els que són AIP.


**Exemple d'identificació d'atributs i entitats**

Llegeix amb atenció aquest univers de discurs i identifica quines són les entitats, quins els atributs i quins són els atributs identificadors principals:

*Una organització sense ànim de lucre vol una base de dades dels seus **socis**. Els socis poden ser **actius o passius**. Dels socis ens interessa el seu **nom** i **data de naixement**. També es vol saber les **activitats** que es realitzen, en **quina data**, quant de **públic** hi assisteix, quin ha estat el **cost** i quin han estat els **ingressos** d'aquella activitat'. Les persones s'identifiquen per un **codi** que s'els dona segons les seves inicials, i les activitats pel nom de l'activitat més la data en què es realitza, per exemple l'activitat 'taller baldufes' es realitza 3 cops a l'any sempre amb el mateix nom, la data ens ajuda a diferenciar una activitat d'una altre.*

**Solució a l'exemple**

Un cop llegit el text veiem que poden ser subsceptibles de ser atributs o entitats els següents elements: soci, actiu o passiu (el soci), nom (del soci), data de naixement (del soci), codi (del soci), activitat, nom (de l'activitat), data (de l'activitat), quantitat de públic (de l'activitat), cost (de l'activitat), ingressos (de l'activitat). Fixem-nos que a alguns d'aquests substantius, entre parèntesi, hem hagut de posar una aclariment, explicant a que fa referència, per exemple a 'nom' hem hagut de posar 'del soci' o bé 'de l'activitat'. Això ens indica, clarament, que estem davant d'atributs i no d'entitats. Llavors, ens quedarien aquestes entitats amb aquests atributs:

* Entitat tipus **SOCI** amb els atributs: és actiu, nom, data de naixement, codi (atribut identificador principal)
* Entitat tipus **ACTIVITAT** amb els atributs: nom (atribut identificador principal), data (atribut identificador principal), quantitat de públic, cost, ingressos.

Aquesta és la representació gràfica:

![Entitats i atributs](http://i.imgur.com/4XzB5TW.png)

**Errors comuns que cal evitar** 

* Molts universos de discurs comencen com el de l'exemple: *Una organització sense ànim de lucre vol una base ...* Un analista inexpert tendeix a posar *Organització sense ànim de lucre* com a entitat, però no ho és, per què? doncs perquè no compleix els criteris per ser-ho: no recollim informació sobre ell, no tindrem instàncies d'aquesta entitat tipus ( com a molt en tindríem una que seria la pròpia organització, però això no té sentit ).
* El nom de les entitats tipus sempre ha de ser en **singular**. No podem posar **ACTIVITATS** com a nom de l'entitat tipus ha de ser **ACTIVITAT**.
* És comú, al començament, confondre entitat tipus amb instància d'entitat. A l'exemple 'taller baldufes' és una instància d'entitat de l'entitat tipus 'activitat'. 
* És un error greu dir que l'entitat 'activitat' té dos AIPs ( atributs identificadors principals ). El correcte és dir que l'AIP d' 'activitat' està format per dos atributs.

**Exercici**

Llegeix amb atenció aquest univers de discurs:

*Un **institut** de Figueres vol una base de dades amb els seus **alumnes**. De cada alumne interessa el **nivell** ( ESO, BATXILLERAT, CICLE INFORMÀTICA SUPERIOR, ... ), el **curs** (1r, 2n, 3r), el **grup** (A, B, C, ... ), el **nom**, la **data de naixement**. Periòdicament es fa **revisió** de les aules per saber si estan netes. Ens interessa saber l'**aula** (ex: 201, 317, 101, ... ), la **data en què es fa la revisió**, i el **grau de neteja** ( del 0 al 10 segons estigui molt bruta o netíssima). Nota: ens hi hem trobat que es habitual que dos alumnes tiguin la mateixa data de naixement, per coincidència o perquè són bessons, també és habitual trobar noms repetits, per exemple hi ha dos alumnes que es diuen 'Josep Pagés Pagés', però no ens hi hem trobat mai amb dos alumnes amb el mateix nom i mateixa data de naixement.*

1. Identifica quines són les entitats, quins els atributs i quins són els atributs identificadors principals.
2. Has posat 'institut' com a entitat? doncs has caigut a la trampa de les negretes :) Llegeix de nou l'apartat **errors comuns que cal evitar**
3. Comprova que no hagis posat ESO o BATXILLERAT com a entitat tipus perquè són instàncies d'entitat. Tingues clar aquest punt.
3. Revisa que hagis escrit el nom de les entitats en singular.
4. Comprova si amb els atributs que has triat a cada entitat com AIP en fas prou per diferenciar una instància d'entitat tipus d'una altra.
5. En aquest exemple l'element **aula** és un atribut, en un altre univers de discurs pot ser una entitat. Per exemple, si ens demanéssim que cal emmagatzemar l'**aforament** de cada aula llavors aforament seria un atribut d' 'aula' i, per tant, 'aula' passaria a ser entitat, perquè tindria més atributs que el seu propi AIP. 

