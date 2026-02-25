# Entitat inter-relació — Exercicis: representació gràfica II
## DAW‑MP02‑UF1 — Exercici: introducció a les bases de dades

Aquestes són les passes que algunes metodologies proposen pel disseny de l'estructura d'una base de dades:

![Del món real a la base de dades](http://i.imgur.com/kWhaeYO.png)

1. Contemplar el **món real**.
2. Redactar l'**univers de discurs**.
3. Fer el **MCD** (model conceptual de dades).
4. Fer el **MLD** (model lògic de dades).
5. Fer el **PDM** (model físic de dades).
6. Escriure les sentències per crear la base de dades.

El MCD és una eina molt poderosa que ens permet fer-nos una idea ràpida de les estructures de dades que conté una base de dades.

Per això, encara que la base de dades ja existeixi, de vegades ens interessa elaborar el diagrama entitat‑relació per comprendre millor el sistema. En aquest exercici cal fer enginyeria inversa: a partir d'unes relacions d'una base de dades, arribar al MCD.

**Exercici**

Observa detingudament aquestes relacions que proposa [S‑Buzz](http://stackoverflow.com/users/501636/s-buzz) a la seva pregunta a StackOverflow: [Correctly join 1:n:1:1 relation in MySQL database](http://stackoverflow.com/questions/38137961/correctly-join-1n11-relation-in-mysql-database/38138213#38138213).

![Sistema de lloguers](http://i.imgur.com/F0fs50T.png)

1. Digues tots els objectes que ha llogat John Doe i si ja els ha tornat.
2. Construeix el PDM (necessitaràs haver fet abans l'exercici sobre representació gràfica).
3. Construeix el MCD.
4. Comprova que al MCD no has inclòs cap atribut que sigui forani a les entitats. Per exemple, a l'entitat `rental` no ha d'aparèixer l'atribut `person_person_id` (sí que ha d'aparèixer la relació a `person`).
5. L'entitat `rental2object` és, en realitat, una interrelació (sense atributs) amb tipus de correspondència N:M entre `rental` i `object`. Tant si has creat l'entitat que representa la interrelació com si només has representat la interrelació N:M, és correcte. Si has creat l'entitat, recorda incloure les dependències d'identificació.
6. Escriu l'univers de discurs a partir del MCD.
