# Concepte i ús dels sistemes gestors de bases de dades

## Exercici de Introducció a les bases de dades

Una **base de dades** és un conjunt endreçat d'informació que s'emmagatzema mitjançant algun tipus de suport i que es pot consultar i mantenir. Ex: recull de temperatures, padró d'habitants.

Un **sistema gestor de base de dades** és un programari `(*1)` especialitzat en la custòdia i manegament de dades `(*2)` tot oferint un mínim de prestacions `(*3)`.

* `(*1)` Pot ser una aplicació o unes llibreries. En cas de ser aplicació caldrà disposar d'un sistema de comunicació de processos per tal de poder-nos connectar. Existeixen diferents sistemes de comunicació: per pipes, per xarxa, per memòria compartida. En cas de ser llibreries caldrà enllaçar-les al nostre programa, ja sigui de manera estàtica en temps de compilació del programa o bé de manera dinàmica durant l'execució del mateix.

* `(*2)` Les aplicacions no accedeixen directament a les dades, li demanen al SGBD ( sistema gestor de base de dades) les operacions que volen realitzat. Exemple d'operacions poden ser modificació de dades o consulta de dades existents. El SGBD és qui realitza aquestes operacions mantenint la integritat de les dades i aplicant la seguretat que estigui definida al sistema.

* `(*3)` Per tal que un programari pugui considerar-se SGBD ha de ser capaç de facilitar una sèrie d'operacions mínimes des de diferents vesants, una de les capacitats més importants que ha de tenir és la independència de les dades respecte les aplicacions ( podem seguir accedint a les dades mitjançant les utilitats del SGBD sense necessitat d'altres aplicacions, podem canviar l'estructura de les dades des del propi SGBD). Altres capacitats poden ser facilitar l'accés a les dades i mantenir la seguretat i integritat de les mateixes.

![SGBD](http://i.imgur.com/qFuNOo6.png)