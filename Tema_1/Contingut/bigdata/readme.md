# BigData: Anàlisi de dades - Intel·ligència de negoci

## Introducció

El Big Data és el conjunt massiu de dades que es genera i es recopila a gran escala a partir de fonts molt diverses com xarxes socials, dispositius mòbils, sensors, transaccions financeres, entre d’altres. Aquest volum de dades és tan gran i complex que les eines i tècniques tradicionals no poden gestionar-lo de manera eficient. El Big Data permet analitzar aquestes dades per extreure'n informació valuosa, identificar patrons, tendències i prendre decisions informades en camps tan diversos com el màrqueting, la salut, les finances i moltes altres àrees de coneixement. La seva importància creix amb l'augment de la digitalització i la quantitat d'informació disponible.

El Big Data ha transformat la manera com les empreses operen i prenen decisions. L'anàlisi de grans volums de dades permet a les empreses obtenir informació detallada sobre els seus clients, operacions internes i tendències del mercat. Això facilita la personalització d'ofertes, l'optimització de processos i la millora de l'eficiència operativa. A més, el Big Data permet anticipar-se a canvis del mercat i predir comportaments futurs, oferint un avantatge competitiu important.

D’altra banda, els sistemes ERP (Enterprise Resource Planning) gestionen de manera integrada diferents processos empresarials com la comptabilitat, la gestió de recursos humans, la producció o la logística. Quan el Big Data s'integra en un ERP, aquest pot aprofitar la gran quantitat de dades que es generen dins i fora de l'empresa, oferint una visió més precisa i detallada de totes les àrees operatives. Això permet una millor presa de decisions estratègiques basades en dades reals i actualitzades en temps real, millorant la planificació, la previsió de demandes i la gestió eficient de recursos.

## Exemples

| **Mòdul ERP**       | **Exemples de Big Data**                                                                                  |
|---------------------|----------------------------------------------------------------------------------------------------------|
| **Recursos Humans**  | Anàlisi del rendiment dels empleats, predicció de rotació de personal, recomanacions per a promocions.     |
| **Facturació**       | Predicció de vendes futures, identificació de patrons de comportament dels clients, anàlisi de vendes per regions. |
| **Tresoreria**       | Optimització del flux de caixa, previsió de liquiditat, anàlisi de tendències de pagament de clients.      |
| **Comptabilitat**    | Detecció de fraus, informes financers avançats, anàlisi de patrons de despesa, previsió d'ingressos.       |
| **Logística**        | Optimització de rutes de distribució, previsió de demanda, seguiment de l'inventari en temps real.         |
| **Vendes**           | Anàlisi de comportament dels clients, recomanacions de productes personalitzades, segmentació de mercat.   |
| **Màrqueting**       | Anàlisi de campanyes de màrqueting, personalització de missatges publicitaris, seguiment de tendències de mercat. |
| **Producció**        | Anàlisi de rendiment de maquinària, predicció de fallades tècniques, optimització de la producció segons demanda. |


## El reporting vs el panell d'indicadors

Un **dashboard**, o **panell de control**, és una eina visual interactiva que permet monitoritzar en temps real els indicadors clau de rendiment (KPIs) d'una empresa. Ofereix una visió ràpida i centralitzada de les dades, facilitant la presa de decisions informades de manera àgil i eficient.

El **reporting** és el procés de creació d'informes detallats i formals que analitzen dades històriques per oferir una comprensió profunda del rendiment d'una organització. Aquests informes permeten prendre decisions estratègiques basades en dades concretes i ben estructurades.


