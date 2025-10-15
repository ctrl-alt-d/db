# Physical Data Model - Sistema de Facturación

```text
                                                                                      
  ┌─────────────────────┐   ┌──────────────────────┐  ┌──────────────────┐ ┌───────────────┐  
  │Clients              │   │Factures              │  │Productes         │ │Categories     │  
  │                     │   │                      │  │                  │ │               │  
  │NIF      varchar PK  │   │AnyFiscal int      PK │  │codi   varchar PK │ │Nom varchar PK │  
  │Nom      varchar AK1 │   │Serie     varchar  PK │  │nom    varchar    │ │               │  
  │eMail    varchar     │   │Numero    int      PK │  │refrigerat bit    │ └───────────────┘  
  └──────────▲──────────┘   │Descripcio varchar   │  │preuVenta float   │                    
             │               │Total     float      │  │                  │                    
             │               │data      datetime   │  └────────────▲─────┘                    
             │               │cobrada   bit        │               │                          
             └───────────────┼client    varchar FK1│               │                          
                             └─▲───────────────────┘               │                          
                               │                                   │                          
                               │                                   │                          
                               │        ┌──────────────────────────┐│                         
                               │        │LiniaDeFactura            ││                         
                               │        │                          ││                         
                               │        │AnyFiscal int      PK,FK1 ││                         
                               └────────┼Serie     varchar  PK,FK1 ││                         
                                        │Numero    int      PK,FK1 ││                         
                                        │                          ││                         
                                        │producte  varchar  PK,FK2 ┼┘                         
                                        │                          │                          
                                        │quantitat int             │                          
                                        └──────────────────────────┘                          
                                                                                      
```

## Restriccions d'Integritat Referencial

### De Factures a Clients (client → Clients.NIF)
- **ON DELETE**: RESTRICT (No permetre esborrar clients si tenen factures)
- **ON UPDATE**: RESTRICT (No permetre canviar el NIF si té factures)

### De LiniaDeFactura a Factures (AnyFiscal, Serie, Numero → Factures)
- **ON DELETE**: CASCADE (En esborrar una factura s'esborren les línies)
- **ON UPDATE**: CASCADE (Es propaga el canvi a les línies)

### De LiniaDeFactura a Productes (producte → Productes.codi)
- **ON DELETE**: RESTRICT (No permetre esborrar productes si tenen línies)
- **ON UPDATE**: RESTRICT (No permetre canviar el codi si té línies)

## Claus

- **PK**: Primary Key (Clau Primària)
- **FK**: Foreign Key (Clau Forana)
- **AK**: Alternate Key (Clau Alternativa/Candidata)

## Notes

- Tots els camps són NOT NULL segons l'especificació
- Les claus compostesestan formades per múltiples camps (AnyFiscal, Serie, Numero)
- Categories s'afegirà posteriorment amb ALTER TABLE segons l'exercici
