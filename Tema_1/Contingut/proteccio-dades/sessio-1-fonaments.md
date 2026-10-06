# Sessió 1 — Fonaments de protecció de dades

## Objectius de la sessió

- Entendre què protegeix la normativa de protecció de dades.
- Reconèixer els actors, els principis i les bases jurídiques principals.
- Valorar el risc d'un tractament sense reduir-lo a una etiqueta de «dada sensible».
- Saber què és una violació de la seguretat de les dades personals.

## 1. Cas inicial

Una aplicació esportiva mostra el nom d'usuari, les rutes i els temps dels participants. Una persona ha fet públic el seu perfil.

Penseu-hi durant dos minuts:

1. Les rutes continuen sent dades personals?
2. Que el perfil sigui públic permet reutilitzar les dades per a qualsevol finalitat?
3. Quins perjudicis podria causar la publicació de la ubicació habitual?

La resposta curta és que una dada accessible públicament pot continuar sent una dada personal. Publicar-la no elimina automàticament els principis de finalitat, transparència i licitud.

## 2. Marc normatiu

Les dues normes generals de referència són:

- el **Reglament general de protecció de dades (RGPD)**, Reglament (UE) 2016/679, aplicable des del 25 de maig de 2018;
- la **Llei orgànica de protecció de dades personals i garantia dels drets digitals (LOPDGDD)**, Llei orgànica 3/2018, que adapta i complementa l'RGPD en l'ordenament jurídic espanyol.

L'article 18.4 de la Constitució espanyola ja preveu que la llei limiti l'ús de la informàtica per garantir l'honor, la intimitat i l'exercici dels drets.

A Catalunya, l'**Autoritat Catalana de Protecció de Dades (APDCAT)** exerceix les seves funcions dins del seu àmbit competencial. L'**Agència Espanyola de Protecció de Dades (AEPD)** és l'autoritat estatal. En un cas real cal determinar quina autoritat és competent; no s'ha de donar per fet que sempre és la mateixa.

## 3. Vocabulari imprescindible

### Dada personal

Qualsevol informació sobre una persona física identificada o identificable. No es limita al nom o al document d'identitat: també poden ser dades personals una adreça IP, un identificador de galeta, una matrícula, una fotografia, una gravació de veu o un historial de localitzacions si permeten identificar o singularitzar una persona.

La normativa general de protecció de dades no protegeix les dades d'una persona jurídica com a tals, tot i que una dada empresarial pot identificar una persona física, com passa amb l'adreça `nom.cognom@empresa.example`.

### Tractament

Qualsevol operació feta sobre dades personals: recollir, consultar, ordenar, modificar, relacionar, comunicar, exportar, conservar o suprimir. Emmagatzemar dades sense consultar-les també és tractar-les.

### Persona interessada

La persona física a qui fan referència les dades. També es pot trobar el terme **persona afectada**.

### Responsable i encarregat del tractament

- El **responsable del tractament** determina les finalitats i els mitjans del tractament.
- L'**encarregat del tractament** tracta dades per compte del responsable i seguint-ne les instruccions, d'acord amb un contracte o un altre acte jurídic.

Una empresa que ofereix allotjament al núvol sol actuar com a encarregada respecte de les dades que hi allotja un client, però els rols depenen de l'activitat concreta. El nom comercial del servei no determina el rol.

La persona desenvolupadora normalment no és, a títol individual, qui decideix la base jurídica o si s'ha de notificar una violació. Tanmateix, les seves decisions tècniques poden fer possible —o impedir— el compliment.

### Dades anònimes i pseudonimitzades

- Una dada està **anonimitzada** quan la persona ja no és identificable per mitjans raonablement probables. Si l'anonimització és realment irreversible, deixa de ser dada personal.
- Una dada està **pseudonimitzada** quan els identificadors s'han substituït o separat, però la reidentificació encara és possible amb informació addicional. Continua sent dada personal.

Substituir el nom per un codi, aplicar una funció *hash* sense més mesures o xifrar una columna no converteix necessàriament les dades en anònimes.

## 4. Els principis: les regles que sempre acompanyen les dades

