# Tipus de bases de dades

Les bases de dades són sistemes essencials per a l'emmagatzematge i la gestió d'informació en múltiples aplicacions. Existeixen diversos tipus de bases de dades, cadascuna amb característiques pròpies que les fan adequades per a diferents casos d'ús.

## Bases de dades relacionals
Les bases de dades relacionals (RDBMS) emmagatzemen la informació en taules estructurades amb files i columnes. Utilitzen el llenguatge SQL (Structured Query Language) per gestionar i consultar les dades. La relació entre les taules s'estableix mitjançant claus primàries i foranes. Exemples populars de bases de dades relacionals són MySQL, PostgreSQL i Oracle. Les RDBMS són molt eficients per gestionar dades estructurades amb relacions complexes.


| ID  | Nom        | Cognom     | Correu Electrònic      | Edat |
| --- | ---------- | ---------- | ---------------------- | ---- |
| 1   | Maria      | Puig       | maria.puig@example.com  | 25   |
| 2   | Joan       | Ferrer     | joan.ferrer@example.com | 30   |
| 3   | Marta      | Roca       | marta.roca@example.com  | 22   |
| 4   | Pere       | Sastre     | pere.sastre@example.com | 28   |
| 5   | Laia       | Soler      | laia.soler@example.com  | 35   |


## Bases de dades NoSQL
Les bases de dades NoSQL es dissenyen per gestionar grans volums de dades no estructurades o semi-estructurades. No segueixen l'esquema de taules de les bases de dades relacionals, sinó que poden utilitzar diferents models d'emmagatzematge, com documents, grafos, clau-valor o columnes.

* MongoDB és una base de dades basada en documents, on les dades s'emmagatzemen en format JSON (o BSON). És adequada per a dades no estructurades i aplicacions que requereixen gran flexibilitat i escalabilitat.

* Cassandra és una base de dades distribuïda basada en columnes àmplies, dissenyada per gestionar grans volums de dades de manera distribuïda i amb alta disponibilitat. És ideal per a sistemes que requereixen tolerància a fallades i replicació automàtica.

```json
{
  "_id": 1,
  "nom": "Maria",
  "cognom": "Puig",
  "contacte": {
    "correu_electronic": "maria.puig@example.com",
    "telefon": "123456789"
  },
  "edat": 25
},
{
  "_id": 2,
  "nom": "Joan",
  "cognom": "Ferrer",
  "correu_electronic": "joan.ferrer@example.com",
  "direccio": {
    "carrer": "Carrer Major, 15",
    "ciutat": "Barcelona"
  }
},
{
  "_id": 3,
  "nom": "Marta",
  "cognom": "Roca",
  "edat": 22,
  "hobbies": ["escalada", "fotografia"]
}
```

## Comparació
Les bases de dades relacionals són molt útils quan es necessiten transaccions complexes, integritat de dades i relacions entre diferents entitats. D'altra banda, les bases de dades NoSQL són més eficients en aplicacions que requereixen escalabilitat horitzontal, flexibilitat en l'estructura de les dades i un rendiment alt amb grans quantitats de dades.

Cadascun d'aquests models té avantatges segons el tipus d'aplicació, necessitats de rendiment i la quantitat de dades que cal gestionar.

| Característica                    | Base de datos relacional          | Base de datos NoSQL                |
| ---------------------------------- | --------------------------------- | ---------------------------------- |
| Modelo de datos                    | Tablas con filas y columnas       | Documentos, claves-valor, grafos o columnas |
| Esquema                            | Fijo y predefinido                | Flexible y dinámico                |
| Relaciones entre datos             | Relaciones definidas mediante claves foráneas | Sin relaciones estrictas, con enlaces embebidos o referencias |
| Escalabilidad                      | Escalado vertical (mejora del hardware) | Escalado horizontal (distribución entre servidores) |
| Lenguaje de consulta               | SQL (Structured Query Language)   | Varios: consultas específicas para cada tipo (MongoDB Query Language, CQL, etc.) |
| Consistencia                       | Alta consistencia (ACID)          | Eventual consistencia (BASE), depende del tipo de NoSQL |
| Idoneidad para                     | Aplicaciones transaccionales, sistemas financieros | Aplicaciones con grandes volúmenes de datos, big data, redes sociales |
| Ejemplos                           | MySQL, PostgreSQL, Oracle, SQLServer         | MongoDB, Cassandra, Redis, Neo4j   |
| Manejo de grandes volúmenes de datos| Menos eficiente                  | Más eficiente, especialmente en lectura |
| Flexibilidad de datos              | Rígido, cambios en el esquema requieren migraciones | Alta flexibilidad, adaptado a datos semiestructurados |


# Exercicis

1. StackOverflow és una web de referència al món del desenvolupament de programari. Consulta quantes preguntes hi ha en total a la web stackoverflow.com. 
2. Consulta la defininció que trobem a StackOverflow per els següents Tags, comprova també quantes consultes hi ha per cadascun d'ells: Oracle, SQL-Server, MYSQL, postgresql, MongoDB, Cassandra, ms-access, sqlite. Per cadascun d'ells busca altres tags relacionats.
2. Cadascú d'aquests tags són bases de dades, quines són relacionals i quines són NoSQL.
4. Existeixen definicions molt més formals del que és un SGBD del que hi ha en aquesta documentació. Busca alguna d'aquestes definicions en anglès i tradueix-la al teu idioma. Busca per 'Database Management System'.
5. El sistema gestor de base de dades pot ser un procés que s'executa a la màquina ( ex: Oracle, SQL Server, MYSQL ) o bé poden ser unes llibreries, unes dll en el cas Windows ( ex: Access, sqlite ). Observa aquestes captures del gestor de tasques i digues a quin SGBD creus que es corresponen.

![Oracle](http://i.imgur.com/CbtJX2J.png)

![SQL Server](http://i.imgur.com/xGf5SUi.png)
