# Introducció a les Bases de Dades Distribuïdes

Les **bases de dades distribuïdes** són sistemes de bases de dades on les dades no es guarden en un sol lloc, sinó que estan distribuïdes entre múltiples ubicacions físiques o lògiques. Aquestes bases poden estar distribuïdes en diferents servidors dins d’un mateix centre de dades o fins i tot en diferents localitzacions geogràfiques. El principal objectiu de les bases de dades distribuïdes és millorar la disponibilitat, la fiabilitat i l’escalabilitat del sistema.

## Node

En el context de les bases de dades distribuïdes, un **node** és qualsevol dispositiu o servidor que forma part del sistema distribuït i que emmagatzema una part o la totalitat de la base de dades. Cada node és un component independent que pot contenir dades, processar consultes i comunicar-se amb altres nodes per garantir la coherència i la disponibilitat de les dades.

Els nodes són essencials en una arquitectura distribuïda, ja que permeten que les dades es divideixin o es repliquin entre diferents màquines, oferint redundància i escabilitat al sistema.

## Replicació

La **replicació** és el procés de copiar i mantenir dades idèntiques en múltiples nodes dins d'una base de dades distribuïda. El principal objectiu de la replicació és augmentar la disponibilitat, la tolerància a fallades i millorar el rendiment del sistema.

### Tipus de replicació

1. **Replicació sincrònica**: En aquest tipus de replicació, quan una dada es modifica en un node, aquesta modificació s'ha de replicar immediatament a tots els nodes abans de confirmar l'operació. Això garanteix la consistència de les dades, però pot afegir latència, ja que els nodes han de sincronitzar-se abans de completar una transacció.

2. **Replicació asincrònica**: En aquest cas, un cop la dada s'ha modificat en un node, es replica als altres nodes després d'un cert temps, però l'operació es confirma abans que la replicació sigui completa. Això permet un millor rendiment i temps de resposta, però pot generar inconsistències temporals entre els nodes.

### Avantatges de la replicació

- **Alta disponibilitat**: Si un node falla, altres nodes poden continuar oferint accés a les dades.
- **Tolerància a fallades**: Les dades replicades garanteixen que no es perdin dades en cas de fallada d'un node.
- **Millora del rendiment**: Els usuaris poden accedir a les dades des del node més proper geogràficament o amb menys càrrega, reduint la latència.

## Particionament de dades

Quan es distribueixen les dades entre diferents servidors o ubicacions, es poden seguir diverses estratègies per particionar-les. Les dues més comunes són el **particionament horitzontal** i el **particionament vertical**.

### Particionament horitzontal

El **particionament horitzontal** (també conegut com *sharding*) consisteix a dividir les files de la taula en diferents nodes o servidors. Cada partició conté un subconjunt de les files de la taula completa. Això és especialment útil quan les taules tenen un gran volum de registres, ja que distribueix la càrrega de processament i emmagatzematge entre diferents servidors.

Per exemple, si tenim una taula amb milions de clients, podem particionar-la horitzontalment distribuint els clients amb un ID parell a un servidor i els clients amb un ID imparell a un altre.

### Particionament vertical

El **particionament vertical** divideix les columnes de la taula entre diferents nodes o servidors. Cada partició conté un subconjunt de les columnes de la taula completa, però totes les files. Això pot ser útil per separar dades sovint accedides conjuntament i optimitzar el rendiment.

Per exemple, en una taula de clients, podem separar les dades d'informació personal (nom, correu electrònic) en un servidor i les dades financeres (comptes, factures) en un altre.

### Diferències clau

- **Particionament horitzontal**: divideix les dades per files, ideal per a escalar en amplada quan hi ha un volum massiu de registres.
- **Particionament vertical**: divideix les dades per columnes, optimitzant l’accés quan diferents tipus de dades tenen diferents requisits de rendiment o seguretat.




**Exercicis**

1. Familiaritza't amb els nous conceptes esmentats.
2. Fes un diagrama que representi diferents màquines connectades via xarxa, en diferents edificis o llocs del planeta, i que totes juntes formin un DDBMS.


