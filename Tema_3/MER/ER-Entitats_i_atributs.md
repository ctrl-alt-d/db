## Entitats i atributs
### Exercici: entitats i atributs

Anem a introduir el primer concepte del model entitat‑relació: les entitats i els seus atributs.

* Les entitats (també anomenades "entitats tipus") són els objectes sobre els quals cal recollir informació. Generalment denoten persones, llocs, coses o esdeveniments d'interès. A l'univers de discurs les entitats apareixeran com a noms (per exemple: producte, factura, comanda, nòmina, ...). Cada possible ocurrència de l'entitat s'anomena instància (altres autors també ho anomenen exemplar o ocurrència). Un exemple d'instància de producte pot ser «Bolígraf, referència 847372J»; un exemple d'instància de persona pot ser «Joan, DNI 50777666R». En el diagrama entitat‑relació apareixen les entitats tipus, no les instàncies.

* Els atributs són les propietats d'una entitat. Per exemple, els atributs de l'entitat persona poden ser: nom, DNI, data de naixement, etc.

### Entitats vs atributs

Llegir un univers de discurs no sempre permet distingir fàcilment si un element és entitat o atribut. A continuació, alguns criteris que ajuden a decidir:

* Els atributs no tenen existència per si mateixos. Per exemple, si 'ciutat' és un atribut amb 'nom' i 'nombre d'habitants', el segon no té sentit per si sol; necessita la ciutat com a context.
* Una entitat, en general, ha d'estar caracteritzada per alguna cosa més que el seu identificador principal. Si, en l'univers de discurs «Els magatzems es troben a ciutats», ens hem de preguntar si existeix informació descriptiva sobre la ciutat (província, nombre d'habitants, etc.). Si existeix, 'ciutat' serà entitat; en cas contrari, serà un atribut del magatzem.

### Atribut identificador principal (AIP)

Per poder distingir dues instàncies d'una mateixa entitat cal un atribut o un conjunt d'atributs que les identifiquin. Per exemple, per a l'entitat persona el DNI pot ser suficient; per a una vivenda caldrà un conjunt d'atributs (país, ciutat, carrer, número, porta, pis). Aquest atribut o conjunt d'atributs s'anomena atribut identificador. Pot haver‑hi diversos atributs identificadors candidates; el que s'escull s'anomena atribut identificador principal (AIP).

És important remarcar que cada entitat té un únic AIP, que pot estar format per diversos atributs.

### Representació gràfica

Les entitats es representen amb una caixa: al capdamunt hi va el nom de l'entitat tipus i, a sota, els atributs, marcant-se els que formen l'AIP.

### Exemple

Llegeix aquest enunciat i identifica entitats, atributs i AIP:

Una organització sense ànim de lucre vol una base de dades dels seus socis. Els socis poden ser actius o passius. Dels socis interessa el nom i la data de naixement. També es volen recollir les activitats que es realitzen, la data, el nombre de persones que hi assisteixen, el cost i els ingressos. Les persones s'identifiquen per un codi basat en les inicials, i les activitats per (nom, data) —és a dir, el mateix nom pot repetir‑se en diferents dates.

En aquest cas es poden distingir, per exemple:

* Entitat tipus SOCI: atributs — estat (actiu/passiu), nom, data de naixement, codi (AIP).
* Entitat tipus ACTIVITAT: atributs — nom (AIP), data (AIP), aforament, cost, ingressos.

![Entitats i atributs](http://i.imgur.com/4XzB5TW.png)

### Errors comuns

* No confondre el context amb l'entitat: sovint «organització sense ànim de lucre» no és una entitat si no recollim informació sobre ella.
* El nom de l'entitat tipus ha d'anar en singular (per exemple, ACTIVITAT, no ACTIVITATS).
* No confondre entitat tipus amb instància: «taller baldufes» és una instància de l'entitat ACTIVITAT.
* Quan diem que l'AIP d'una entitat està format per dos atributs, és correcte dir que l'AIP és compost (no que l'entitat té «dos AIPs» diferents).

### Exercici

Un institut de Figueres vol una base de dades dels seus alumnes. De cada alumne interessa: nivell (ESO, batxillerat, cicle formatiu, ...), curs (1r, 2n, 3r), grup (A, B, C, ...), nom i data de naixement. Periòdicament es revisen les aules; ens interessa saber l'aula (per exemple, 201, 317, 101), la data de la revisió i el grau de neteja (0‑10). Tingues en compte que dues persones poden compartir nom o data de naixement, però no nom i data de neixement tots dos a la vegada.

1. Identifica entitats, atributs i AIP.
2. Assegura't que no consideres «institut» com una entitat si no recollim informació sobre ell (vegeu l'apartat d'errors comuns).
3. Revisa que no hagis posat nivell (ESO, batxillerat) com a entitat; són valors d'un atribut.
4. Revisa que els noms d'entitat siguin en singular.
5. Valora si «aula» ha de ser atribut o entitat segons les dades que es volen emmagatzemar (si cal emmagatzemar aforament, pot passar a ser entitat).