### Reporting
- **Objectiu**: Informes detallats que ofereixen una anàlisi profunda i històrica de les dades. Ideal per obtenir informació precisa sobre aspectes específics de l'empresa.
- **Freqüència**: Es generen periòdicament (diari, setmanal, mensual) o sota demanda.
- **Format**: Generalment es presenten en documents com PDFs, fulls de càlcul o altres formats amb text, taules, gràfics i explicacions detallades.
- **Tipus de dades**: S'inclouen dades detallades que ajuden a entendre el passat i fer anàlisis exhaustives.
- **Públic destinatari**: S'adrecen a equips o directius que necessiten informes formals i detallats per a la presa de decisions més reflexives.
- **Exemple**: Un informe mensual de vendes que mostra el desglossament per regió, producte i rendiment dels venedors.

### Dashboard
- **Objectiu**: Un dashboard proporciona una visió ràpida i visual dels indicadors clau de l'empresa (KPIs) en temps real o gairebé en temps real.
- **Freqüència**: Es caracteritzen per l'actualització constant de dades per monitoritzar en temps real.
- **Format**: Són visuals i interactius, amb gràfics i taules dinàmiques que permeten als usuaris explorar les dades.
- **Tipus de dades**: Ofereixen un resum d'indicadors clau, centrats en el monitoratge i la presa de decisions immediates.
- **Públic destinatari**: Ideals per a directius o responsables que necessiten una supervisió constant per prendre decisions ràpides.
- **Exemple**: Un dashboard que mostra les vendes diàries, el trànsit web i el rendiment de les campanyes de màrqueting en temps real.


## OLTP VS OLAP 

Una base de dades per a Big Data (OLAP) és una eina dissenyada per emmagatzemar, gestionar i processar grans volums de dades que poden ser estructurades, semiestructurades o no estructurades. Aquestes bases de dades permeten l’escalabilitat horitzontal, el processament distribuït i l’anàlisi de dades en temps real o gairebé en temps real, aspectes fonamentals per a les aplicacions modernes que tracten amb grans quantitats d’informació.

### OLTP (Online Transaction Processing)

OLTP és un sistema que es centra en la gestió de transaccions en temps real. Aquest tipus de sistemes s'utilitza en aplicacions com el comerç electrònic, les aplicacions bancàries o els sistemes de punt de venda. Les seves característiques principals són:

- **Consultes curtes i senzilles**: Les consultes són ràpides, dirigides a la manipulació i recuperació de dades per a transaccions individuals, com insercions, actualitzacions o eliminacions.
- **Alta consistència**: OLTP està dissenyat per mantenir la consistència de les dades durant múltiples transaccions simultànies, seguint el model **ACID**.
- **Base de dades normalitzades**: S'utilitzen bases de dades altament normalitzades per evitar la redundància de dades.

### OLAP (Online Analytical Processing)

OLAP és un sistema orientat a l'anàlisi de grans volums de dades històriques per a la presa de decisions estratègiques. Aquestes dades es processen de manera multidimensional per permetre l'extracció d'informació i l'anàlisi avançada. Les seves característiques principals són:

- **Consultes complexes**: Les consultes són més lentes i solen implicar l'agrupació i agregació de dades per generar informes i analítiques detallades.
- **Dades històriques**: OLAP s'utilitza per analitzar dades acumulades al llarg del temps, sovint amb finalitats de **Business Intelligence**.
- **Base de dades desnormalitzades**: Les dades es guarden en formats desnormalitzats per optimitzar la velocitat de consulta.

### Diferències principals

| Característica      | OLTP                            | OLAP                                   |
|---------------------|---------------------------------|----------------------------------------|
| **Objectiu**        | Gestió de transaccions diàries  | Anàlisi de dades històriques           |
| **Consultes**       | Curtes, enfocades a transaccions| Llargues, complexes i agregades        |
| **Model de dades**  | Normalitzat                     | Desnormalitzat                         |
| **Velocitat**       | Alta velocitat per transaccions individuals | Alta velocitat per consultes agregades |
| **Exemples d'ús**   | Comerç electrònic, banca        | Business Intelligence, informes executius |

### Altres diferències

