# Entitat interrelació — Problema: Piscines
##  Exercici: Introducció a les bases de dades

### Introducció

MCD (Model Conceptual de Dades) amb unes tretze entitats tipus i dues entitats subtipus. La complexitat d'aquest problema radica en identificar correctament, dins d'un text molt narratiu i ple d'exemples, els diferents elements: entitats, atributs i interrelacions. Són especialment rellevants les interrelacions N:M, l'històric de destinacions i els resultats dels tests d'anàlisi.

### Univers de discurs

Una empresa de productes i serveis per a piscines ofereix als seus clients un servei gratuït de control de l'estat de l'aigua. Els clients disposen d'una targeta amb un codi; aquest número s'utilitza per identificar el client. També interessa conèixer les dades de contacte del client: adreça (carrer i número), C.P., població i telèfon de contacte. Hi ha clients que són empreses; en aquest cas cal emmagatzemar, a més, les dades fiscals: adreça (carrer i número), C.P., població, CIF/NIF, nom comercial i nom fiscal. En el cas de particulars només s'emmagatzema el DNI (opcional) i el nom i cognoms del client.

Quan es fa una anàlisi d'aigua (un control) és important saber les dades de la piscina. Interessa conèixer els metres cúbics, si es tracta d'una piscina d'aigua de mar i en quin any va ser construïda, entre altres dades. Per no haver de demanar al client aquestes dades cada cop que es fa un control, s'emmagatzemen a la base de dades i s'associen al client. Així, el client pot tenir entre una i n piscines. Les piscines es numeren per client (piscina 1 del client X, piscina 1 del client Y, piscina 2 del client Y, etc.). Com que hi ha clients amb diverses piscines, opcionalment es pot donar un nom a la piscina perquè el client no hagi d'aprendre's els números. També cal poder anotar qualsevol comentari rellevant sobre la piscina, així com la data d'alta al sistema.

Per tal de mantenir les piscines en condicions, els clients fan servir diferents tipus de depuració (pastilles de clor, oxigen actiu, cloració salina, etc.). Aquests tipus es registren a la base de dades amb un comentari. A cada piscina s'anota quin o quins tipus combinats de depuració s'utilitzen o s'han utilitzat. De vegades els clients utilitzen un únic tipus i altres vegades en combinen dos o més. En aquest cas, un dels tipus pot ser considerat principal. Per exemple, un client pot utilitzar ionització coure‑plata com a tipus de depuració principal i complementar‑ho amb cloració manual. S'anota quan un client comença a utilitzar un tipus de depuració i quan el deixa de fer servir. Això s'anomena "aplicació de depuració a piscina" i s'identifica per la piscina, el tipus de depuració i la data d'inici.

La quantitat de cal a l'aigua és un factor important; per això cal tenir en compte la duresa de l'aigua en el tractament de piscines. Amb els anys d'experiència l'empresa ha recollit la duresa de l'aigua de les poblacions dels seus clients. Així es disposa d'una relació de poblacions amb el grau de duresa de l'aigua d'una població concreta. Als clients se'ls pregunta a quina població tenen situada la seva piscina.

Per fer un control de l'aigua de la piscina el client ha de portar a una botiga d'aquesta empresa una mostra d'aigua suficientment gran per poder realitzar els diferents tests sobre els paràmetres a analitzar. Hi ha diferents tipus de test; per exemple, es pot analitzar el pH, l'alcalinitat, el clor lliure, el clor combinat i molts altres paràmetres. Cada tipus de test s'identifica pel seu nom (ex.: Presència de ferro) i es guarda un comentari que ajuda els treballadors de l'empresa a conèixer millor per a què serveix aquell test. Exemples de comentaris sobre el tipus de test: 1) és important conèixer les ppm de ferro perquè les piscines depurades per cloració salina poden patir problemes amb l'equip d'electròlisi si l'aigua conté massa quantitat d'aquest metall; 2) el coure és un element important en el metabolisme de plantes i animals i també s'usa per controlar el creixement bacteriològic en tancs d'aigua potable. La corrosió de les canonades contribueix a les altes quantitats de coure a l'aigua.

