# Protecció de dades en aplicacions i bases de dades

Aquest bloc introdueix la protecció de dades personals i la connecta amb les decisions que pren un equip de desenvolupament: quines dades recull, com les modela, qui hi pot accedir, durant quant de temps les conserva i què fa si es produeix un incident.

> **Durada del contingut obligatori:** 2 sessions de 60 minuts. El material d'ampliació permet afegir una tercera sessió pràctica.
>
> **Abast:** material didàctic introductori. Davant d'un cas real, cal seguir els procediments de l'organització i consultar la persona delegada de protecció de dades (DPD) o assessorament especialitzat.

## Objectius d'aprenentatge

En acabar, l'alumnat hauria de poder:

- distingir dada personal, dada pseudonimitzada i dada anònima;
- identificar els actors i els principis bàsics del Reglament general de protecció de dades (RGPD);
- explicar per què el consentiment no és l'única base jurídica;
- reconèixer les categories especials de dades i altres dades que poden comportar un risc elevat;
- diferenciar un incident de seguretat d'una violació de la seguretat de les dades personals;
- aplicar la protecció de dades des del disseny i per defecte en una aplicació;
- proposar mesures coherents amb el risc: minimització, control d'accés, xifratge, registre d'activitat i política de conservació, entre d'altres.

## Itinerari de dues hores

### Sessió 1 — Conceptes generals

| Temps | Activitat |
|---:|---|
| 0–5 min | Cas inicial: «Una dada pública deixa de ser personal?» |
| 5–25 min | Conceptes, actors, principis i bases jurídiques |
| 25–40 min | Tipus de dades i tractament segons el risc |
| 40–50 min | Violacions de seguretat i regla de les 72 hores |
| 50–60 min | Exercici 1 i posada en comú |

Material: [Sessió 1 — Fonaments](./sessio-1-fonaments.md).

### Sessió 2 — Aplicació al desenvolupament

| Temps | Activitat |
|---:|---|
| 0–5 min | Recuperació dels conceptes de la sessió anterior |
| 5–25 min | Protecció de dades durant el cicle de vida del programari |
| 25–35 min | Pseudonimització, anonimització i mesures de seguretat |
| 35–55 min | Exercici 4: revisió d'una aplicació |
| 55–60 min | *Checklist* de lliurament i conclusions |

Material: [Sessió 2 — Guia per a desenvolupadors](./sessio-2-desenvolupadors.md).

## Activitats i material de consulta

- [Exercicis](./exercicis.md): quatre activitats obligatòries i tres d'ampliació.
- [Solucions orientatives](./solucions-orientatives.md): solucions dels exercicis 1, 2 i 3. La resta queden oberts per practicar o avaluar.
- [Preguntes freqüents (FAQ)](./faq.md): dubtes habituals i errors freqüents.
- [Resum](./resum.md): full de repàs d'una pàgina.
- [Reglament de la UE, llei orgànica i reial decret](./llei-vs-reglament.md): aclariment sobre els tipus de norma.

## Ampliació opcional — Tercera sessió

Si es disposa de 60 minuts més, es recomana dedicar-los a un taller amb els exercicis 5, 6 i 7: drets de les persones, modelatge d'un registre d'activitats de tractament i resposta davant d'una violació de seguretat. Aquest temps addicional permet justificar les decisions, que és més valuós que memoritzar una llista d'obligacions.

## Fonts bàsiques

- [Reglament (UE) 2016/679 — text en català](https://www.apdcat.cat/content/dam/aem-apdcat/normativa-i-jurisprudencia/RGPD_ca.pdf), especialment els articles 4–6, 9, 12–22, 25 i 32–35.
- [Llei orgànica 3/2018 (LOPDGDD)](https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673).
- [Guia per a desenvolupadors de l'APDCAT](https://www.apdcat.cat/content/dam/aem-apdcat/03-documentacio/documents/guiadesenvolupadors/GUIA-PDDD.pdf).
- [Obligacions de les organitzacions — APDCAT](https://www.apdcat.cat/ca/organitzacions/obligacions-quan-es-tracten-dades).

> **Criteri de lectura:** les guies de les autoritats de control ajuden a aplicar la normativa, però no substitueixen l'anàlisi del cas concret.
