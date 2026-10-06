# Resum — Protecció de dades

## Què protegeix l'RGPD?

Protegeix les persones físiques respecte del **tractament** de les seves **dades personals**. Tractar inclou recollir, consultar, relacionar, comunicar, conservar i suprimir.

- **Dada anònima:** la persona no és identificable per mitjans raonablement probables; si l'anonimització és efectiva, no és dada personal.
- **Dada pseudonimitzada:** es necessita informació addicional per atribuir-la a una persona; continua sent dada personal.

## Principis

1. Licitud, lleialtat i transparència.
2. Limitació de la finalitat.
3. Minimització de dades.
4. Exactitud.
5. Limitació del termini de conservació.
6. Integritat i confidencialitat.
7. Responsabilitat proactiva: complir i poder-ho demostrar.

## Base jurídica

Cada finalitat necessita una base jurídica: consentiment, contracte, obligació legal, interessos vitals, missió d'interès públic o poders públics, o interès legítim en els supòsits aplicables. **El consentiment no és l'única base ni permet ignorar la minimització.**

## Tipus de dades i risc

- Les categories especials de l'article 9 inclouen origen racial o ètnic, opinions polítiques, conviccions religioses o filosòfiques, afiliació sindical, dades genètiques, biomètriques per identificar unívocament, salut, vida sexual i orientació sexual.
- Les dades sobre condemnes i infraccions penals tenen un règim separat a l'article 10.
- Ubicació, dades econòmiques, credencials, identificadors oficials o dades de menors no són sempre categories especials, però poden implicar un risc elevat.
- El risc també depèn del volum, la precisió, les combinacions, l'accessibilitat, la durada, el context i les conseqüències.

## Actors

- **Responsable:** decideix les finalitats i els mitjans.
- **Encarregat:** tracta dades per compte del responsable seguint-ne les instruccions.
- **DPD:** assessora i supervisa amb independència en els casos en què existeix aquesta figura; no és obligatori en totes les organitzacions.

## Drets

Accés, rectificació, supressió, oposició, limitació, portabilitat i garanties davant determinades decisions automatitzades. No són absoluts. Com a regla general, les sol·licituds s'han d'atendre en un mes, ampliable dos mesos més quan estigui justificat i se n'informi dins del primer mes.

## Per a desenvolupadors

- Definir finalitat, dades necessàries, accessos i termini abans de programar.
- Aplicar protecció de dades des del disseny i per defecte.
- Usar dades sintètiques en proves sempre que sigui possible.
- Aplicar mínim privilegi, identitats individuals i revisió de permisos.
- Protegir trànsit, emmagatzematge, claus, contrasenyes i còpies segons el risc.
- No desar secrets, tokens ni formularis complets als *logs*.
- Dissenyar l'accés, la rectificació, la limitació, l'exportació i la supressió.
- Revisar proveïdors, subencarregats, ubicacions i transferències.
- Documentar i provar les mesures.

## Violació de la seguretat de les dades personals

Pot afectar:

- **confidencialitat:** accés o revelació no autoritzats;
- **integritat:** alteració no autoritzada;
- **disponibilitat:** destrucció, pèrdua o indisponibilitat.

Cal escalar, contenir, preservar evidències, analitzar i documentar. El responsable notifica l'autoritat si és probable que hi hagi risc, si és possible dins de les 72 hores des que en té constància. Si és probable un risc alt, també comunica la violació a les persones afectades, llevat de les excepcions aplicables.

> **Idea clau:** no es protegeixen bases de dades en abstracte; es protegeixen les persones davant les conseqüències de l'ús de les seves dades.
