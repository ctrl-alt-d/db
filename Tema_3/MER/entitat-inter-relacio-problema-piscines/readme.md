# Entitat inter-relació - Problema: Piscines
## DAW-MP02-UF1 - Exercici de Introducció a les bases de dades
**Introducció**

MCD amb unes tretze entitats tipus més dues entitats subtipus. La complexitat d'aquest problema radica en identificar correctament, dins un text molt narratiu i ple d'exemples, els diferents elements: entitats, atributs i relacions. Són especialment interessants les interrelacions N:M històric destinacions i resultats dels tests d'anàlisi.

**Univers de Discurs**

Una empresa de productes i serveis per a piscina ofereix als seus clients un servei gratuit de control de l'estat de l'aigua de la piscina. Els clients disposen d'una tarjeta client amb un codi targeta, aquest número es fa servir per identificar el client. També interessa conèixer les dades de contacte del client: adreça amb carrer i número, el CP, la Població i un telèfon de contacte. Ens trobem que hi ha clients que són empresa, llavors cal emmagatzemar, a més, les dades fiscals: carrer i número, CP, Població, CIF/NIF, nom comercial i nom fiscal. En cas de ser particulars només emmagatzemem el DNI (opcional) i el nom i cognoms del client.

Quan és fa una anàlisi d'aigua ( un control ) és important saber les dades de la piscina. Interessa conèixer els mètres cúbics, si es tracta d'una piscina d'aigua de mar o en quin any va ser construida entre d'altres. Per no haver de demanar al client totes aquestes dades cada cop que es fa un control, les dades s'emmagatzemen a la base de dades associades al client. De manera que el client té entre una i n piscines. Les piscines es númeren de manera que tenim la piscina 1 del client X, la piscina 1 del client Y, la piscina 2 del client Y, etc. Com que hi ha clients amb vàries piscines, opcionalment, es pot posar al sistema un nom a la piscina per a que el client no hagi d'aprendre's els números. També cal poder anotar qualsevol comentari que es cregui interessant sobre la piscina així com en quina data es dona d'alta al sistema la piscina.

Per tal de mantenir les piscines en condicions, els clients, fan servir diferents tipus de depuració (pastilles de clor, oxígen actiu, cloració salina, etc ). Aquests tipus de depuració els tenim entrats a la base de dades, juntament amb un comentari. A cada piscina dels clients anotem quin o quins tipus combinats de depuració fan o han fet servir. De vegades els clients fan servir un únic tipus i d'altre vegades en combinen dos o més. En aquest darrer cas pot ser que un dels tipus de depuració sigui el principal. Per exemple un client pot fer servir ionització coure-plata com a tipus de depuració principal peròp ajudat de cloració manual. S'anota quan un client comença a usar un tipus de cloració i quan el deixa de fer servir. Això s'anomena 'aplicació depuració a piscina' i s'identifica per la piscina, el tipus de depuració i la data d'inici d'aplicació.

La quantitat de cal a l'aigua és un factor important, per això cal tenir em compte la duresa de l'aigua en el tractament de piscines. Amb els anys d'experiència l'empresa ha recollit la duresa de l'aigua de les poblacions dels seus clients. Llavors es disposa d'una relació de poblacions amb el grau de duresa de l'aigua d'aquella població. Als clients se'ls pregunta a quina població tenen situada la seva piscina.

Per fer un control de l'aigua de la piscina el client ha de portar a una botiga d'aquesta empresa una mostra d'aigua suficientment gran per poder fer els diferents tests sobre els diferents paràmetres a analitzar. Hi ha diferents tipus de test, per exemple es pot analitzar el PH, l'Alcalinitat, el clor lliure, el clor combinat i molts més altres paràmetres. Cada tipus de test l'identifiquem pel seu nom ( ex: Presència de Ferro ) i es guarda un comentari que ajuda als treballadors de l'empresa a conèixer millor per a que serveix aquell tipus de test. Exemples de comentari sobre el tipus de test: 1) és important conèixer les PPM de ferro doncs les piscines amb tipus de depuració cloració salina patiran problemes amb l'equip d'electròlosi si l'aigua conté massa quantitat d'aquest metall. 2) El coure és un element important en el metabolisme de les plantes i els animals i també s'usa per controlar el creixement bacteriològic en els tancs d'aigua potable. La corrosió de les canonades contribueix a les altes quantitats de coure a l'aigua. 

