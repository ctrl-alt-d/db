# Exercici venta d'entrades espectacles

Aquest fitxer descriu la pràctica de venda d'entrades per espectacles. Conté les DDL necessàries, un parell de procediments emmagatzemats (crear esdeveniment i comprar entrades) i indicacions per a provar-los.

```sql
-- Taules bàsiques
CREATE TABLE Locals(
  id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  adreca VARCHAR(100) NOT NULL,
  aforament INT NOT NULL,
  nom VARCHAR(100) NOT NULL
);

CREATE TABLE espectacles(
  id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  nom VARCHAR(100) NOT NULL,
  max_entrades INT NULL,
  moment_inici DATETIME NOT NULL,
  venta_opertura DATETIME NOT NULL,
  venta_tancament DATETIME NOT NULL,
  limit_x_email INT NULL,
  id_local INT NOT NULL,
  CONSTRAINT espectacles_a_locals_fk FOREIGN KEY (id_local)
    REFERENCES Locals(id)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
);

CREATE TABLE entrades(
  id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  email VARCHAR(50) NOT NULL,
  data_compra DATETIME NOT NULL,
  quantitat INT NOT NULL,
  id_espectacle INT NOT NULL,
  CONSTRAINT entrades_a_espectacles_fk FOREIGN KEY (id_espectacle)
    REFERENCES espectacles(id)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
);

-- Exemples d'inserció
INSERT INTO Locals(adreca, aforament, nom)
VALUES('c Arquitecte MP', 10, 'Local A');

-- Podeu ajustar dates per provar còpies reals
```

## **Primera part**: crear espectacle

Objectiu: escriure un procediment `nou_esdeveniment` que valida dades i crea un nou espectacle. Les comprovacions inclouen:
- el local existeix,
- el nom és no buit,
- la data d'inici està en el futur,
- les dates de venda són coherents (obertura < tancament < inici),
- la sala està lliure en un radi de temps (ex. ±8 hores),
- el `max_entrades` no supera l'aforament del local,
- el `limit_x_email`, si s'informa, és positiu.

Hem triat `SERIALIZABLE` com a nivell d'aïllament per evitar anomalies de concurrència (especialment phantom reads quan comprovem disponibilitat de la sala en un radi de temps).

Solució:

```sql
CREATE PROCEDURE nou_esdeveniment (
  @nom VARCHAR(100),
  @max_entrades INT,
  @moment_inici DATETIME,
  @venta_opertura DATETIME,
  @venta_tancament DATETIME,
  @limit_x_email INT,
  @id_local INT
) AS
BEGIN
  BEGIN TRANSACTION;
  SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
  BEGIN TRY
    -- 1) comprovem local
    IF NOT EXISTS (SELECT 1 FROM Locals WHERE id = @id_local)
      RAISERROR('Local no trobat',16,1);

    -- 2) nom
    IF LEN(RTRIM(@nom)) < 1
      RAISERROR('Cal informar el nom de l''espectacle',16,1);

    -- 3) dates
    IF @moment_inici <= GETDATE()
      RAISERROR('L''inici ha de ser posterior a la data actual',16,1);

    IF @venta_tancament >= @moment_inici
      RAISERROR('No podem vendre entrades quan l''espectacle ja ha començat',16,1);

    IF @venta_tancament < @venta_opertura
      RAISERROR('La data de tancament ha de ser posterior a l''obertura',16,1);

    -- 4) comprovar solapaments de sala (±8h)
    DECLARE @ant DATETIME = DATEADD(HOUR,-8,@moment_inici);
    DECLARE @post DATETIME = DATEADD(HOUR,8,@moment_inici);
    IF EXISTS (
      SELECT 1 FROM espectacles
      WHERE id_local = @id_local
        AND moment_inici BETWEEN @ant AND @post
    )
      RAISERROR('La sala no està lliure en aquesta franja',16,1);

    -- 5) aforament
    DECLARE @aforament INT;
    SELECT @aforament = aforament FROM Locals WHERE id = @id_local;
    IF @max_entrades > @aforament
      RAISERROR('Max entrades supera l''aforament del local',16,1);

    -- 6) limit per email
    IF @limit_x_email IS NOT NULL AND @limit_x_email <= 0
      RAISERROR('El límit per email, si s''informa, ha de ser positiu',16,1);

    INSERT INTO espectacles(nom, max_entrades, moment_inici, venta_opertura, venta_tancament, limit_x_email, id_local)
    VALUES(@nom,@max_entrades,@moment_inici,@venta_opertura,@venta_tancament,@limit_x_email,@id_local);

    COMMIT;
    PRINT('Commit');
  END TRY
  BEGIN CATCH
    ROLLBACK;
    DECLARE @msg NVARCHAR(4000) = ERROR_MESSAGE();
    DECLARE @sev INT = ERROR_SEVERITY();
    DECLARE @st INT = ERROR_STATE();
    RAISERROR(@msg,@sev,@st);
  END CATCH;
END;
```

