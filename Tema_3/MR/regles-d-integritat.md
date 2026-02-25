## Regles d'integritat

**Integritat d'entitat** és el mecanisme que governa el comportament de la clau primària. Bàsicament ens diu que els atributs que formen la clau primària no poden prendre valors nulls i que han de ser un conjunt d'atributs mínims per a identificar la tupla.

**Integritat relacional (o integritat referencial)**. Quan una taula inclou una clau forana cal garantir l'accés i coherència a la tupla referenciada. D'això s'encarrega el sistema d'integritat referencial. Bàsicament es traca d'evitar referències impossibles i de gestionar el comportament de la base de dades quan canvien o s'esborren els valors de la taula referenciada. En aquest cas tenim varies opcions:

* Posar la clau forana a null ( nullificació )
* No permetre que es canvii la clau primària o que s'esborri la tupla referenciada ( restricció )
* En cas d'eliminar la tupla relacionada esborrar també la tupla que referencia ( on delete cascade ) 
* Propogació dels canvis que es realitzin sobre els valors de la clau primaria ( on update cascade )
* Posar un valor per defecte ( set default )

**Exercici**

Observa la creació d'aquestes tres taules relacionals en postgresql:



```sql
CREATE TABLE products (
    product_no integer PRIMARY KEY,
    name text,
    price numeric
);

CREATE TABLE orders (
    order_id integer PRIMARY KEY,
    shipping_address text,
    ...
);

CREATE TABLE order_items (
    product_no integer 
       REFERENCES products ON DELETE RESTRICT,
    order_id integer 
       REFERENCES orders ON DELETE CASCADE,
    quantity integer,
    PRIMARY KEY (product_no, order_id)
);
```

Quines dues restriccions s'estan aplicant a la taula de comandes? Què passarà quan s'intenti esborrar un producte que apareix en una línia de comanda? Que passarà quan s'intenti esborrar una comanda que té línies de comanda? Poden haver dues línies de comanda del mateix producte en una mateixa comanda? Per què?


**Exercici**

La web http://sqlfiddle.com/ permet crear taules i insertar-hi dades via web per a fer petites proves sobre diferents sistemes gestors de base de dades comercials.
Després de crear la taula alumnes intentem insertar dos alumnes amb el mateix DNI. Comprova el que passa. Intenta reproduir-ho.

![Duplicate key](http://i.imgur.com/kMJIFXj.png)