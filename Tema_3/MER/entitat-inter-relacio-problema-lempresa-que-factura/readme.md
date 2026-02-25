# Entitat inter-relació - Problema: L'Empresa que Factura
## DAW-MP02-UF1 - Exercici de Introducció a les bases de dades
**Introducció**

És un MCD senzill on apareixen unes vuit entitats tipus més dues entitats subtipus. És interessant perquè s'estudia la interrelació N:M Producte-Factura molt didàctica i alhora present en molts sistemes informàtics.

En aquest exercici s'introdueix el concepte de classes tipus i subtipus. També anomenat herència ( 'inheritance' ). Aquest recurs es fa servir quan una entitat presenta diferents atributs segons la instància de la realitat que estigui representant. Per exemple, una instància de vehícle no tindrà atribut 'capacitat en lítres del diposit' o 'número de cilindres del motor' quan es tracti d'un vehícle de propulsió electrica. La representació seria la següent:

![Entity inheritance](http://i.imgur.com/fbyklLH.png)

**Univers de Discurs**

Una **empresa** fabrica diferents tipus de **productes** que ven als seus **clients**. 

Cada producte té un **codi**, **nom comercial** (que podriem fer servir per identificar-los si no fos que els identifiquem pel codi), el **preu unitari actual**, en que venen **expressades les unitats** (per exemple una unitat de producte podrien ser 33cc ), si **necessita refrigeració** i si és un producte que **pot malmetre el medi ambient**.

Els clients els tenim **codificats**, també emmagatzem el **nom** (que podriem fer servir per identificar-los si no fos que els identifiquem pel codi ), el **Nom Comercial** si en té, la **Població**, **Adreça**, **CIF** i **telèfon de contacte**.

Una **factura** pot tenir una descripció que s'encarrega d'omplir el treballador que **gestiona** aquella factura. No totes les factures tenen descripció, però si totes tenen un gestor. Les factures tenen una numeració formada per tres camps, **exercici de facturació** (ex: 2017), **sèrie de facturació** (Exemple: sèrie B), **Número de factura** (Exemple complet per identificar factura seria: la factura número 4, de la sèrie B de l'any 2017). 

En una mateixa factura es facturen diversos productes que s'han servit. De manera que una facture té diversos productes (com a mínim un) i un producte apareix a diferents factures. De cada producte facturat cal emmagatzemar la **quantitat facturada** ( ex: 200 unitats) i el **preu** de que el **gestor** de factures va tancar amb el client per aquella venda ( pot ser diferent del preu de referència actual de cda producte). No poden haver dues línies de factura amb idèntic producte per en una mateixa factura ( el que fariem és fusionar-les en una sola línia).

Són els treballadors els que gestionen les factures. Cada factura és gestionada sempre per un únic treballador. Els **treballadors** els identifiquem pel **NSS**, també emmagatzemem el **DNI**, el **nom i cognoms** i la **data d'incorporació a l'empresa**.

Els treballadors disposen de **contracte**. Cada contracte té un **número de contracte** que ens dona la seguretat social, també una **data** de contracte, l'**import brut anual** pactat amb el treballador i un text amb **clàusules adicionals**.

Els treballadors perceben **nòmines**. Cada nòmina és per un **període de temps** ( exemple: de l'1 de juny al 30). Les nòmines s'identifiquen pel contracte al que pertanyen i la data de inici del període liquidat.

La nòmina té **línies de nòmina**, la línia 1, la 2, ... .Cada línia pot ser un **ingrés** o una **retenció**. Els ingressos i les retencions són una especialització de la línia. Dels ingressos ens interessa el **Concepte d'Ingrès** i l'**Import**. De les retencions l'**import retingut**, el **concepte** i saber si **és a càrrec del treballador** o de l'empresa.

**Exercici**

* A partir de l'Univers de Discurs fel el Model Conceptual de dades mitjançant el diagrama ER.