Exemple d'execució de prova (ajusteu les dates segons la vostra data actual):

```sql
EXEC nou_esdeveniment
  'Cant coral',
  3,
  '2026-02-17 21:00:00',
  '2026-01-20 10:00:00',
  '2026-02-15 19:00:00',
  2,
  1;
```

## **Segona part**: vendre entrades

Objectiu: crear `Comprar_entrades(@email, @quantitat, @id_espectacle)` que:
- comprovi que l'espectacle existeix,
- respecti el `limit_x_email` per usuari,
- comprovi que estem dins la finestra de venda,
- comprovi que queden entrades (no sobrepassar `max_entrades`),
- validi la quantitat (>0) i, finalment, inseri la compra.

Per evitar condicions de carrera al calcular el total de comprades i sumar la nova quantitat, triem `SERIALIZABLE` per assegurar que no apareguin phantoms (nous inserts concurrents que podrien invalidar la comprovació).

Solució:

```sql
CREATE PROCEDURE Comprar_entrades (
  @email VARCHAR(50),
  @quantitat INT,
  @id_espectacle INT
) AS
BEGIN
  SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
  BEGIN TRANSACTION;
  BEGIN TRY
    -- 1) existeix l'espectacle
    IF NOT EXISTS (SELECT 1 FROM espectacles WHERE id = @id_espectacle)
      RAISERROR('Espectacle no trobat',16,1);

    -- 2) limit per email
    DECLARE @max_x_email INT;
    SELECT @max_x_email = limit_x_email FROM espectacles WHERE id = @id_espectacle;

    DECLARE @ja_comprades INT = (
      SELECT ISNULL(SUM(quantitat),0) FROM entrades
      WHERE email = @email AND id_espectacle = @id_espectacle
    );

    IF @max_x_email IS NOT NULL AND (@quantitat + @ja_comprades) > @max_x_email
      RAISERROR('Has superat el límit d''entrades per correu',16,1);

    -- 3) finestra de venda
    DECLARE @venta_opertura DATETIME, @venta_tancament DATETIME;
    SELECT @venta_opertura = venta_opertura, @venta_tancament = venta_tancament
      FROM espectacles WHERE id = @id_espectacle;

    IF GETDATE() < @venta_opertura OR GETDATE() > @venta_tancament
      RAISERROR('No es pot comprar l''entrada ara mateix',16,1);

    -- 4) disponibilitat global
    DECLARE @total_comprades INT = (
      SELECT ISNULL(SUM(quantitat),0) FROM entrades WHERE id_espectacle = @id_espectacle
    );
    DECLARE @max_entrades INT;
    SELECT @max_entrades = max_entrades FROM espectacles WHERE id = @id_espectacle;

    IF (@total_comprades + @quantitat) > @max_entrades
      RAISERROR('Les entrades estan esgotades',16,1);

    -- 5) quantitat valida
    IF @quantitat <= 0
      RAISERROR('No es poden comprar 0 entrades',16,1);

    -- 6) inserir compra
    INSERT INTO entrades(email, data_compra, quantitat, id_espectacle)
    VALUES(@email, GETDATE(), @quantitat, @id_espectacle);

    COMMIT;
    PRINT('commit');
  END TRY
  BEGIN CATCH
    ROLLBACK;
    DECLARE @msg NVARCHAR(4000) = ERROR_MESSAGE();
    DECLARE @sev INT = ERROR_SEVERITY();
    DECLARE @st INT = ERROR_STATE();
    RAISERROR(@msg,@sev,@st);
  END CATCH;
END;
```

Proves ràpides:

```sql
-- Comprar 2 entrades per a l'espectacle id=1
EXEC Comprar_entrades 'usuari@example.com', 2, 1;
```

## Observacions finals
- Les transaccions utilitzen `SERIALIZABLE` per a les comprovacions de counts/phantoms. Si es desitja més rendiment amb menys garanties, es pot estudiar desnormalitzar (p.ex. mantenir un comptador de vendes a `espectacles`) i baixar a `REPEATABLE READ`, però cal garantir l'actualització atòmica del comptador amb `UPDATE` dins de la mateixa transacció.
- Proveu escenaris concurrents per validar l'aïllament esperat.



