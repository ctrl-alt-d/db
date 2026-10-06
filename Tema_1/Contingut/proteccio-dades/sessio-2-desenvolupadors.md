# Sessió 2 — Protecció de dades per a desenvolupadors

## Objectius de la sessió

- Convertir els principis de protecció de dades en requisits tècnics.
- Incorporar la protecció de dades al cicle de vida del programari.
- Distingir anonimització, pseudonimització, xifratge i funció *hash*.
- Preparar una aplicació per atendre drets i incidents.

## 1. La protecció de dades és un requisit del sistema

Una política de privacitat no corregeix un mal disseny. Si una aplicació recull camps innecessaris, dona permisos excessius o no pot localitzar i suprimir dades, el problema és també tècnic.

L'article 25 de l'RGPD estableix dos conceptes relacionats:

- **Protecció de dades des del disseny (*data protection by design*):** integrar els principis i les garanties des que es defineixen el producte i el tractament, i mantenir-los durant tot el cicle de vida.
- **Protecció de dades per defecte (*data protection by default*):** sense que l'usuari hagi de canviar res, tractar només les dades necessàries per a cada finalitat pel que fa a quantitat, abast, termini de conservació i accessibilitat.

Exemple: pensar durant l'anàlisi si una data de naixement és necessària és protecció des del disseny. Configurar el perfil com a privat i la geolocalització com a desactivada és protecció per defecte.

## 2. De la finalitat a l'esquema de la base de dades

Abans de crear una taula o consumir una API, l'equip hauria de poder respondre:

1. Quina finalitat concreta té el tractament?
2. Quines dades són imprescindibles per assolir-la?
3. Quina base jurídica ha validat l'organització?
4. Qui són les persones afectades? Hi ha menors o col·lectius vulnerables?
5. Qui necessita accés i amb quines operacions: lectura, escriptura, exportació o supressió?
6. Amb qui es comunicaran les dades? Quins proveïdors hi accediran?
7. Quant de temps cal conservar cada categoria de dades?
8. Com s'atendran l'accés, la rectificació, la supressió, l'oposició, la limitació i la portabilitat quan siguin aplicables?
9. Quins danys podria patir una persona si les dades es perden, s'alteren o es revelen?

La persona responsable del tractament ha de determinar la licitud i els terminis aplicables. La funció de l'equip tècnic és fer explícites les preguntes i implementar les decisions validades, no inventar una base jurídica.

### Exemple de minimització

Una aplicació només necessita comprovar si una persona compleix una edat mínima.

| Disseny | Valoració |
|---|---|
| Desar sempre la data de naixement completa | Permet més usos, però pot excedir la finalitat i augmenta el risc. |
| Desar només `compleix_edat_minima = true/false`, si el context ho permet | Redueix la precisió, els usos secundaris i l'impacte d'una filtració. |

Minimitzar no és simplement amagar un camp a la interfície. Si el servidor el recull, el registra o el desa, existeix tractament.

## 3. Controls durant el cicle de vida

### 3.1 Anàlisi i disseny

- crear un mapa dels fluxos de dades: origen, taules, còpies, APIs, destinataris i països;
- separar les finalitats i evitar el camp genèric «per si algun dia serveix»;
- definir terminis de conservació i esdeveniments de supressió o anonimització;
- fer una anàlisi de riscos per als drets i les llibertats de les persones;
- consultar el DPD, si n'hi ha, i fer una avaluació d'impacte relativa a la protecció de dades (AIPD) quan el tractament pugui comportar un risc alt;
- documentar decisions, responsables i requisits verificables.

Una AIPD no és obligatòria per a qualsevol projecte. Ho és abans de tractaments susceptibles de comportar un risc alt, com alguns casos d'avaluació sistemàtica, tractament a gran escala de categories especials o observació sistemàtica a gran escala de zones públiques.

### 3.2 Desenvolupament i proves

- no emprar dades personals de producció en desenvolupament o proves si es poden utilitzar dades sintètiques;
- si excepcionalment calen dades reals, autoritzar-ne i limitar-ne l'ús amb controls equivalents als de producció;
- mantenir secrets i claus fora del codi, del repositori i dels registres;
- validar entrades i utilitzar consultes parametritzades per evitar injeccions;
- revisar dependències, permisos i configuracions abans del desplegament;
- evitar que captures de pantalla, tiquets, missatges d'error o eines d'analítica exposin dades personals.

