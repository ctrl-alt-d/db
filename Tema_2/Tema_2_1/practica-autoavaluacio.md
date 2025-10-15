# Pràctica autoavaluació

Observa aquestes taules:

* genres(id pk, name)
* tvshow_genres(genre_id pk fk1, tvshow_code pk fk2)
* tvshows(code pk, name)
* episodes(tvshow_code pk fk1 ak1, season pk, number pk, title ak1)
* users(id pk, username ak1, email ak1)
* ratings(user_id pk fk1, tvshow_code fk2, season fk2, number fk2, starts)

Diccionari de dades:

* `genre`: Gènere d'una sèrie, exemple: `drama`, `comèdia`, `thriller`, `ciència-ficció`, etc.
* `tvshow`: Sèrie de televisió. Cada sèrie té un codi únic i un nom.
* `tvshow_genre`: Relació molts a molts entre sèries i gèneres. Una sèrie pot tenir diversos gèneres i un gènere pot estar associat a diverses sèries.
* `episode`: Capítol o episodi d'una sèrie. S'identifica per la sèrie, la temporada i el número de capítol. Té un títol que és clau alternativa juntament amb el codi de la sèrie.
* `user`: Usuari de la plataforma. Té un identificador únic, un nom d'usuari i un correu electrònic (ambdós són claus alternatives).
* `rating`: Valoració que un usuari fa d'un episodi o sèrie. 

Fes el diagrama Physical Data Model a la teva llibreta. Mira d'entendre per a què serveix aquesta base de dades. Mira d'entendre també quina informació podem emmagatzemar. Respon a tu mateiux a aquestes preguntes:
* Pot una sèrie tenir més d'un `genre` ?
* Pot un `usuari` valorar dos cops el mateix `episodi`?
* Perquè `tvshow_code` més `title` formen una AK a `episodis` ?

## Exercicis

* Pensa quin comportament és el més adient per a cada clau forana:

| clau | on update | on delete |
|--|--|--|
| tvshow_genres a genres | | |
| tvshow_genres a tvshows | | |
| episodes a tvshows | | |
| ratings a users | | |
| ratings a episodes | | |


* Crea les taules.
* Insereix les següents dades:
   * **Gèneres**: Drama, Comèdia, Ciència-ficció, Thriller
   * **Sèries**:
     * `BREAK` - Breaking Bad
     * `STRANGE` - Stranger Things
     * `OFFICE` - The Office
   * **Relació sèries-gèneres**:
     * Breaking Bad: Drama, Thriller
     * Stranger Things: Ciència-ficció, Drama, Thriller
     * The Office: Comèdia
   * **Episodis**:
     * Breaking Bad - T01E01: "Pilot"
     * Breaking Bad - T01E02: "Cat's in the Bag..."
     * Stranger Things - T01E01: "Chapter One: The Vanishing of Will Byers"
     * The Office - T01E01: "Pilot"
   * **Usuaris**:
     * joan@example.com (username: joan_tv)
     * maria@example.com (username: maria_series)
     * pere@example.com (username: pere_fan)
   * **Valoracions**:
     * joan_tv valora Breaking Bad T01E01 amb 5 estrelles
     * maria_series valora Stranger Things T01E01 amb 4 estrelles
     * pere_fan valora The Office T01E01 amb 5 estrelles

* Comprova el comportament de les claus foranes actualitzant o esborrant dades.
* Crea a taula `països` amb els camps `iso2` pk i `nom` AK1.
* Inserta dos països.
* Afegeix un camp `nacionalitat` a usuaris, pot contenir valors nulls, l'has de convertir a clau forana cap a `països`.
* Assigna una nacionalitat a `joan_tv`
* Elimina la restricció d'unicitat d'episodis.
* Esborra les restriccions d'integritat referencial de totes les taules.
* Trunca totes es dades de totes les taules.
* Esborra totes les taules.