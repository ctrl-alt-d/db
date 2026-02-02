# Usuaris i Permisos

## Introducció

SQL Server utilitza un sistema de seguretat basat en **principals** (qui pot accedir) i **securables** (a què pot accedir). En aquest tema aprendrem a crear usuaris i assignar-los permisos sobre objectes de la base de dades.

## Conceptes bàsics

| Concepte | Descripció |
|----------|------------|
| **Login** | Compte a nivell de servidor (per connectar-se) |
| **User** | Compte a nivell de base de dades (per accedir a objectes) |
| **Role** | Grup de permisos que es poden assignar a usuaris |
| **Permission** | Dret a realitzar una acció sobre un objecte |

## Crear un Login i un Usuari

```sql
-- 1. Crear un login a nivell de servidor
CREATE LOGIN consulta_app
WITH PASSWORD = 'ContrAsenyA_Segura123!';

-- 2. Crear un usuari a la base de dades associat al login
USE LaNostraBaseDades;
CREATE USER consulta_app FOR LOGIN consulta_app;
```

## Permisos sobre objectes

### GRANT - Donar permisos

```sql
-- Permís SELECT sobre una taula
GRANT SELECT ON Client TO consulta_app;

-- Permís SELECT sobre una vista
GRANT SELECT ON vw_ClientsActius TO consulta_app;

-- Permís per executar un procediment emmagatzemat
GRANT EXECUTE ON sp_ObtenirClient TO consulta_app;

-- Múltiples permisos alhora
GRANT SELECT, INSERT, UPDATE ON Comanda TO consulta_app;
```

### DENY - Denegar permisos

```sql
-- Denegar explícitament (té prioritat sobre GRANT)
DENY DELETE ON Client TO consulta_app;
```

### REVOKE - Revocar permisos

```sql
-- Treure un permís concedit anteriorment
REVOKE SELECT ON Client FROM consulta_app;
```

## Principals rols de base de dades

SQL Server inclou rols predefinits:

| Rol | Descripció |
|-----|------------|
| **db_owner** | Control total sobre la base de dades |
| **db_datareader** | SELECT sobre totes les taules |
| **db_datawriter** | INSERT, UPDATE, DELETE sobre totes les taules |
| **db_ddladmin** | Pot crear/modificar/eliminar objectes (DDL) |
| **db_securityadmin** | Gestiona permisos i rols |
| **public** | Rol per defecte de tots els usuaris |

### Assignar un usuari a un rol

```sql
-- Afegir usuari al rol db_datareader
ALTER ROLE db_datareader ADD MEMBER consulta_app;

-- Treure usuari d'un rol
ALTER ROLE db_datareader DROP MEMBER consulta_app;
```

## Exemple pràctic complet

Crearem un usuari `app_vendes` que només pugui:
- Consultar algunes vistes
- Executar un procediment emmagatzemat

### 1. Preparació: Crear les vistes i el procediment

```sql
-- Vista de clients (sense dades sensibles)
CREATE VIEW vw_ClientsPublic AS
SELECT Id, Nom, Cognom, Ciutat
FROM Client;
GO

-- Vista de productes disponibles
CREATE VIEW vw_ProductesDisponibles AS
SELECT Id, Nom, Preu, Stock
FROM Producte
WHERE Stock > 0;
GO

-- Procediment per obtenir comandes d'un client
CREATE PROCEDURE sp_ComandesClient
    @ClientId INT
AS
BEGIN
    SELECT Id, Data, Total, Estat
    FROM Comanda
    WHERE ClientId = @ClientId;
END;
GO
```

### 2. Crear el login i l'usuari

```sql
-- Crear login
CREATE LOGIN app_vendes
WITH PASSWORD = 'AppVendes_2026!';

-- Crear usuari a la base de dades
USE LaNostraBaseDades;
CREATE USER app_vendes FOR LOGIN app_vendes;
```

### 3. Assignar permisos específics

```sql
-- Permís SELECT només sobre les vistes
GRANT SELECT ON vw_ClientsPublic TO app_vendes;
GRANT SELECT ON vw_ProductesDisponibles TO app_vendes;

-- Permís per executar el procediment
GRANT EXECUTE ON sp_ComandesClient TO app_vendes;
```

### 4. Verificar els permisos

```sql
-- Veure permisos d'un usuari
SELECT 
    dp.name AS Usuari,
    o.name AS Objecte,
    p.permission_name AS Permis,
    p.state_desc AS Estat
FROM sys.database_permissions p
JOIN sys.database_principals dp ON p.grantee_principal_id = dp.principal_id
JOIN sys.objects o ON p.major_id = o.object_id
WHERE dp.name = 'app_vendes';
```

### 5. Provar els permisos

```sql
-- Connectar-se com app_vendes i provar:

-- ✅ Això funcionarà
SELECT * FROM vw_ClientsPublic;
SELECT * FROM vw_ProductesDisponibles;
EXEC sp_ComandesClient @ClientId = 1;

-- ❌ Això fallarà (no té permisos)
SELECT * FROM Client;  -- Error: SELECT permission denied
DELETE FROM Producte;  -- Error: DELETE permission denied
```

## Crear rols personalitzats

Podem crear els nostres propis rols per agrupar permisos:

```sql
-- Crear un rol personalitzat
CREATE ROLE rol_consulta_vendes;

-- Assignar permisos al rol
GRANT SELECT ON vw_ClientsPublic TO rol_consulta_vendes;
GRANT SELECT ON vw_ProductesDisponibles TO rol_consulta_vendes;
GRANT EXECUTE ON sp_ComandesClient TO rol_consulta_vendes;

-- Afegir usuaris al rol
ALTER ROLE rol_consulta_vendes ADD MEMBER app_vendes;
ALTER ROLE rol_consulta_vendes ADD MEMBER altre_usuari;
```

## Resum

| Comanda | Funció |
|---------|--------|
| `CREATE LOGIN` | Crear compte de servidor |
| `CREATE USER` | Crear usuari de base de dades |
| `GRANT` | Donar permisos |
| `DENY` | Denegar permisos |
| `REVOKE` | Revocar permisos |
| `ALTER ROLE ... ADD MEMBER` | Afegir usuari a un rol |

> 💡 **Principi del mínim privilegi**: Dona sempre els permisos mínims necessaris. És millor donar accés a vistes que directament a taules.