### 3.3 Accés i administració

- aplicar el **mínim privilegi**: cada identitat només pot fer allò necessari;
- utilitzar identitats individuals, rols i permisos revocables; evitar comptes compartits;
- separar les funcions ordinàries de les funcions administratives;
- requerir autenticació reforçada quan el risc ho justifiqui;
- registrar accessos i operacions rellevants sense crear un registre desproporcionat;
- revisar permisos periòdicament i retirar-los quan deixen de ser necessaris.

En una base de dades, donar `SELECT *` a tota l'organització perquè és més còmode contradiu el mínim privilegi. Es poden emprar vistes, permisos per taula o columna, funcions i rols segons les capacitats del sistema gestor de bases de dades (SGBD).

### 3.4 Protecció de la informació

- xifrar les comunicacions en trànsit i, segons el risc, les dades en repòs i les còpies de seguretat;
- gestionar les claus separadament de les dades i limitar-ne l'accés;
- emmagatzemar contrasenyes amb un algorisme específic de derivació de claus per a contrasenyes, amb *salt* i paràmetres actuals; no desar-les en text clar ni amb una funció *hash* ràpida d'ús general;
- mantenir còpies de seguretat provades, protegides i sotmeses a una política de retenció;
- comprovar la restauració i la disponibilitat, no només la creació de còpies;
- actualitzar components i corregir vulnerabilitats d'acord amb el risc.

El xifratge redueix riscos, però no resol tots els problemes. Si l'aplicació o un compte autoritzat pot desxifrar les dades, una autorització incorrecta encara les pot exposar.

### 3.5 Registres (*logs*) i observabilitat

Un registre tècnic també pot contenir dades personals. Cal:

- definir què es registra i amb quina finalitat;
- evitar contrasenyes, tokens de sessió, claus, contingut complet de formularis i dades innecessàries;
- restringir-ne l'accés i protegir-ne la integritat;
- fixar un termini de conservació;
- permetre investigar incidents sense convertir els *logs* en una còpia permanent de la base de dades.

### 3.6 Exercici de drets i final del cicle

L'arquitectura ha de permetre:

- cercar les dades d'una persona a tots els sistemes rellevants;
- exportar-les de manera segura quan correspongui;
- rectificar-les sense deixar còpies incoherents;
- limitar-ne el tractament sense confondre limitació amb supressió;
- suprimir-les o anonimitzar-les quan pertoqui;
- propagar les accions a rèpliques, cercadors, cues, fitxers i serveis dependents;
- gestionar les còpies de seguretat mitjançant una política documentada que eviti reintroduir dades suprimides en restaurar-les.

La «supressió lògica» amb una marca `deleted = true` pot ser útil operativament, però continua conservant les dades. No satisfà per si sola una obligació de supressió.

## 4. Tècniques que no s'han de confondre

| Tècnica | Es pot recuperar o vincular la identitat? | Continua sent dada personal? | Ús habitual |
|---|---|---|---|
| Xifratge | Sí, amb la clau | Sí | Confidencialitat |
| Pseudonimització | Sí, amb informació addicional o per altres vies | Sí | Reduir la vinculació directa i el risc |
| *Hash* | Depèn de les dades, l'algorisme i els atacs possibles | Sovint sí | Verificació o derivació; no garanteix anonimat |
| Anonimització efectiva | No per mitjans raonablement probables | No | Estadística o publicació sense identificar persones |
| Dades sintètiques | No provenen de registres de persones reals, si s'han generat correctament | En principi, no | Desenvolupament i proves |

L'anonimització requereix valorar la singularització, la vinculabilitat amb altres fonts i la inferència. Eliminar el nom d'un conjunt amb codi postal, edat exacta i professió pot no ser suficient.

## 5. Proveïdors, serveis al núvol i APIs

Contractar un servei no transfereix automàticament totes les responsabilitats. Abans d'integrar un proveïdor cal saber:

- quin rol té cada part;
- quines dades rebrà i per a quina finalitat;
- quins subencarregats utilitza;
- on es tractaran les dades i si hi haurà transferències internacionals;
- quines garanties de seguretat, retorn, supressió i assistència ofereix;
- com i quan comunicarà incidents.