| **Característica**                   | **Base de Dades Big Data (OLAP)**                                | **Base de Dades Operacional (OLTP)**                             |
|--------------------------------------|------------------------------------------------------------------|------------------------------------------------------------------|
| **Objectiu principal**               | Emmagatzemar i processar grans volums de dades, sovint no estructurades o semiestructurades. | Suportar operacions diàries com transaccions, actualitzacions i recuperació de dades. |
| **Tipus de dades**                   | Dades estructurades, semiestructurades i no estructurades.        | Dades estructurades (taules, files i columnes).                   |
| **Escalabilitat**                    | Escalabilitat horitzontal (distribució en molts servidors).       | Escalabilitat vertical (millora del rendiment del servidor individual). |
| **Volum de dades**                   | Dissenyada per gestionar petabytes o exabytes de dades.           | Generalment gestiona megabytes o gigabytes de dades.              |
| **Velocitat de processament**        | Optimitzada per a la ingesta i processament ràpid de grans volums de dades, sovint en temps real. | Optimitzada per a transaccions ràpides i consultes curtes.        |
| **Integritat de dades**              | Menys estricta, sovint es prioritzen el volum i la velocitat sobre la consistència. | Alta integritat i consistència de dades a nivell transaccional.  |
| **Processament**                     | Processament per lots o en temps real, sovint analític (OLAP).    | Processament en temps real per transaccions petites (OLTP).       |
| **Exemples de bases de dades**       | Hadoop, Cassandra, MongoDB, Amazon Redshift, Google BigQuery.     | MySQL, PostgreSQL, Oracle, SQL Server.                           |
| **Ús típic**                         | Anàlisi de dades massives, prediccions, machine learning, informes analítics. | Aplicacions de gestió empresarial, transaccions bancàries, comerç electrònic. |
| **Consistència de les dades**        | Sovint ofereix consistència eventual (BASE).                      | Consistència forta i immediata (ACID).                           |


### 1. Hadoop (HDFS)
- **Descripció**: Hadoop Distributed File System (HDFS) és una solució de codi obert per emmagatzemar i processar grans quantitats de dades distribuïdes en múltiples servidors.
- **Característiques**: Altament escalable, ideal per dades no estructurades, i permet processar grans volums de dades de manera distribuïda.
- **Ús**: Anàlisi de dades massives i de diversos formats, especialment en entorns de Big Data.

### 2. NoSQL
- **Descripció**: Les bases de dades NoSQL estan dissenyades per gestionar grans volums de dades no estructurades o semiestructurades.
- **Exemples populars**: MongoDB, Cassandra, Couchbase.
- **Característiques**: Flexible, altament escalable, i permeten manejar dades en diversos formats com JSON o XML.
- **Ús**: Aplicacions web, xarxes socials, sistemes que requereixen escalabilitat horitzontal i treballen amb dades no estructurades.

### 3. Apache Cassandra
- **Descripció**: Una base de dades NoSQL distribuïda i altament escalable, especialment dissenyada per gestionar grans volums de dades a través de múltiples centres de dades.
- **Característiques**: Alta disponibilitat, escalabilitat horitzontal i tolerància a fallades.
- **Ús**: Aplicacions amb grans volums de dades que requereixen alt rendiment i distribució global.

### 4. MongoDB
- **Descripció**: Una base de dades NoSQL orientada a documents que permet emmagatzemar i recuperar dades en formats de tipus document (com JSON).
- **Característiques**: Flexible, escalable, i ideal per a dades semiestructurades.
- **Ús**: Aplicacions dinàmiques amb dades canviants, com xarxes socials, catàlegs de productes, i aplicacions mòbils.

### 5. Amazon Redshift
- **Descripció**: Un magatzem de dades basat en el núvol d'Amazon, dissenyat per analitzar grans volums de dades estructurades.
- **Característiques**: Altament escalable, rendiment ràpid, i integra eines d’anàlisi de dades.
- **Ús**: Magatzematge i anàlisi de dades estructurades en grans empreses.

