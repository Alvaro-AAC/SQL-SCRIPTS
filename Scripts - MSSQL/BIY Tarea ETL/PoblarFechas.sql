/*
CREACION DIMENSION FECHAS
*/

DROP PROC [dbo].[Generar_DIM_Fecha]
GO

CREATE PROC [dbo].[Generar_DIM_Fecha]
AS
BEGIN

    -- RE GENERAR TABLA PRIMERO

    -- TRUNCATE TABLE DIM_Fecha; 
    DBCC CHECKIDENT ('DIM_Fecha', RESEED, 1);

    SET NOCOUNT ON;

        SET DATEFIRST  1, -- 1 = Lunes, 7 = Domingo
        DATEFORMAT dmy, 
        LANGUAGE   Español;

    DECLARE @fecha_inicio DATE = '2015-01-01'; -- ANTERIOR: '2014-01-01'
    DECLARE @fecha_termino DATE = '2015-12-31';
    DECLARE @curr_time DATETIME = CURRENT_TIMESTAMP;

    -- DECLARE @CutoffDate date = DATEADD(DAY, -1, DATEADD(YEAR, 30, @StartDate));

    WITH
    secuencia(num) AS (
        SELECT 0
        
        UNION ALL
        SELECT num + 1 FROM secuencia
        WHERE num < DATEDIFF(DAY, @fecha_inicio, @fecha_termino)
    )
    
    ,fechas(fecha) AS (
        SELECT DATEADD(DAY, num, @fecha_inicio)
        FROM secuencia
    )

    ,atributos AS (
        SELECT
            Fecha                  = CONVERT(DATE,fecha)
            ,DiaDelMes             = DATEPART(DAY,       fecha)
            ,DiaDeSemana           = DATEPART(WEEKDAY,   fecha)
            ,DiaDeSemanaNombre     = DATENAME(WEEKDAY,   fecha)
            ,Mes                   = DATEPART(MONTH,     fecha)
            ,Año                   = DATEPART(YEAR,      fecha)
    FROM fechas
    )

    INSERT INTO dbo.DIM_Fecha (
        Fecha
        ,DiaDelMes
        ,DiaDeSemana
        ,DiaDeSemanaNombre
        ,Mes
        ,Año
    )

    SELECT
        Fecha
        ,DiaDelMes
        ,DiaDeSemana
        ,DiaDeSemanaNombre
        ,Mes
        ,Año
    
    FROM atributos AS atr
    ORDER BY Fecha
    OPTION (MAXRECURSION 0)

END
GO

EXEC [dbo].[Generar_DIM_Fecha]
GO

DROP PROC [dbo].[Generar_DIM_Fecha]
GO