Quan un tercer tracta dades per compte del responsable, la relació s'ha de regular mitjançant el contracte o acte jurídic corresponent. Una clau d'API és una mesura tècnica, no un contracte d'encàrrec del tractament.

## 6. Resposta davant d'una violació: què aporta l'equip tècnic

El responsable necessita informació fiable per valorar el risc i complir els terminis. L'equip tècnic hauria de poder aportar:

- moment de detecció i cronologia coneguda;
- causa i vector de l'incident;
- sistemes, entorns i proveïdors afectats;
- categories i volum aproximat de dades i persones;
- si les dades estaven xifrades o eren intel·ligibles;
- accessos, descàrregues, alteracions o pèrdues observades;
- mesures de contenció i recuperació;
- evidències conservades i incerteses pendents.

No cal esperar a tenir una investigació perfecta per escalar l'incident. La informació per a l'autoritat es pot completar gradualment quan no estigui disponible alhora.

## 7. *Checklist* abans de publicar una funcionalitat

- [ ] La finalitat i la base jurídica han estat validades.
- [ ] Cada camp és necessari i té un termini de conservació.
- [ ] S'han identificat fluxos, còpies, proveïdors i transferències.
- [ ] La configuració inicial és la més respectuosa amb la privacitat.
- [ ] Els permisos apliquen el mínim privilegi.
- [ ] Les dades de proves no són dades reals innecessàries.
- [ ] Secrets, contrasenyes, dades en trànsit i còpies tenen protecció adequada.
- [ ] Els *logs* no exposen informació innecessària.
- [ ] Es poden atendre els drets aplicables en tots els sistemes.
- [ ] La supressió, la retenció i la restauració de còpies estan definides i provades.
- [ ] Hi ha un canal conegut per comunicar incidents.
- [ ] Les decisions i les proves han quedat documentades.

## 8. Activitat de tancament

Feu l'[exercici 4](./exercicis.md#exercici-4--revisió-de-privacitat-duna-aplicació-obligatori-20-min). No hi ha una única arquitectura correcta: s'avaluen la detecció dels problemes, la proporcionalitat de les mesures i la justificació.

## Ampliació

- **Registre d'activitats de tractament (RAT):** documenta, entre altres aspectes, finalitats, categories de persones i dades, destinataris, transferències, terminis i una descripció general de mesures de seguretat. L'article 30 preveu una excepció limitada per a algunes organitzacions de menys de 250 persones; no s'ha d'interpretar com una exempció general per a petites empreses.
- **AIPD:** s'ha de fer abans d'iniciar un tractament susceptible de comportar un risc alt. Si el risc residual alt no es pot mitigar prou, pot ser necessària una consulta prèvia a l'autoritat de control.
- **Transferències internacionals:** allotjar o permetre l'accés a dades des de fora de l'Espai Econòmic Europeu exigeix analitzar el capítol V de l'RGPD i les garanties aplicables. No s'ha de resoldre només marcant una casella de consentiment.

## Fonts per aprofundir

- [Protecció de dades des del disseny i per defecte — APDCAT](https://www.apdcat.cat/ca/organitzacions/obligacions-quan-es-tracten-dades/aplicar-la-proteccio-de-dades-des-del-disseny-i-per-defecte).
- [Guia per a desenvolupadors — APDCAT](https://www.apdcat.cat/content/dam/aem-apdcat/03-documentacio/documents/guiadesenvolupadors/GUIA-PDDD.pdf).
- [Anàlisi de riscos i mesures de seguretat — APDCAT](https://www.apdcat.cat/ca/organitzacions/obligacions-quan-es-tracten-dades/analitzar-els-riscos-i-aplicar-mesures-de-seguretat).
- [Avaluació d'impacte relativa a la protecció de dades — APDCAT](https://www.apdcat.cat/ca/organitzacions/obligacions-quan-es-tracten-dades/elaborar-una-avaluacio-d-impacte-de-proteccio-de-dades).
- [Relació entre responsable i encarregat — APDCAT](https://www.apdcat.cat/ca/organitzacions/obligacions-quan-es-tracten-dades/regular-la-relacio-entre-el-responsable-i-l-encarregat).