### 6. Google BigQuery
- **Descripció**: Una plataforma d’anàlisi de Big Data basada en el núvol que permet executar consultes SQL a gran escala.
- **Característiques**: Escalable, ràpid, i dissenyat per analitzar dades massives en temps real.
- **Ús**: Anàlisi de dades massives, informes en temps real i aplicacions d'anàlisi avançada.

### 7. Apache Spark
- **Descripció**: Tot i que no és una base de dades, Apache Spark és una eina d'anàlisi de dades massives en memòria, ideal per a processament de Big Data.
- **Característiques**: Processament ràpid, escalabilitat, i pot treballar amb diverses fonts de dades, incloent Hadoop.
- **Ús**: Anàlisi de dades massives en temps real i aplicacions d'aprenentatge automàtic.

### 8. Elasticsearch
- **Descripció**: Un motor de cerca i anàlisi distribuït que permet indexar i buscar grans quantitats de dades.
- **Característiques**: Ideal per a cerca en temps real i anàlisi de dades textuals.
- **Ús**: Cerca de textos, aplicacions d'anàlisi de registres (logs) i anàlisi de dades estructurades i no estructurades.

### 9. Neo4j
- **Descripció**: Una base de dades orientada a gràfics que emmagatzema dades i les seves relacions com a nodes i arestes.
- **Característiques**: Ideal per a dades que tenen relacions complexes, com xarxes socials o recomanacions.
- **Ús**: Anàlisi de xarxes socials, gestió de recomanacions, i aplicacions on les relacions entre les dades són fonamentals.


## Introducció a OLAP, MOLAP i ROLAP

**OLAP** (Online Analytical Processing) és una tecnologia que permet l'anàlisi ràpida i interactiva de dades des de múltiples perspectives o dimensions. Està dissenyada per fer consultes analítiques complexes i proporcionar informació estratègica en temps real o gairebé en temps real. OLAP és àmpliament utilitzada en entorns de **Business Intelligence (BI)**, on les dades històriques s'analitzen per obtenir informació rellevant i prendre decisions informades.

Dins del món d'OLAP, existeixen diferents tipus d'arquitectures segons com s'emmagatzemen i processen les dades:

### MOLAP (Multidimensional OLAP)
- **Descripció**: MOLAP emmagatzema les dades en un format multidimensional, anomenat **cub OLAP**. Aquest cub conté dades precalculades i agregades, permetent respostes extremadament ràpides a les consultes.
- **Característiques**: MOLAP utilitza una estructura de dades altament optimitzada, que facilita una alta velocitat de consulta gràcies a les dades precalculades.
- **Avantatges**: Temps de resposta molt ràpid per a consultes complexes, gràcies a les dades preagregades.
- **Limitacions**: Requereix més espai d’emmagatzematge, ja que totes les agregacions es guarden prèviament. Pot no ser adequat per gestionar grans volums de dades no estructurades.
- **Ús típic**: Anàlisi financera, informes de vendes, aplicacions on el rendiment ràpid és crític.

### ROLAP (Relational OLAP)
- **Descripció**: ROLAP treballa amb bases de dades relacionals tradicionals i utilitza consultes SQL per generar els resultats. A diferència de MOLAP, les dades no es precalculen ni es guarden en cubs; en canvi, s’extreuen en temps real a partir de taules relacionals.
- **Característiques**: Es basa en les bases de dades relacionals (com SQL Server o Oracle) i permet una escalabilitat més gran, ja que pot manejar volums massius de dades.
- **Avantatges**: Capacitat per manejar grans volums de dades sense la limitació d'espai d'emmagatzematge. Es pot treballar amb qualsevol base de dades relacional existent.
- **Limitacions**: Les consultes poden ser més lentes comparades amb MOLAP, especialment si les dades no estan optimitzades adequadament.
- **Ús típic**: Anàlisi de grans volums de dades, especialment quan l'escala i la flexibilitat són més importants que el rendiment de la consulta.

