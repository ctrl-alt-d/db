# Entitat inter-relació - Exercicis interrelacions N:M amb atributs
## DAW‑MP02‑UF1 — Exercici: introducció

**Exemple: univers de discurs**

"Una **empresa** de manteniment de **piscines** vol una base de dades per controlar els **tractaments**. A cada piscina se li assigna un **codi** per diferenciar‑la (per exemple: piscina número 13). També emmagatzemem la **població** on es troba, l'**adreça**, els **metres cúbics**, el **nom del propietari** i un **telèfon de contacte**. Dels tractaments guardem la **data i l'hora** en què es realitza el tractament, el **codi del tècnic** que el realitza (per exemple: 'DH') i una **descripció del tractament**. Naturalment volem saber a quina piscina s'ha realitzat cada tractament. Un mateix tècnic no pot fer dos tractaments al mateix temps; per això podem identificar un tractament respecte a un altre pels valors d'aquests atributs. Hi ha piscines a les quals encara no hem fet cap tractament; però sempre que fem un tractament cal indicar a quina piscina s'ha fet."

"A més, es vol conèixer quins **productes** s'han utilitzat a cada tractament. Dels productes ens interessa el **nom comercial**, el **component actiu principal** i el seu **codi de barres** (atribut que identifica unívocament cada producte). En un tractament es poden utilitzar diferents productes i un mateix producte es pot utilitzar en diferents tractaments. Pot ser que en un tractament no s'utilitzi cap producte; també pot haver-hi productes que mai no s'hagin fet servir en cap tractament."

"Ens interessa, a més, saber la **quantitat** de cada producte utilitzat en cada tractament. Això ho anomenarem **Dosi**: té atributs com **unitats** (ex.: kg, mg, ml) i **quantitat** (ex.: 12.5). Cada cop que s'administra una dosi, el sistema pot generar un **identificador** que utilitzarem com AIP de la dosi."


<details>
<summary>Fes clic per veure les solucions</summary>

![Exemple interrelació N:M amb atributs](http://i.imgur.com/WNVcAe0.png)

</details>

Notes

1. No podem posar la **quantitat** de producte utilitzat dins de l'entitat **Producte**, perquè no és una propietat pròpia del producte, ni dins **Tractament** pel mateix motiu: la quantitat depèn de la combinació tractament–producte. Per això la **quantitat** és un atribut de la interrelació.
2. En el model conceptual, la interrelació N:M amb atributs s'acostuma a transformar en una entitat intermèdia (per exemple, `Dosi`) que conté els atributs **quantitat** i **unitats** i que enllaça `Tractament` i `Producte`.
3. L'ús d'un identificador propi per a `Dosi` és una decisió de modelització; més endavant veurem alternatives basades en dependències d'identificació.

**Exercicis**

1. Identifica les interrelacions de l'exemple i classifica‑les segons el seu tipus de correspondència. Considera `Dosi` com la interrelació N:M amb atributs entre `Tractament` i `Producte`.
2. Donat el següent univers de discurs, fes el Model Conceptual de Dades mitjançant un Diagrama Entitat‑Relació:

   "Una **empresa** de transports té una flota de **vehicles**. Aquests s'identifiquen per la seva **matrícula**. També emmagatzemem el **model** i l'**any d'adquisició**. Aquests vehicles reben **revisions** periòdiques. A cada revisió anotem el **quilometratge** del vehicle i l'**estat** de conservació. També anotem les **inicials del tècnic** que fa la reparació i el **moment** en què l'ha fet. Per diferenciar una reparació s'utilitzen aquests camps (per exemple: la reparació que va fer DH el 19 de juny de 2017 a les 10:15 h). A tots els vehicles se'ls fa revisió; per tant, sempre que es fa una revisió cal indicar quin vehicle es revisa. A banda, es vol saber quines **peces** es canvien a cada revisió; de cada peça emmagatzemem la seva **referència** (que és única), el seu **valor** i la quantitat d'**estoc** que tenim. A totes les revisions es pot canviar, com a mínim, l'aigua del neteja del parabrises. Pot ser que tinguem peces en estoc que mai no s'hagin fet servir a cap revisió. Ens interessa saber, per a cada **remplaçament** de peça, la quantitat reemplaçada (per exemple: 2.5 litres d'aigua del neteja del parabrises; 4 litres d'oli; 3 unitats de bugies). Per tant, ens interessa la **quantitat** i les **unitats** en què s'expressen aquestes quantitats. Cada cop que es fa un **remplaçament** el sistema pot generar un **ID_rempl** que fem servir per identificar‑lo."

3. Et sembla massa teòric el model conceptual de dades? No t'enganyis: és una eina pràctica. Per exemple, el framework Django treballa amb models que representen taules i relacions. Observa aquesta documentació de Django i fes el MCD dels models de l'exemple (Django afegeix un camp `id` a cada model que pot servir d'identificador; posa'l al teu MCD).

Referència: [Extra fields on many-to-many relationships](https://docs.djangoproject.com/en/1.9/topics/db/models/#extra-fields-on-many-to-many-relationships)

Exemple (Django):

```python
class Person(models.Model):
    name = models.CharField(max_length=128)

class Group(models.Model):
    name = models.CharField(max_length=128)
    members = models.ManyToManyField(Person, through='Membership')

class Membership(models.Model):
    person = models.ForeignKey(Person, on_delete=models.CASCADE)
    group = models.ForeignKey(Group, on_delete=models.CASCADE)
    date_joined = models.DateField()
    invite_reason = models.CharField(max_length=64)
```