| Principi | Pregunta pràctica |
|---|---|
| Licitud, lleialtat i transparència | Podem fer aquest tractament i l'hem explicat de manera entenedora? |
| Limitació de la finalitat | Per a què es van recollir les dades? Les estem utilitzant per a aquella mateixa finalitat? |
| Minimització de dades | Necessitem realment cada camp i cada registre? |
| Exactitud | Com es poden corregir les dades incorrectes? |
| Limitació del termini de conservació | Quan s'han de suprimir o anonimitzar? |
| Integritat i confidencialitat | Com evitem pèrdues, alteracions i accessos o divulgacions no autoritzats? |
| Responsabilitat proactiva (*accountability*) | Podem demostrar les decisions i les mesures adoptades? |

La responsabilitat proactiva no consisteix només a tenir documents. Cal aplicar mesures adequades i poder acreditar que funcionen.

## 5. Una base jurídica per a cada finalitat

Tractar dades personals exigeix, com a mínim, una base jurídica de l'article 6 de l'RGPD:

| Base jurídica | Exemple orientatiu |
|---|---|
| Consentiment | Subscripció voluntària a comunicacions comercials no necessàries per al servei |
| Execució d'un contracte o aplicació de mesures precontractuals | El tractament és necessari per complir un contracte amb la persona o per fer, a petició seva, gestions prèvies a la contractació. Per exemple, una botiga utilitza l'adreça postal del client per lliurar-li la compra. |
| Obligació legal | Conservació de determinada documentació quan una norma ho exigeix |
| Protecció d'interessos vitals | El tractament és necessari per protegir la vida o la integritat física d'una persona. Per exemple, un equip sanitari consulta les al·lèrgies d'una persona inconscient per atendre-la en una emergència. |
| Missió en interès públic o exercici de poders públics | Tractament fet per una administració en exercici de les seves competències |
| Interès legítim | Determinats tractaments necessaris després de valorar necessitat, proporcionalitat i drets de les persones |

> **Error freqüent:** «Si hi ha dades personals, demanem consentiment». El consentiment només és una de les sis bases. Ha de ser lliure, específic, informat i inequívoc, s'ha de poder retirar i no és adequat si el servei obliga a acceptar un tractament que no és necessari.

### Exemple: un sorteig que també vol obtenir contactes publicitaris

Una empresa de *marketing* organitza el sorteig d'un ordinador. Per gestionar-lo pot necessitar algunes dades, com el nom, una via de contacte i, si escau, les dades necessàries per comprovar que es compleixen les bases. Aquesta és una finalitat: **gestionar el sorteig**.

L'empresa també vol conservar les adreces electròniques per enviar publicitat quan el sorteig hagi acabat. Aquesta és una altra finalitat: **enviar comunicacions comercials**. Rebre publicitat no és, en principi, necessari per seleccionar la persona guanyadora o lliurar-li el premi.

Si l'empresa es basa en el consentiment per enviar aquesta publicitat:

- ha de demanar-lo separadament, mitjançant una opció no premarcada;
- ha d'explicar qui enviarà la publicitat, per quin canal i sobre quins productes o serveis;
- negar-s'hi no hauria d'impedir participar en el sorteig;
- retirar-lo ha de ser tan fàcil com donar-lo i no hauria d'anul·lar la participació;
- les dades del sorteig no es poden conservar indefinidament per a publicitat si no hi ha una base jurídica vàlida per a aquesta nova finalitat.

Un formulari simplificat podria separar les decisions així:

```text
[obligatori] He llegit i accepto les bases del sorteig.
[opcional]   Vull rebre per correu electrònic publicitat de l'empresa X.
```

La informació de protecció de dades s'ha de facilitar encara que el tractament no es basi en el consentiment. «He llegit la política de privacitat» no s'ha d'utilitzar per obtenir en bloc el consentiment per a totes les finalitats.