### Diferències clau
- **MOLAP** utilitza cubs multidimensionals per a consultes ràpides i precalculades, mentre que **ROLAP** utilitza bases de dades relacionals i consulta les dades en temps real.
- MOLAP ofereix millor rendiment per a consultes complexes, però amb un cost d’emmagatzematge més elevat. ROLAP és més escalable, però pot ser més lent per a algunes consultes.

En resum, **MOLAP** és ideal per a entorns on el rendiment és crucial, mentre que **ROLAP** és millor per a grans volums de dades i aplicacions que necessiten més flexibilitat i escalabilitat.


## Exemple MOLAP

Cub OLAP de dues dimensions (Producte i Regió)

|                  | **Regió A** | **Regió B** | **Regió C** | **Agregat per Producte** |
|------------------|-------------|-------------|-------------|--------------------------|
| **Producte 1**   | 100         | 150         | 200         | **450**                  |
| **Producte 2**   | 80          | 120         | 90          | **290**                  |
| **Producte 3**   | 50          | 60          | 70          | **180**                  |
| **Agregat per Regió** | **230**     | **330**     | **360**     | **920**                  |

### Explicació:
- **Dimensió Producte**: Conté tres productes (Producte 1, Producte 2, Producte 3).
- **Dimensió Regió**: Conté tres regions (Regió A, Regió B, Regió C).
- Els números de cada cel·la representen una mètrica agregada, com ara el total de vendes o unitats venudes per producte i regió.
- Els **agregats** (en negreta) s'han calculat per cada fila (agregat per producte) i per cada columna (agregat per regió).
- A la intersecció es troba el **total global** (920 en aquest cas), que representa l'agregat total de totes les vendes.

Aquest és un cub OLAP bàsic de dues dimensions, on es poden veure com es realitzen els càlculs agregats en MOLAP per millorar el rendiment en les consultes.


## Eines de visualització de dades

| **Eina**              | **Aplicació**           | **Tipus**      | **Descripció**                                                                  |
|-----------------------|-------------------------|----------------|----------------------------------------------------------------------------------|
| **Tableau**            | Reporting i Dashboard   | Comercial      | Eina de visualització de dades que permet crear informes i dashboards interactius. |
| **Power BI**           | Reporting i Dashboard   | Comercial      | Solució de Microsoft per a reporting i dashboards amb integració amb el seu ecosistema. |
| **Looker**             | Reporting i Dashboard   | Comercial      | Eina de Business Intelligence amb capacitat de reporting i dashboards personalitzables. |
| **Qlik Sense**         | Reporting i Dashboard   | Comercial      | Plataforma de BI que permet crear dashboards interactius i informes ad-hoc.       |
| **Google Data Studio** | Reporting i Dashboard   | Gratuït        | Eina gratuïta de Google per crear informes i dashboards interactius fàcilment.    |
| **JasperReports**      | Reporting               | Open Source    | Eina de codi obert per crear informes a partir de diverses fonts de dades.        |
| **Pentaho**            | Reporting               | Open Source    | Plataforma de BI i reporting de codi obert, amb suport per a grans volums de dades. |
| **BIRT**               | Reporting               | Open Source    | Eina de reporting de codi obert desenvolupada per la Fundació Eclipse.            |
| **Metabase**           | Reporting i Dashboard   | Open Source    | Eina senzilla de codi obert per crear informes i dashboards per a petites empreses. |
| **Redash**             | Reporting i Dashboard   | Open Source    | Eina de codi obert per crear informes i dashboards a partir de consultes SQL.     |
| **Grafana**            | Dashboard               | Open Source    | Eina de codi obert per a visualització de dades en temps real i creació de dashboards. |
| **Kibana**             | Dashboard               | Open Source    | Eina de codi obert per a la creació de dashboards sobre dades d'Elasticsearch.    |
| **Superset**           | Dashboard               | Open Source    | Eina de codi obert per a la creació de dashboards i visualitzacions desenvolupada per Airbnb. |