Per a cada tipus de test hi ha una àmplia oferta de kits al mercat. Dels que fa servir l'empresa es guarda el nom del kit (ex.: TEST KIT COBRE HI 38075 de Hanna Instruments) que fem servir per identificar-lo. Pot ser que el fabricant indiqui quin és el llindar mínim, màxim i òptim d'aquest kit, així com les unitats en què està expressat (ex.: ppm — parts per milió; mg/l).

Un control d'aigua a un client consisteix, doncs, en aplicar una sèrie de tests a l'aigua que porta aquell client en un determinat moment. Cada control s'identifica amb un codi de control i s'anota en quin moment s'ha realitzat (no s'anota el moment en què es realitza cada test; s'anota el moment en què es realitza tot el control). També s'anoten els resultats de cada test realitzat (el tècnic decideix, segons les dades de la piscina, quins tipus de tests són adients). Associat al control hi ha un camp de comentaris on el tècnic pot fer anotacions.

Es pot donar el cas que els resultats obtinguts als tests revelin que cal fer algun tractament a l'aigua. Aquesta empresa disposa de productes per a la realització d'aquests tractaments. Cadascun d'aquests productes té un codi (és el mateix que el codi de barres), un nom comercial i també s'anota quin és el principi actiu principal. Ex.: "Cloro rápido DICLORO granulado 1 Kg". El sistema ha de recollir quins productes han estat recomanats pel tècnic un cop realitzat el control. Aquests productes no estan relacionats amb el test individual sinó amb el control; això és així perquè hi ha productes que actuen sobre diferents problemàtiques a la vegada o perquè alguns productes o combinacions són més indicats per a determinades combinacions de resultats dels tests.

Els treballadors són els encarregats de realitzar aquests tests. Un treballador que hagi fet baixa ja no pot realitzar tests, naturalment. Només poden fer controls els treballadors que disposin de destinació, tal com s'explicarà a continuació. Del treballador només cal el NSS per identificar-lo, nom i cognoms i el seu correu electrònic. Com dèiem, un treballador té una destinació; això vol dir que entre una data d'inici i una data de fi (pot ser no informada si encara té la destinació) està treballant en una delegació. De la delegació ens interessa el codi de delegació (identificador), l'adreça, C.P., província, telèfon i correu electrònic. Quan es fa un control (un servei de control d'aigua a un client) ens'interessa conèixer tant el treballador que el fa com la delegació on es fa; per això existeix una relació entre el control i la destinació del treballador a una delegació. Per identificar una destinació ho fem a través de la delegació on el treballador està destinat, el treballador i la data d'inici. Ex.: el treballador amb NSS 999999 comença destinació a la delegació de l'Escala amb data 1 de març de 2016. Fixem-nos que és el mateix treballador qui fa tots els tests per a un control; per aquest motiu relacionem el treballador a nivell de control i no a nivell de test.

### Exercici

Fes el MCD d'aquest univers de discurs.

### Passes recomenades per a la resolució del problema

- Familiaritza't molt bé amb el text. Llegeix-lo tantes vegades com faci falta. Fes-ho de manera individual.
- Identifica tot el que cal emmagatzemar a la base de dades: entitats, atributs o relacions. Marca-ho amb llapis al costat. Fes-ho de manera individual.
- Decideix quines seran les entitats (encercla-les, només un cop cadascuna). A partir d'aquí pots treballar en grup.
- Fes el MCD assignant els atributs a les entitats i dibuixant les relacions amb el seu tipus de correspondència.
- Comprova que no t'has deixat cap relació ni n'has afegit cap que no estigui especificada a l'univers de discurs. Repassa el tipus de correspondència de les relacions.
- Comprova que no has confós cap instància d'entitat amb un tipus d'entitat.
- Comprova que fas un bon ús de les classes tipus i subtipus.
- Afina les cardinalitats.
- Fes una darrera repassada abans de passar-ho a net.
