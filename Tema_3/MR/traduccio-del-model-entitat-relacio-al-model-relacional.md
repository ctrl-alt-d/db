# Pas del MCD al MLD

En aquest apartat aprendrem a traduir un model entitat inter-relació a un model relacional. Treballarem encara amb el MLD (Model Lògic de les Dades) i no amb SQL, a la propera AEA veurem com traduir aquest model lògic a un model físic, és a dir, a SQL.

* Dominis: Normalment no es declaren dominis, es treballa amb els tipus pre establerts que cada fabricant proporciona ( INT, VARCHAR, etc ).
* Entitat: Cada entitat es converteix a una relació i, en el cas de base de dades, en una taula.
* Atributs: Cada atribut del model entitat inter-relació serà un atribut del model relacional, a les bases de dades es correpon amb una columna.
* AIP: Serà una clau primària.
* AIC: Serà una restricció de tipus UNIQUE.

Anem a fer un exemple fins aquí, suposem l'entitat:

![Exemple entitat](http://i.imgur.com/HDAqNll.png)

El MLD seria:

** TODO **


Ara la traducció de les inter-relacions. Per traduir una inter-relació del model entitat inter-relació a model relacional el que fem, en aquest darrer, és una **propagació de claus**. És a dir, els atributs que formen la clau primària a la taula referenciada es copien, en forma de clau forana, a la taula que referencia. Exemple:

![Exemple](http://i.imgur.com/c7UKEXP.png)

La taula referenciada és piscina i la taula que referencia és tractament. El MLD resultant seria:


** TODO **


**Quan una entitat és dèbil, té dependència en identificació, la clau forana formarà part de la clau primària**

Exercicis:

Pasa a model relacional en notació SQL els següents models entitat inter-relació:

1) 1:N
   
![](http://i.imgur.com/i8KhNy0.png)

2) N:M amb dependència amb identificació 

![](http://i.imgur.com/MpUoGWy.png)

3) N:M amb dependència amb identificació + un atribut de l'entitat que forma part de l'AIP

![](http://i.imgur.com/kSyiPqw.png)

4) Doble interrelació entre entitats

![](http://i.imgur.com/Ik0JnYQ.png)