L'article 7.4 de l'RGPD obliga a tenir especialment en compte si es condiciona un servei a consentir un tractament que no és necessari. Les [Directrius 5/2020 del Comitè Europeu de Protecció de Dades](https://www.edpb.europa.eu/documents/guideline/guidelines-052020-on-consent-under-regulation-2016679_es) indiquen que, en aquesta situació, hi ha una presumpció sòlida que el consentiment no s'ha donat lliurement. Per tant, una empresa no pot convertir l'enviament de publicitat en necessari simplement escrivint-lo a les bases del sorteig. A més, l'enviament de publicitat electrònica està sotmès a les regles específiques de l'article 21 de la Llei 34/2002, de serveis de la societat de la informació i de comerç electrònic.

> **Resposta al cas:** com a criteri general, una persona ha de poder participar en el sorteig sense consentir l'enviament posterior de publicitat. Si l'empresa ho imposa, el consentiment publicitari pot no ser vàlid perquè no és lliure. En un cas real cal examinar les bases, la relació entre les finalitats, la informació facilitada i la normativa sectorial aplicable.

Una mateixa aplicació pot tenir bases diferents per a finalitats diferents. Per exemple, una botiga pot necessitar dades per executar una compra i demanar, separadament, consentiment per enviar publicitat.

Les **mesures precontractuals** són actuacions que la persona demana abans de formalitzar un contracte. Per exemple, facilitar dades econòmiques perquè una entitat prepari una oferta de finançament. Aquesta base només cobreix les dades necessàries per fer la gestió sol·licitada; no autoritza qualsevol ús posterior.

Els **interessos vitals** s'apliquen en situacions en què el tractament és necessari per protegir la vida o la integritat física de la persona interessada o d'una altra persona. No és una justificació general per tractar qualsevol dada de salut. Si es tracten categories especials, com les dades de salut, també s'ha de complir una de les condicions de l'article 9 de l'RGPD.

## 6. No totes les dades comporten el mateix risc

L'RGPD no estableix una escala general de dades «baixes, mitjanes i altes». La taula següent és una **eina didàctica**, no una classificació jurídica oficial:

| Grup | Exemples | Consideracions |
|---|---|---|
| Informació no personal | Dades sintètiques; estadístiques realment anònimes | L'RGPD no s'aplica si ningú no és identificable per mitjans raonablement probables. Cal valorar el risc de reidentificació. |
| Dades personals habituals | Nom, correu electrònic, identificador de client, adreça IP | Requereixen finalitat, base jurídica i totes les garanties de l'RGPD. «Habitual» no vol dir innòcua. |
| Dades que poden elevar el risc segons el context | Ubicació precisa, situació econòmica, credencials, identificadors oficials, dades de menors o patrons de conducta | No sempre són categories especials, però el volum, la combinació, la finalitat o les persones afectades poden causar perjudicis importants. |
| Categories especials de dades (article 9) | Origen racial o ètnic; opinions polítiques; conviccions religioses o filosòfiques; afiliació sindical; dades genètiques; dades biomètriques per identificar unívocament; salut; vida sexual o orientació sexual | El tractament està prohibit com a regla general, tret que concorri una de les excepcions de l'article 9.2. També cal una base jurídica de l'article 6. |
| Condemnes i infraccions penals (article 10) | Antecedents o informació sobre infraccions penals | No són una categoria especial de l'article 9, però tenen un règim específic i especialment restrictiu. |

Les categories especials i les dades sobre condemnes i infraccions penals **també són dades personals**. Els articles 9 i 10 no creen dades diferents de les personals, sinó règims de protecció addicionals per a determinats tipus de dades.

Per classificar una informació, podem seguir aquest ordre:

1. Permet identificar una persona física, directament o indirectament?
   - Si no ho permet i l'anonimització és efectiva, no és una dada personal.
   - Si ho permet, és una dada personal i cal continuar l'anàlisi.
2. Forma part de les categories especials enumerades a l'article 9?
3. Fa referència a condemnes o infraccions penals i, per tant, està sotmesa a l'article 10?
4. Si no entra als articles 9 o 10, continua sent una dada personal. Cal valorar igualment si el context, el volum o les conseqüències n'eleven el risc.

Una fotografia facial o una empremta no són automàticament una categoria especial pel simple format. Ho són, en aquest context, quan es tracten tècnicament per identificar una persona de manera unívoca.

### El risc depèn de més factors que el tipus de dada

Cal considerar conjuntament:

- la naturalesa de les dades;
- la quantitat, la varietat i el grau de detall;
- el nombre i la vulnerabilitat de les persones afectades;
- la durada, l'accessibilitat i l'abast geogràfic;
- la possibilitat de combinar conjunts de dades;
- la finalitat, el context i les conseqüències possibles.

Per això, una llista massiva de correus electrònics pot requerir més cautela que un únic registre de salut ben protegit, encara que les dades de salut siguin jurídicament una categoria especial.

## 7. Drets de les persones

Segons el cas i la base jurídica, les persones poden exercir els drets següents:

- **accés** a les dades i a informació sobre el tractament;
- **rectificació** de dades inexactes;
- **supressió**, quan es compleixen les condicions legals;
- **oposició** a determinats tractaments;
- **limitació** del tractament;
- **portabilitat**, en els supòsits previstos;
- dret a **no ser objecte de determinades decisions basades únicament en tractaments automatitzats**.

No són drets absoluts. Per exemple, una petició de supressió no obliga necessàriament a eliminar dades que s'han de conservar per una obligació legal. Com a regla general, el responsable ha d'atendre la sol·licitud en un mes; el termini es pot ampliar dos mesos més segons la complexitat i el nombre de sol·licituds, informant-ne dins del primer mes.

## 8. Violacions de la seguretat de les dades personals

Una **violació de la seguretat de les dades personals** és un incident que ocasiona, accidentalment o il·lícitament:

- destrucció o pèrdua de dades (**disponibilitat**);
- alteració no autoritzada (**integritat**);
- comunicació o accés no autoritzat (**confidencialitat**).

Exemples: una còpia de seguretat inutilitzable, un `UPDATE` erroni que altera expedients, un repositori públic amb dades reals o un correu enviat al destinatari equivocat.

No tot incident de ciberseguretat afecta dades personals. En canvi, una errada no maliciosa pot ser una violació de dades personals.

### Què significa realment el termini de 72 hores?

1. Qui detecta l'incident l'ha d'escalar immediatament pel canal intern; no ha d'esperar a conèixer-ne tots els detalls.
2. L'encarregat informa el responsable sense dilació indeguda.
3. El responsable documenta **totes** les violacions.
4. El responsable notifica l'autoritat de control, si és probable que hi hagi risc per als drets i les llibertats, sense dilació indeguda i, si és possible, dins de les 72 hores des que n'ha tingut constància.
5. Si és probable que hi hagi un **risc alt**, també ho comunica a les persones afectades sense dilació indeguda, llevat que s'apliqui alguna excepció prevista a l'article 34.

Per tant, «qualsevol incident s'ha de notificar en 72 hores a l'autoritat» és fals. El que sempre s'ha de fer és actuar, avaluar i documentar; la notificació depèn del risc.

### Primera resposta d'un equip tècnic

- activar el procediment intern i avisar el punt de contacte establert;
- contenir l'incident sense destruir proves;
- preservar registres i construir una cronologia;
- identificar sistemes, dades, període i persones potencialment afectades;
- corregir la causa i reduir els danys;
- documentar fets, decisions i mesures.

No s'ha d'ocultar l'incident, manipular evidències ni comunicar-lo externament per iniciativa individual al marge del procediment de l'organització.

## 9. Activitat de tancament

Feu l'[exercici 1](./exercicis.md#exercici-1--mapa-de-dades-obligatori-10-min) i compareu les justificacions. L'objectiu no és només assignar una etiqueta, sinó explicar quin risc hi ha i quina decisió de disseny se'n deriva.

## Fonts per aprofundir

- [Principis de protecció de dades — APDCAT](https://www.apdcat.cat/ca/organitzacions/obligacions-quan-es-tracten-dades/aplicar-els-principis-de-proteccio-de-dades).
- [Bases jurídiques i categories especials — APDCAT](https://www.apdcat.cat/ca/organitzacions/obligacions-quan-es-tracten-dades/identificar-la-base-juridica-que-permeti-el-tractament).
- [Directrius 5/2020 sobre el consentiment — Comitè Europeu de Protecció de Dades](https://www.edpb.europa.eu/documents/guideline/guidelines-052020-on-consent-under-regulation-2016679_es).
- [Article 21 de la Llei 34/2002 sobre comunicacions comercials electròniques](https://www.boe.es/buscar/act.php?id=BOE-A-2002-13758#a21).
- [Drets de les persones afectades — APDCAT](https://www.apdcat.cat/ca/recursos/preguntes-frequeents-sobre-proteccio-de-dades/preguntes-per-a-persones-afectades/drets-de-les-persones-afectades).
- [Notificació de violacions de seguretat — APDCAT](https://www.apdcat.cat/ca/organitzacions/obligacions-quan-es-tracten-dades/notificar-les-violacions-de-seguretat-de-les-dades-personals).
