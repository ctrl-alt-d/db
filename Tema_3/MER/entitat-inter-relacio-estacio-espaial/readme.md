

## [L’estació espacial - estructura i passatgers. By Joan Queralt](https://gitlab.com/joanq/DAM-M2-BasesDeDades/-/blob/master/UF1/2-model_ER/activitats/estacio_espacial_estructura.adoc)

Com a tècnic informàtic de la recent construïda estació espacial Nexus, has rebut l'encàrrec de dissenyar una base de dades per part de l'Alt Comandament per emmagatzemar informació sobre l'estructura de l'estació i els passatgers que la visiten.

Els requeriments que t'han fet arribar són els següents:

- La nostra estació espacial està dividida en diferents seccions, que reben el nom d'un color, per exemple, secció verda, secció blava, etc. Volem guardar l'àrea de cada secció (en quilòmetres quadrats) i una descripció.

- Cada secció està subdividida en diversos segments numerats, cosa que ens permet referir-nos a un segment determinat com, per exemple, BLAU-123. De cada segment, volem saber-ne, a més de la secció a la qual pertany, l'àrea i la posició dins de l'estació (com que l'estació té forma de tor, una posició la podem guardar com la distància al centre, l'angle d'inclinació i l'angle de rotació).

- Totes les sales de l'estació ocupen com a mínim un segment, però les sales grans en poden ocupar més d'un. Per exemple, un restaurant podria ocupar els segments BLAU-123 a BLAU-128.

- Cada sala té un codi únic que la identifica, i volem saber a quin propòsit específic es destina, per exemple, habitacle, magatzem o restaurant. També ha de ser possible guardar-ne una descripció. Cada sala té com a mínim una porta que la uneix a altres sales.

- La nostra estació allotja visitants de diverses espècies alienígenes. Necessitem saber en quina sala està allotjat cada passatger. A més, per cada sala hem de saber per a quines espècies és apta l'atmosfera que hi ha creada al seu interior.

- Dels visitants en guardem el seu nom, edat, gènere (si és aplicable) i espècie, un codi d'identificació únic que s'assigna el primer cop que un passatger arriba a l'estació, i la seva data d'arribada i sortida de l'estació. Cal tenir en compte que un mateix visitant pot fer diverses visites al llarg del temps, i que en volem tenir un registre.

- Disposem de diferents credencials de seguretat que permeten obrir les portes que separen les sales. Un visitant amb una certa credencial de seguretat pot obrir qualsevol porta que estigui marcada amb aquesta credencial. Una porta pot estar marcada amb més d'una credencial o amb cap, la qual cosa indica que tothom la pot obrir. Un passatger pot tenir diverses credencials (o cap).

Amb aquestes dades, dissenya un diagrama ER adequat. Atenció! No volem que cap passatger s'ofegui per un error de disseny en la base de dades!
