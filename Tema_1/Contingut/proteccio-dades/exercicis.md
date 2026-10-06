# Exercicis de protecció de dades

Els exercicis 1–4 són obligatoris. Els exercicis 5–7 són activitats opcionals d'ampliació. Cal justificar les respostes: enumerar mesures sense relacionar-les amb el cas no és suficient.

## Exercici 1 — Mapa de dades (obligatori, 10 min)

Una aplicació de mobilitat vol desar els elements següents:

1. nom i cognoms;
2. adreça electrònica;
3. contrasenya en text clar;
4. posició GPS cada 30 segons;
5. fotografia de perfil;
6. plantilla facial emprada per identificar unívocament la persona;
7. diagnòstic mèdic que justifica mobilitat reduïda;
8. recompte total, realment anònim, de trajectes per municipi;
9. identificador intern aleatori que es pot relacionar amb la taula d'usuaris;
10. certificat d'antecedents penals.

Per a cada element:

- determina primer si és una dada personal o informació realment anònima;
- si és una dada personal, indica si és una categoria especial de l'article 9, una dada sotmesa al règim de l'article 10 o una altra dada personal;
- descriu un risc possible;
- proposa una decisió de minimització o protecció.

> Les opcions no són totes excloents: una categoria especial i una dada sotmesa a l'article 10 també són dades personals. La diferència és que tenen condicions addicionals de tractament.

> No existeix una única mesura adequada per a totes les dades. Tingues en compte finalitat, volum, precisió i context.

## Exercici 2 — Finalitats i bases jurídiques (obligatori, 12 min)

Una botiga en línia proposa aquests tractaments:

- utilitzar l'adreça postal per lliurar una comanda;
- conservar la informació exigida per la normativa fiscal;
- enviar un butlletí promocional opcional;
- analitzar totes les compres per decidir automàticament a qui s'ofereix pagament ajornat;
- demanar el grup sanguini «per completar el perfil».

Per a cada tractament:

1. defineix la finalitat;
2. proposa la base jurídica que podria correspondre o indica quina informació falta per decidir-la;
3. aplica els principis de necessitat i minimització;
4. assenyala si apareix una categoria especial o una decisió automatitzada que requereix una anàlisi addicional.

## Exercici 3 — Triage d'una violació de seguretat (obligatori, 12 min)

Divendres a les 16.00 h, una persona desenvolupadora descobreix que una còpia de la base de dades de producció ha estat accessible sense autenticació durant dos dies. Conté noms, correus electrònics, adreces postals i l'*hash* de les contrasenyes de 18.000 clients. Els registres disponibles no permeten confirmar encara si algú l'ha descarregada.

Respon:

1. Per què pot ser una violació de la seguretat de dades personals encara que no consti cap descàrrega?
2. Quines accions faries durant la primera hora?
3. Quina informació necessita el responsable per valorar el risc?
4. S'ha de documentar? S'ha de notificar a l'autoritat? S'ha de comunicar als clients? Diferencia les tres decisions.
5. Quan comença el termini de 72 hores i qui és responsable de la notificació?

## Exercici 4 — Revisió de privacitat d'una aplicació (obligatori, 20 min)

Un centre de formació encarrega una aplicació de tutories. El primer disseny inclou:

```text
ALUMNE(
  id, nom, cognoms, data_naixement, dni, telefon,
  correu, salut, contrasenya, accepta_tot,
  creat_el, eliminat
)
```

L'equip també ha decidit que:

- el perfil és públic per defecte;
- totes les persones administradores comparteixen un mateix compte;
- cada nit es copia producció a l'entorn de proves;
- els *logs* desen el cos complet de totes les peticions;
- les dades es conserven indefinidament «per si de cas»;
- marcar `eliminat = true` resol qualsevol petició de supressió;
- un servei extern d'analítica rep totes les columnes de la taula.

En grups, redacteu una revisió amb aquesta estructura:

| Problema | Principi o risc | Canvi proposat | Com es provarà |
|---|---|---|---|

Incloeu com a mínim:

- una pregunta que l'equip tècnic hagi de fer al responsable;
- una mesura de minimització;
- una mesura de control d'accés;
- una decisió sobre proves i *logs*;
- una proposta de conservació i supressió;
- una comprovació relativa al proveïdor extern;
- una funcionalitat necessària per atendre drets.

Aquest exercici no té solució publicada. S'avaluen la justificació, la proporcionalitat i la capacitat de verificar les mesures.

## Exercici 5 — Drets i arquitectura distribuïda (ampliació, 20 min)

Les dades d'una persona poden aparèixer a PostgreSQL, un índex de cerca, una cua de missatges, fitxers exportats, una eina de suport i còpies de seguretat.

Dissenya el flux per atendre una petició de:

- accés;
- rectificació;
- limitació del tractament;
- supressió.

Indica com verificaràs la identitat, evitaràs revelar dades d'altres persones, propagaràs els canvis, tractaràs els errors parcials i deixaràs evidència del procés. Explica de manera específica què passarà amb les còpies de seguretat.

## Exercici 6 — Esborrany d'un registre d'activitats de tractament (ampliació, 20 min)

Elabora una entrada simplificada del registre d'activitats de tractament (RAT) per a la gestió de comandes d'una botiga en línia. Inclou:

- finalitats;
- categories de persones i de dades;
- base o bases jurídiques;
- categories de destinataris;
- possibles transferències internacionals;
- terminis de supressió o criteris per determinar-los;
- descripció general de les mesures tècniques i organitzatives.

No inventis terminis legals. Quan no disposis de prou informació, formula la pregunta que caldria resoldre.

Pots consultar l'[aplicació RAT i l'explicació de l'APDCAT](https://www.apdcat.cat/ca/recursos/aplicacions-apdcat/aplicacio-per-gestionar-el-registre-de-les-activitats-de-tractam).

## Exercici 7 — Pla de resposta a una violació (ampliació, 20 min)

Una actualització ha canviat els permisos i permet que qualsevol client autenticat descarregui factures d'altres clients si modifica un identificador de l'URL. Les factures contenen nom, adreça, compres i quatre darrers dígits del compte de pagament.

Prepara:

1. una cronologia de resposta des de la detecció;
2. una llista d'evidències que s'han de conservar;
3. una primera estimació de persones, registres i conseqüències possibles;
4. mesures immediates i mesures per evitar la repetició;
5. la informació que caldria facilitar a qui decideixi sobre la notificació;
6. un esborrany breu de comunicació a les persones afectades, condicionat al fet que l'avaluació conclogui que hi ha un risc alt.

No incloguis dades personals reals a l'esborrany.

## Criteris comuns d'avaluació

- Identifica correctament dades, actors i principis.
- Distingeix obligació jurídica, decisió organitzativa i implementació tècnica.
- Relaciona cada mesura amb un risc o un requisit.
- Evita afirmacions absolutes com «tot s'ha de xifrar igual» o «el consentiment ho permet tot».
- Proposa mesures verificables, no només intencions.
- Utilitza terminologia precisa i comunica amb claredat.
