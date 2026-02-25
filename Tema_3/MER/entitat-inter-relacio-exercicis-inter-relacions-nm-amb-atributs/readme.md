# Entitat inter-relació - Exercicis inter-relacions N:M amb atributs
## DAW-MP02-UF1 - Exercici de Introducció a les bases de dades
**Exemple univers de discurs**

*"Una **empresa** de manteniment de **piscines** vol una base de dades per tenir un control dels **tractaments** fets. A les piscines se'ls hi assigna un **codi** per poder-les diferenciar ( exemple: la piscina número 13 ) a més emmagatzemem la **població** allà on es troba, l'**adreça**, els **metres cúbics**, el **nom del propietari** i un **telèfon de contacte**. Dels tractaments emmagatzemem la **data i hora** en que es realitza el tractament, el **codi del tècnic** que realitza el tractament ( per exemple: 'DH' ) i una **explicació del tractament efectuat**. Naturalment també volem saber a quina piscina s'ha realitzat aquell tractament. Un mateix tècnic no pot fer dos tractaments a la vegada, per això, podem identificar un tractament respecte un altre amb els valors d'aquests dos atributs. Hi ha piscines que encara no els hem fet cap tractament, però, sempre que fem un tractament cal indicar a quina piscina s'ha fet.*

*A banda, es vol conèixer quins **productes** s'han fet servir a cada tractament. Dels productes ens interessa el **nom comercial**, el principal **component actiu** i el seu **codi de barres**. Aquest darrer atribut, el codi de barres, és el valor que ens permet identificar unívocament cada producte. En un tractament es poden fer servir diferents productes i un mateix producte es pot fer servir en diferents tractaments. Pot ser que en un tractament no fem servir cap producte. Pot ser que hi hagi productes que mai no s'hagin fet servir a cap tractament.*

*A més ens interessa saber exactament quina quantitat de cada producte estem fent servir als tractaments. A això ho anomenarem **dosi**. De la dosi ens interessa les **unitats** en que està expresada ( ex: kilos, miligrams, mililitres, etc ) i la **quantitat** ( ex: 12.5 ). Cada cop que cal administrar una dosi el sistema ens genera un **identificador** que fem servir com AIP.*

**Resolució exemple**

![Exemple inter-relació tipus de correspondència N:M amb atributs](http://i.imgur.com/WNVcAe0.png)

Notes: 
1. No podem posar la **quantitat** de producte utilitzat en **producte** perquè no és una propietat del producte. Tampoc en **tractament** pel mateix motiu. La **quantitat** és un atribut de la inter-relació.
2. Fixem-nos que **Dosi** segueix sent una inter-relació N:M entre tractament i producte. Tanmateix ens veiem obligats a transformar-ho en entitat per poder posar els atributs **quantitat** i **unitats**. Hi a altres tipus de notacions, com per exemple la notació Chen, que permeten posar atributs a les inter-relacions. Això té els seus avantatges i inconvenients que els professor comentarà a classe.
3. El tema de l'**identificador** de la dosi és molt forçat. Però en aquest exercici encara no hem aprés a treballar amb *dependència en identificiació*. Més endavant aprendrem a buscar una solució més natural per aquests tipus de situacions.

**Exercici**

1. Identifica les inter-relacions de l'exemple. Digues de quin tipus de correspondència és cadascuna d'elles. Considera **dosi** com una inter-relació N:M amb atributs entre **tactament** i **producte**.
2. Donat el següent univers de discurs es el Model Conceptual de Dades mitjançant un Diagrama Entitat Inter-Relació. *"Una **empresa** de transports té una flota de **vehícles**. Aquests s'identifiquen per la seva **matrícula**. També emmagatzemem el **model** i l'**any d'aquisició**. A aquests vehícles se'ls fa **revisions** periòdiques. A cada revisió anotem el **quilometratge** del vehícle i l'**estat** de conservació. També anotem les **inicials del tècnic** que fa la reparació i el **moment** en que l'ha fet. Per diferenciar una reparació s'utilitzen aquests darrers camps ( Exemple: la raparació que va fer DH el dia 19 juny 2017 a les 10:15h ). A tots els vehicles se'ls fa revisió, perquè només de comprar-lo ja els fem una revisió. Sempre que es fa una revisió cal indicar quin vehícle es revisa. A banda, es vol saber quines **peces** es canviien a cada revisió, de les peces emmagatzemem la seva **referència** ( que és única per a cada peça), el seu **valor** i la quantitat d'**estoc** que tenim. A totes les revisions canviem, com a mínim, l'aigua del neteja parabrises. Pot ser que tinguem peces en estoc que mai no hem fet servir a cap revisió. Ens interessa saber, per a cada **remplaçament** de peça, la quantitat reemplaçada, per exemple, pel cas del neteja vidres podrien ser 2.5 litres, pel cas d'oli podrien ser 4 litres, pel cas de bugies podrien ser 3 unitats. Per tant, ens interessa, la **quantitat** i les **unitats** ens que venen expressades aquestes quantitats. Cada cop que es fa un **reemplaçament** el sistema ens dona un **ID reemplaçament** que fem servir per identificar-lo."*
3. Et sembla massa teòric el model conceptual de dades? No t'enganyis és una eina extremadament pràctica. Aquí et posaré una petita demostració de la importància de tots aquests coneixements. Segurament hauràs sentit a parlar del framework de desenvolupament web per a Python anomenat Django. Aquest framework treballa amb models, que són la representació de les relacions de la base de dades però al llenguatge de programació. Observa aquesta documentació de django i fes el MCD dels models de l'exemple ( django afegeix a tots els models el camp ID que serveix d'identificador, posa'l al teu MCD )

>[Extra fields on many-to-many relationships](https://docs.djangoproject.com/en/1.9/topics/db/models/#extra-fields-on-many-to-many-relationships)
>
>When you’re only dealing with simple many-to-many relationships such as mixing and matching pizzas and toppings, a standard ManyToManyField is all you need. However, sometimes you may need to associate data with the relationship between two models.
>
>For example, consider the case of an application tracking the musical groups which musicians belong to. There is a many-to-many relationship between a person and the groups of which they are a member, so you could use a ManyToManyField to represent this relationship. However, there is a lot of detail about the membership that you might want to collect, such as the date at which the person joined the group.
>
>For these situations, Django allows you to specify the model that will be used to govern the many-to-many relationship. You can then put extra fields on the intermediate model. The intermediate model is associated with the ManyToManyField using the through argument to point to the model that will act as an intermediary. For our musician example, the code would look something like this:

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

