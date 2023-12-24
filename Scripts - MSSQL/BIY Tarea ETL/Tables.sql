/*
CREACION DIMENSION FECHAS
*/

DROP TABLE [dbo].[FACT_DetalleVenta]
GO

DROP TABLE [dbo].[DIM_Fecha]
GO

DROP TABLE [dbo].[DIM_Articulo]
GO

CREATE TABLE [dbo].[DIM_Fecha](
    [FechaID] [bigint] IDENTITY(1,1) PRIMARY KEY,
    [Fecha] [date] NULL,
    [DiaDelMes] [int] NULL,
    [DiaDeSemana] [int] NULL,
    [DiaDeSemanaNombre] [varchar](20) NULL,
    [Mes] [int] NULL,
    [Año] [int] NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[DIM_Articulo](
    [ArticuloID] [bigint] IDENTITY(1,1) PRIMARY KEY,
    [CodigoProducto] [nvarchar](255),
    [Nombre] [nvarchar](255) NULL,
    [Familia] [nvarchar](255) NULL
)
GO

CREATE TABLE [dbo].[FACT_DetalleVenta](
    [DetalleVentaID] [bigint] IDENTITY(1,1) NOT NULL,
    [Cantidad] [int] NULL,
    [Total] [int] NULL,
    [FechaID] [bigint] FOREIGN KEY REFERENCES DIM_Fecha(FechaID),
    [ArticuloID] [bigint] FOREIGN KEY REFERENCES DIM_Articulo(ArticuloID)
)
GO