Per a cada tipus de test hi ha àmplia oferta de tests als mercat. Dels que fa servir l'empresa es guarda el nom del test ( ex: TEST KIT COBRE HI 38075 de Hanna instruments ) que fem servir per identificar-lo. Pot ser que el fabricant ens indiqui quin és el llindar mínim, màxim i òptim d'aquest test així com les unitats en que està expressat ( ex 1: PPM - parts per milió. ex 2: mg /l. )

Un control d'aigua a un client consisteix doncs en aplicar una sèrie de tests a l'aigua que porta aquell client en un determinat moment. Cada control l'identifiquem amb un codi de control i anotem en quin moment s'ha realitzat ( no s'anota el moment en que es realitza cada test, s'anota en quin moment es realitza tot el control ). També s'anoten, naturalment, els resultats de cada test realitzat ( el tècnic valora en cada cas segons les dades de la piscina quins tipus de test són els adients ). Associat al control es disposa d'un camp de comentaris on el tècnic pot fer anotacions.

Es pot donar el cas que, els resultats obtinguts al test, revelin que cal fer algun tractament a l'aigua. Aquesta empresa disposa de productes per a la realització d'aquests tractaments. Cadascun d'aquests productes per a fer tractaments té un codi ( és el mateix que el codi de barres ) un nom comercial i també anotem quin  és el principal principi actiu. Ex: Cloro rápido DICLORO granulado 1 Kg. El sistema ha de recollir quins productes han estat recomenats pel tècnic un cop realitzat el control. Aquests productes no estan relacionats amb el test individual sino amb el control, això és així perquè hi ha productes que actuen sobre diferents problemàtiques de l'aigua a la vegada o perquè alguns productes o combinacions de productes són millor indicats per a determinades combinacions de resultats dels tests.

Els treballadors són els encarregats de realitzar aquests testos. Un treballador que hagi fet baixa ja no pot realitzar testos naturalment. Només poder fer controls els treballadors que disposen de destinació tal i com s'explicarà a continuació. Del treballador només ens cal el NSS per identificar-lo, nom i cognoms i el seu correu. Com deiem, un treballador té una destinació, això vol dir que entre una data inici i una data fi ( pot ser no informada si encara té la destinació ) està treballant en una delegació. De la delegació ens interessa el codi de delegació ( identificador), l'adreça, CP, província, telèfon i mail. Quan es fa un control (un servei de control d'aigua a un client) ens interessa conèixer tant el treballador que el fa com la delegació allà on es fa, per aquest motiu, existeix una relació entre el control i la destinació del treballador a una delegació. Per identificar una destinació ho fem a través de la delegació on el treballador està destinat, el treballador i la data d'inici. Ex: El treballador amb NSS 999999 comença destinació a la delegació de l'Escala amb data 1 de març de 2016. Fixem-nos que és un mateix treballador qui fa tots els testos per a un control, per aquest motiu relacionem el treballador a nivell de control i no a nivell de test.

**Exercici**

Fes el MCD d'aquest Univers de Discurs.

**Passes recomenades per a la resolució del problema**

* Familiaritza't molt bé amb el text. Llegeix-lo les vegades que et faci falta. Fes-ho de manera individual.
* Identifica tot el que cal emmagatzemar a la base de dades, siguin entitats, atributs o relacions. Fes una marca amb llàpis al costat. Fes-ho de manera individual.
* Decideix quines seran les entitats ( encercla-les, només un cop cadascuna ). A partir d'aquí pots treballar en grup.
* Fel el MCD assignant els atributs a les entitats i dibuixant les relacions amb el seu tipus de correspondència.
* Comprova que no t'has deixat cap relació ni que tampoc n'has escrit cap que no estigui especificada a l'Univers de Discurs. Repassa el tipus de correspondència de les relacions.
* Comprova que no has confòs cap instància d'entitat per tipus d'entitat.
* Comprova que fas un bon un de les classes tipus i subtipus.
* Afina les cardinalitats.
* Fes una darrera repassada abans de posar-ho en net.


