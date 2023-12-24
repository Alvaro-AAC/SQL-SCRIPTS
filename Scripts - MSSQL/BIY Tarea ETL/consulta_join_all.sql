SELECT
    *
FROM
(SELECT
    [b].[mes]
    ,[c].[Familia]
    ,SUM([a].[Cantidad]) AS [CantidadVendida]
    ,SUM(CONVERT(BIGINT,[a].[Total]))  AS [TotalVendido]
FROM [Americans_DW].[dbo].[FACT_DetalleVenta] AS [a]
JOIN [Americans_DW].[dbo].[DIM_Fecha] AS [b] 
    ON [a].[FechaID] = [b].[FechaID]
JOIN [Americans_DW].[dbo].[DIM_Articulo] AS [c] 
    ON [a].[ArticuloID] = [c].[ArticuloID]
GROUP BY [b].[mes], [c].[Familia]) AS maina

JOIN

(SELECT
    [b].[Mes]
    ,SUM([a].[Cantidad]) AS [CantidadVendidaMensual]
    ,SUM(CONVERT(BIGINT,[a].[Total]))  AS [TotalVendidoMensual]
FROM [Americans_DW].[dbo].[FACT_DetalleVenta] AS [a]
JOIN [Americans_DW].[dbo].[DIM_Fecha] AS [b] 
    ON [a].[FechaID] = [b].[FechaID]
JOIN [Americans_DW].[dbo].[DIM_Articulo] AS [c] 
    ON [a].[ArticuloID] = [c].[ArticuloID]
GROUP BY [b].[Mes]) AS mainb
ON maina.Mes = mainb.Mes

;