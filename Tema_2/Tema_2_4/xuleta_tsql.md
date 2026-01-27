# Xuleta T‑SQL

Farem servir T‑SQL per a les pràctiques. Aquesta xuleta explica les constructs més útils amb exemples curts, pensats per a alumnes.

## Declarar variables i tipus

Declarem variables amb `DECLARE`. Els noms porten `@`.

```sql
DECLARE @id INT;
DECLARE @nom VARCHAR(100);
DECLARE @data DATETIME = GETDATE(); -- també es pot inicialitzar
```

Notes: T‑SQL no fa inferència de tipus; trieu mides adequades per `VARCHAR`.

## Assignar valor a les variables

Assignació amb `SET` o `SELECT`:

```sql
SET @id = 1;
SELECT @nom = nom FROM locals WHERE id = 1; -- s'assigna el primer resultat
```

Usar `SELECT` per assignacions múltiples és còmode però cal controlar que retorni una sola fila.

## IF / ELSE

Condicionals bàsics:

```sql
IF @id IS NULL
BEGIN
	RAISERROR('Id no definit',16,1);
END
ELSE
BEGIN
	PRINT('Id vàlid');
END
```

Sempre poseu `BEGIN ... END` per blocs amb més d'una instrucció.

## WHILE

Bucle senzill:

```sql
DECLARE @i INT = 1;
WHILE @i <= 5
BEGIN
	PRINT(@i);
	SET @i = @i + 1;
END
```

Eviteu bucles costosos sobre moltes files; preferiu operacions set‑based quan sigui possible.

## ISNULL i COALESCE

Per tractar valors NULL useu `ISNULL(expr, alt)` o `COALESCE(expr1, expr2, ...)`.

```sql
-- Si no hi ha vendes, volem 0
SELECT @total_venut = COALESCE(SUM(quantitat), 0) FROM vendes WHERE id_espectacle = 1;

-- ISNULL és equivalent per dos operands
SELECT ISNULL(@nom, 'sense nom');
```

`COALESCE` accepta múltiples operands i segueix l'ordre; `ISNULL` és específic per a dos operands i pot comportar‑se lleugerament diferent en el tipus retornat.

## TRY / CATCH i gestió d'errors

Patró recomanat per capturar errors i assegurar `ROLLBACK`:

```sql
BEGIN TRY
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
	BEGIN TRANSACTION;

		-- operacions que poden fallar

	COMMIT;
END TRY
BEGIN CATCH
	ROLLBACK;
	DECLARE @msg NVARCHAR(4000) = ERROR_MESSAGE();
	DECLARE @sev INT = ERROR_SEVERITY();
	DECLARE @st INT = ERROR_STATE();
	-- relança l'error per al client
	RAISERROR(@msg, @sev, @st);
END CATCH;
```

Alternativa moderna: `THROW` (SQL Server 2012+) per re‑llençar errors sense especificar severitat:

```sql
THROW; -- dins CATCH repropaga l'error actual
THROW 51000, 'Missatge', 1; -- llença un error personalitzat
```

## CREATE PROCEDURE (exemple)

Procediment típic amb paràmetres i comprovacions:

```sql
CREATE PROCEDURE Comprar_entrades
	@email VARCHAR(50),
	@quantitat INT,
	@id_espectacle INT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
		BEGIN TRANSACTION;

			-- validacions: existeix espectacle, finestra de venda, disponibilitat...
			-- accions: insert, updates, deletes, ...

		COMMIT;
	END TRY
	BEGIN CATCH
		ROLLBACK;
		THROW;
	END CATCH;
END;
```

Expliqueu sempre precondicions, postcondicions i possibles errors en cada procediment.

## CREATE FUNCTION (exemple senzill)

Funció escalar que retorna total venut per espectacle:

```sql
CREATE FUNCTION dbo.TotalVenut(@id_espectacle INT)
RETURNS INT
AS
BEGIN
	DECLARE @total INT;
	SELECT @total = ISNULL(SUM(quantitat),0) 
    FROM entrades 
    WHERE id_espectacle = @id_espectacle;
	
    RETURN @total;
END;
```

Nota: les funcions tenen restriccions (no poden fer COMMIT/ROLLBACK ni cridar procedures amb efectes secundaris en molts casos).

## CREATE TRIGGER (exemple)

Trigger d'exemple que registra insercions a `entrades`:

```sql
CREATE TRIGGER trg_after_insert_entrades
ON entrades
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO log_entrades(id_entrada, data_reg)
	SELECT i.id, GETDATE() FROM inserted i;
END;
```

`inserted` i `deleted` són taules màgiques disponibles dins del trigger.

## Consells ràpids
- Useu `SET NOCOUNT ON;` per evitar resultsets innecessaris.
- Prefereu operacions set‑based sobre bucles row‑by‑row.
- Documenteu i versioneu els scripts SQL.
- Per provar concurrència, obriu múltiples connexions i observeu comportament amb diferents nivells d'aïllament.

