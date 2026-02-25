# Entitat inter-relació - Exercicis dependència d'identificació
## DAW-MP02-UF1 - Exercici de Introducció a les bases de dades
**Concepte de Dependència en Identificació**

Cada entitat ha de tenir un atribut o conjunt d'atributs que conformin l'AIP ( atribut identificador principal ). Tanmateix, de vegades ens trobem que no en fem prou amb els atributs de l'entitat per identificar-la unívocament i que necessitem incloure inter-relacions a l'AIP. En aquest cas estem parlant de **dependència en identificació**. Quan una entitat té dependència en identificació respecte alguna altre entitat diem que es tracta d'una **entitat feble**.

**Exemple de Dependència en Identificació**

*Un **metge** realitza **visites** als pacients. Ens interessa les dades del metge: **nom**, **número de col·legiat** (AIP ) i també les dades de la visita: **nom pacient visitat**, **moment** (data i hora exacta en que comença la visita), **durada** minuts que utilitza el metge per a visitar el pacient. Un metge no pot fer dues visites a la vegada, per tant, podem identificar les visites mitjançant el metge que la realitza i moment en que es realitzen.*

Fixem-nos que l'AIP de **visita** és l'atribut **moment** més la inter-relació **metge**. Per tant, aquí, ens trobem davant d'una dependència en identificació: depenem de **metge** per identificar **visita**. 

![Inter-relació amb dependència en identificació](http://i.imgur.com/i8KhNy0.png)

**Exercici**

1. Observa com canvia el diagrama model entitat inter-relació notació crow foot per expressar les dependències en identificació.
2. Fes el diagrama entitat inter-relació d'aquest univers de discurs: *Ens interesa una base de dades per saber allà on viu la població. Emmagatzemarem les **ciutats** amb atributs: **nom** (AIP), **latitud**, **longitud**, **alçada respecte el mar**. També els **carrers** que s'identifiquen pel **nom** i per la ciutat a la que pertanyen. Pels carrers també emmagatzemem la **llargada** en metres. També emmagatzemem **edificis** que s'identifiquen pel **número** dins el carrer més el carrer. Un altre atributs d'edifici és l'**estat de conservació**. Tenim les **plantes** que s'identifiquen per l'edifici i pel **número de planta**. Emmagatzemem també l'**alçada** que es troba aquella planta respecte el nivell del carrer. Per últim emmagatzemem els **habitatges** que s'identifiquen per la planta en que es troben més el número de **porta**. Dels habitatges ens interessa els **metres quadrats**. Volem saber les **persones** que hi viuen allà. En un habitatge hi vieuen entre cap i moltes persones. Hi ha persones que viuen al carrer, sense habitatge. De les persones ens interessa el **DNI** per identificar-los i també el **nom** i **data de naixement**.* 



