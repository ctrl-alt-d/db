# Solucions orientatives

Aquest document resol els exercicis 1, 2 i 3. Els exercicis 4–7 queden sense resoldre perquè es puguin emprar com a pràctica o avaluació.

Les solucions són orientatives: en protecció de dades, el context, la finalitat, l'escala i les persones afectades poden canviar la valoració.

## Solució de l'exercici 1

| Element | Classificació orientativa | Risc i mesura possible |
|---|---|---|
| Nom i cognoms | Dada personal | Suplantació o localització. Recollir-los només si són necessaris i limitar-ne l'accés. |
| Adreça electrònica | Dada personal | *Phishing* o contacte no desitjat. Evitar-ne la publicació i verificar canvis de compte. |
| Contrasenya en text clar | Dada personal i disseny insegur | Compromís d'aquest compte i d'altres. No s'ha de conservar en text clar; cal una funció específica per a contrasenyes amb *salt* i paràmetres adequats. |
| Posició GPS cada 30 segons | Dada personal que pot implicar risc elevat pel detall i seguiment | Pot revelar domicili, rutines o visites. Reduir freqüència o precisió, limitar la retenció i desactivar el seguiment per defecte si no és imprescindible. |
| Fotografia de perfil | Dada personal | Exposició o reutilització. Perfil privat per defecte i control de visibilitat. No és automàticament dada biomètrica de categoria especial. |
| Plantilla facial per identificar unívocament | Categoria especial: dada biomètrica emprada per identificar unívocament | Suplantació i afectació persistent. Qüestionar-ne la necessitat, estudiar alternatives i verificar les condicions dels articles 6 i 9 de l'RGPD. |
| Diagnòstic mèdic | Categoria especial: dada de salut | Discriminació o revelació íntima. Valorar si n'hi ha prou amb registrar una necessitat d'accessibilitat i aplicar controls reforçats. |
| Recompte realment anònim per municipi | Informació no personal si la reidentificació no és raonablement probable | En municipis o grups petits pot haver-hi singularització. Aplicar llindars d'agregació i revisar el risc de reidentificació. |
| Identificador intern relacionable | Dada personal pseudonimitzada | La taula de correspondència permet reidentificar. Separar-la, limitar-ne l'accés i no presentar la pseudonimització com a anonimització. |
| Certificat d'antecedents penals | Dades de l'article 10; no són una categoria especial de l'article 9 | Estigmatització i discriminació. No recollir-lo sense una habilitació aplicable i garanties adequades. |

La classificació no determina tota sola la mesura. Per exemple, la freqüència del GPS i el temps de conservació poden canviar radicalment el risc.

## Solució de l'exercici 2

### Lliurament de la comanda

- **Finalitat:** tramitar i lliurar la compra.
- **Base possible:** execució del contracte, si l'adreça és necessària per al lliurament.
- **Minimització:** no demanar dades alienes al lliurament; compartir amb l'empresa logística només allò necessari.

### Documentació fiscal

- **Finalitat:** complir les obligacions fiscals aplicables.
- **Base possible:** obligació legal. Cal identificar la norma i el termini amb la persona responsable o assessora; no s'han d'inventar.
- **Minimització:** separar aquesta conservació d'altres usos. Conservar per obligació legal no autoritza a fer publicitat.

### Butlletí promocional opcional

- **Finalitat:** enviar comunicacions promocionals.
- **Base possible:** el consentiment podria ser adequat en aquest cas simplificat, separat de la compra, sense casella premarcada i fàcil de retirar. En un cas real també s'ha d'analitzar la normativa específica sobre comunicacions comercials.
- **Minimització:** no condicionar la compra i no recollir més dades de les necessàries per a l'enviament.

### Decisió automatitzada sobre pagament ajornat

- No hi ha prou informació per determinar la base jurídica ni si la decisió entra en l'article 22 de l'RGPD.
- Cal preguntar si la decisió és exclusivament automatitzada, quins efectes produeix, quines dades i lògica s'utilitzen i com es pot obtenir intervenció humana o impugnar-la.
- Analitzar totes les compres també exigeix valorar necessitat, proporcionalitat, transparència, exactitud i possibles biaixos.

### Grup sanguini per completar el perfil

- És una dada de salut i, per tant, una categoria especial.
- «Completar el perfil» no és una finalitat prou determinada ni mostra necessitat. En el cas descrit, la decisió correcta és no recollir-la.
- Afegir una casella de consentiment no converteix automàticament una recollida innecessària en adequada.

## Solució de l'exercici 3

### 1. Existència de la violació

L'accés no autenticat crea una revelació o un accés no autoritzat possible i afecta la confidencialitat. No cal esperar a trobar una còpia publicada per tractar el fet com una violació i activar-ne la gestió. L'absència d'evidència de descàrrega no sempre és evidència que no hi ha hagut accés.

### 2. Primera hora

Una resposta raonable seria:

1. avisar immediatament el canal intern d'incidents i les persones responsables;
2. tancar l'accés públic o aïllar el recurs, evitant destruir evidències;
3. preservar configuracions, registres, marques de temps i altres evidències;
4. revocar o rotar credencials i claus potencialment afectades quan sigui necessari;
5. identificar el conjunt exposat, el període i les proteccions existents;
6. iniciar una cronologia i documentar accions, responsables i incerteses.

### 3. Informació per valorar el risc

- categories i volum de dades i de persones;
- durada i abast de l'exposició;
- si hi ha indicis d'accés, indexació o descàrrega;
- algorisme, *salt* i paràmetres emprats per a les contrasenyes;
- conseqüències possibles: *phishing*, suplantació, accés a comptes o perjudicis físics i econòmics;
- col·lectius vulnerables;
- facilitat d'identificació i mesures de protecció;
- mesures de contenció ja aplicades.

### 4. Documentar, notificar i comunicar

- **Documentació interna:** sí. El responsable ha de documentar qualsevol violació, els fets, els efectes i les mesures correctores.
- **Notificació a l'autoritat:** cal una avaluació formal. Amb 18.000 persones, dades de contacte i informació de contrasenyes, hi ha elements importants de risc; no seria correcte descartar-la perquè encara no consti una descàrrega. La decisió correspon al responsable amb l'assessorament pertinent.
- **Comunicació a les persones:** té un llindar diferent: és exigible quan és probable un risc alt, llevat de les excepcions de l'article 34. Cal valorar especialment la robustesa de la protecció de les contrasenyes i les conseqüències possibles.

No s'ha d'esperar a acabar tota la investigació per fer una notificació inicial si és necessària; es pot completar gradualment.

### 5. Termini i responsabilitat

El termini es compta des que el responsable té constància de la violació amb prou certesa sobre la naturalesa i l'abast. El responsable del tractament és qui ha de notificar l'autoritat de control, si escau. L'encarregat ha d'informar el responsable sense dilació indeguda. La persona desenvolupadora ha d'escalar el fet immediatament segons el procediment intern.
