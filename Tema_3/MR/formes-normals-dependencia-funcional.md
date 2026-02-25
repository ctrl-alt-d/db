# El concepte de dependències funcionals i els seus tipus  
## DAW-MP02-UF1 - Exercici d'introducció a les bases de dades

Tot el procés de normalització té un fonament matemàtic, i les definicions es poden expressar en un llenguatge semblant al llenguatge matemàtic. Anem a veure la definició formal de **dependència funcional**:

> Given a relation R, a set of attributes X in R is said to functionally determine another set of attributes Y, also in R, (written X → Y) if, and only if, each X value in R is associated with precisely one Y value in R; R is then said to satisfy the functional dependency X → Y.

Aquesta definició no ens ha d'espantar perquè té una interpretació senzilla. El que ens diu és que hi ha una **dependència funcional** entre atributs quan un atribut o un conjunt d'atributs poden determinar el valor d'un altre atribut o conjunt d'atributs.

### Exemple:  
Imagina la taula `Països` amb els següents atributs:
- **Codi ISO 3166**
- **Kilòmetres quadrats**
- **Número d'habitants**

En aquest cas, el **Codi ISO 3166** pot determinar els valors de **Kilòmetres quadrats** i **Número d'habitants**, és a dir:
- `Codi ISO 3166 → Kilòmetres quadrats`
- `Codi ISO 3166 → Número d'habitants`

---

## **Exercici**

1. **Proposa un exemple de dependència funcional:**  
   Intenta formular un exemple propi on un atribut o conjunt d'atributs determini un altre conjunt d'atributs. Per exemple:
   - En una taula `Estudiants`, el camp `DNI` determina el valor del camp `Nom` i `Cognoms`:
     - `DNI → Nom, Cognoms`

2. **Dependència funcional en altres contextos:**  
   El concepte de dependència funcional no només apareix en el procés de normalització. Per exemple, en el SGBD **MySQL**, els paràmetres de configuració poden utilitzar dependències funcionals per optimitzar les consultes. 

### Fragment de documentació de MySQL:
> MySQL 5.7.5 and up implements detection of functional dependence. If the ONLY_FULL_GROUP_BY SQL mode is enabled (which it is by default), MySQL rejects queries for which the select list, HAVING condition, or ORDER BY list refer to nonaggregated columns that are neither named in the GROUP BY clause nor are functionally dependent on them. (Before 5.7.5, MySQL does not detect functional dependency and ONLY_FULL_GROUP_BY is not enabled by default. For a description of pre-5.7.5 behavior, see the MySQL 5.6 Reference Manual.)

Documentació completa: [MySQL Group By Handling](https://dev.mysql.com/doc/refman/5.7/en/group-by-handling.html)

Aquest mecanisme permet detectar dependències funcionals per garantir que les consultes SQL són consistents i eficients, especialment quan es fan servir grups o agregacions. Recorda que, més endavant, treballarem amb aquest concepte en contextos com optimització de consultes.
