# Pràctica final Tema 2.1 - DDL

## Objectius

En aquesta pràctica final aplicaràs els coneixements adquirits en els apartats anteriors per crear i modificar l'esquema d'una base de dades. Els objectius són:
1. Crear una base de dades amb diverses taules relacionades.
2. Definir claus primàries, claus foranes i altres restriccions d'integritat.
3. Modificar l'esquema de la base de dades mitjançant instruccions `ALTER TABLE`.
4. Eliminar taules i dades de manera segura.
5. Comprendre les implicacions de les operacions DDL en la integritat i el rendiment de la base de dades.


## PDM (Physical data model)

Tots els camps són NOT NULL.

```text
                                                                                      
  ┌─────────────────┐   ┌──────────────────┐  ┌──────────────────┐ ┌───────────────┐  
  │Clients          │   │Factures          │  │Productes         │ │Categories     │  
  │                 │   │                  │  │                  │ │               │  
  │NIF   varchar PK │   │AnyFiscal int  PK │  │codi   varchar pk │ │Nom varchar pk │  
  │Nom   varchar AK1│   │Serie  varchar PK │  │nom    varchar    │ │               │  
  │eMail varchar    │   │Numero int     PK │  │refrigetat bit    │ └───────────────┘  
  └────────▲────────┘   │Descripcio varchar│  │preuVenta float   │                    
           │            │Total   float     │  │                  │                    
           │            │data    datetime  │  └───────────────▲──┘                    
           │            │cobrada bit       │                  │                       
           └────────────┼client varchar FK1│                  │                       
                        └─▲────────────────┘                  │                       
                          │                                   │                       
                          │                                   │                       
                          │        ┌────────────────────────┐ │                       
                          │        │LiniaDeFactura          │ │                       
                          │        │                        │ │                       
                          │        │AnyFiscal int  PK,FK1   │ │                       
                          └────────┼Serie  varchar PK,FK1   │ │                       
                                   │Numero int     PK,FK1   │ │                       
                                   │                        │ │                       
                                   │producte varchar PK,FK2 ┼─┘                       
                                   │                        │                         
                                   │quantitat  int          │                         
                                   └────────────────────────┘                         
                                                                                      
                                                                                        
                                                                  
```

## Comportament de les claus foranes:

* De factura a client: No permetre esborrar clients si tenen factures. No permetre canviar el NIF d'un client si té factures.
* De línia de factura a factura: En esborrar una factura s'esborren les línies associades. Si canviem la clau d'una factura, es propaga el canvi a les línies.
* De línia de factura a producte: No permetre esborrar productes si tenen línies de factura. No permetre canviar el codi d'un producte si té línies de factura.

## Exercici

Escriu l'SQL necessari per crear les taules i restriccions indicades al PDM. Afegeix també algunes dades d'exemple a cada taula.
Utilitza les instruccions `ALTER TABLE` per realitzar les següents modificacions a l'esquema:
1. Crea les taules i insereix dades.
2. Afegeix una columna `telefon` a la taula `Clients`.
3. Afegeix una clau forana de `producte` a `categories` (caldrà crear la columna i la restricció d'integritat referencial). Serà nullable, si s'esborra la categoria, el camp de producte es posa a NULL. Si s'actualitza el nom de la categoria, es propaga el canvi.
4. Canvia el tipus de dada de la columna `preuVenta` a `decimal(10,2)` a la taula `Productes`.
5. Esborra i torna a aferir la restricció d'integritat referencial de la taula `Factures` cap a `Clients`.
6. Elimina la columna `cobrada` de la taula `Factures`.
7. Afegeix una restricció d'unicitat a la columna `eMail` de la taula `Clients`.
8. Finalment, escriu les instruccions SQL per eliminar totes les dades de totes les taules.
9. Esborra totes les taules.
