# Conceptes d'àlgebra relacional (selecció, projecció)

## Introducció

L'àlgebra relacional és un conjunt d'operacions matemàtiques que s'apliquen sobre relacions (taules) per obtenir noves relacions. És la base teòrica del model relacional i de SQL.

Les operacions d'àlgebra relacional són procedimentals: descriuen com obtenir el resultat, no només què volem obtenir.

En aquesta primera part estudiarem les dues operacions més fonamentals: la **selecció** i la **projecció**.

## Operacions bàsiques unàries

### 1. Selecció (σ - sigma)

La **selecció** filtra les files d'una relació segons una condició. És una operació **unària** (s'aplica sobre una sola relació).

**Notació:** σ<sub>condició</sub>(Relació)

**Exemple:**
- σ<sub>edat > 18</sub>(Clients) → Selecciona els clients amb edat superior a 18 anys

**Equivalent SQL:**
```sql
SELECT * FROM Clients WHERE edat > 18;
```

**Característiques:**
- Manté el mateix nombre de columnes
- Pot reduir el nombre de files
- La condició pot ser simple o composta (amb AND, OR, NOT)

**Exemples addicionals:**
- σ<sub>ciutat='Barcelona'</sub>(Clients) → Clients de Barcelona
- σ<sub>preu > 100 AND stock > 0</sub>(Productes) → Productes cars amb stock
- σ<sub>categoria='Electrònica' OR categoria='Informàtica'</sub>(Productes)

### 2. Projecció (π - pi)

La **projecció** selecciona columnes específiques d'una relació, eliminant les duplicades. També és una operació **unària**.

**Notació:** π<sub>atributs</sub>(Relació)

**Exemple:**
- π<sub>nom, cognom</sub>(Clients) → Obté només els noms i cognoms dels clients

**Equivalent SQL:**
```sql
SELECT DISTINCT nom, cognom FROM Clients;
```

**Característiques:**
- Pot reduir el nombre de columnes
- Elimina automàticament files duplicades
- L'ordre dels atributs especificats determina l'ordre de les columnes resultants

**Exemples addicionals:**
- π<sub>nom</sub>(Productes) → Només els noms dels productes
- π<sub>email</sub>(Clients) → Llista d'emails únics
- π<sub>categoria, marca</sub>(Productes) → Combinacions úniques de categoria i marca

## Composició d'operacions

Les operacions de selecció i projecció es poden combinar per crear consultes més complexes:

**Exemple 1:**
π<sub>nom</sub>(σ<sub>edat > 18</sub>(Clients))

Això significa:
1. Primer seleccionem els clients amb edat > 18
2. Després projectem només el nom

**Equivalent SQL:**
```sql
SELECT DISTINCT nom 
FROM Clients 
WHERE edat > 18;
```

**Exemple 2:**
π<sub>nom, preu</sub>(σ<sub>categoria='Portàtils' AND preu < 1000</sub>(Productes))

**Equivalent SQL:**
```sql
SELECT DISTINCT nom, preu
FROM Productes
WHERE categoria = 'Portàtils' AND preu < 1000;
```

## Propietats importants

### Commutativitat de la selecció
σ<sub>c1</sub>(σ<sub>c2</sub>(R)) = σ<sub>c2</sub>(σ<sub>c1</sub>(R))

Podem aplicar múltiples seleccions en qualsevol ordre.

### Cascada de seleccions
σ<sub>c1</sub>(σ<sub>c2</sub>(R)) = σ<sub>c1 AND c2</sub>(R)

Múltiples seleccions consecutives es poden combinar en una sola.

### Cascada de projeccions
π<sub>a1</sub>(π<sub>a1,a2</sub>(R)) = π<sub>a1</sub>(R)

Si projectem un subconjunt d'atributs després d'una projecció més àmplia, només la darrera té efecte.

### Combinació selecció-projecció
π<sub>a1,a2</sub>(σ<sub>c</sub>(R))

Primer filtrem files, després seleccionem columnes. Aquesta és una de les combinacions més comunes.

## Optimització de consultes

Els gestors de bases de dades utilitzen aquestes propietats per optimitzar les consultes:

1. **Aplicar seleccions el més aviat possible** per reduir el nombre de files a processar
2. **Aplicar projeccions aviat** per reduir el nombre de columnes
3. **Combinar seleccions** per evitar múltiples passos de filtrat

## Exercicis pràctics

1. Tradueix a SQL:
   - π<sub>nom, email</sub>(σ<sub>ciutat='Barcelona'</sub>(Clients))

2. Escriu en àlgebra relacional: "Troba els noms dels productes amb preu superior a 100€"

3. Explica la diferència entre:
   - σ<sub>preu > 100</sub>(π<sub>nom, preu</sub>(Productes))
   - π<sub>nom</sub>(σ<sub>preu > 100</sub>(Productes))

4. Per què la projecció elimina duplicats automàticament?

## Resum

En aquesta sessió hem après:
- La **selecció** (σ) filtra files segons una condició
- La **projecció** (π) selecciona columnes específiques
- Aquestes operacions es poden **composar** per crear consultes complexes
- Les propietats matemàtiques permeten **optimitzar** les consultes

---

[Següent: Select senzilla](./02_intro_select.md) | [Torna a l'índex](./readme.md)

