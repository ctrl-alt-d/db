# Entitat inter-relació - Exercicis dependència d'identificació
## Exercici de Introducció a les bases de dades
**Concepte de Dependència en Identificació**

Cada entitat ha de tenir un atribut o conjunt d'atributs que conformin l'AIP ( atribut identificador principal ). Tanmateix, de vegades ens trobem que no en fem prou amb els atributs de l'entitat per identificar-la unívocament i que necessitem incloure inter-relacions a l'AIP. En aquest cas estem parlant de **dependència en identificació**. Quan una entitat té dependència en identificació respecte alguna altre entitat diem que es tracta d'una **entitat feble**.

**Exemple de Dependència en Identificació**

*Un **metge** realitza **visites** als pacients. Ens interessa les dades del metge: **nom**, **número de col·legiat** (AIP ) i també les dades de la visita: **nom pacient visitat**, **moment** (data i hora exacta en que comença la visita), **durada** minuts que utilitza el metge per a visitar el pacient. Un metge no pot fer dues visites a la vegada, per tant, podem identificar les visites mitjançant el metge que la realitza i moment en que es realitzen.*

Fixem-nos que l'AIP de **visita** és l'atribut **moment** més la inter-relació **metge**. Per tant, aquí, ens trobem davant d'una dependència en identificació: depenem de **metge** per identificar **visita**. 

![Inter-relació amb dependència en identificació](http://i.imgur.com/i8KhNy0.png)

**Exercici**

1. Observa com canvia el diagrama model entitat inter-relació notació crow foot per expressar les dependències en identificació.
2. Fes el diagrama entitat‑relació per al següent univers de discurs:

*Ens interessa una base de dades per saber on viu la població. Emmagatzemarem les **ciutats** amb atributs: **nom** (AIP), **latitud**, **longitud** i **altitud** respecte al nivell del mar. També els **carrers**, identificats pel **nom** i per la ciutat a la qual pertanyen; pels carrers també emmagatzemarem la **llargada** (metres). També emmagatzemarem **edificis**, identificats pel **número** dins del carrer i pel carrer; un altre atribut d'edifici és l'**estat de conservació**. Tenim les **plantes**, identificades per l'edifici i pel **número de planta**, amb l'**alçada** respecte al nivell del carrer. Per últim, emmagatzemem els **habitatges**, identificats per la planta on es troben i pel número de **porta**; dels habitatges ens interessen els **metres quadrats**. Volem saber les **persones** que hi viuen. En un habitatge hi viuen entre zero i moltes persones. Hi ha persones que viuen al carrer, sense habitatge. De les persones ens interessa el **DNI** per identificar‑les, així com el **nom** i la **data de naixement**.*



