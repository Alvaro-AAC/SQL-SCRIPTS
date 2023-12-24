CREATE TABLE DIM_COMUNA (
    id_comuna INT PRIMARY KEY,
    comuna VARCHAR(100)
);

CREATE TABLE DIM_SUCURSAL (
    id_sucursal INT PRIMARY KEY,
    sucursal VARCHAR(200),
    id_comuna INT FOREIGN KEY REFERENCES DIM_COMUNA(id_comuna)
);

CREATE TABLE DIM_MES (
    id_mes INT PRIMARY KEY,
    mes VARCHAR(50),
    feriadosmes INT,
    mesdelannyo INT
);

CREATE TABLE DIM_FECHA (
    id_fecha INT PRIMARY KEY,
    fecha DATE,
    diasemana INT,
    diames INT,
    diaannyo INT,
    annyo INT,
    feriado INT,
    id_mes INT FOREIGN KEY REFERENCES DIM_MES(id_mes)
);

CREATE TABLE DIM_CATEGORIA (
    id_categoria INT PRIMARY KEY,
    categoria VARCHAR(200)
);

CREATE TABLE DIM_PRODUCTO (
    id_producto INT PRIMARY KEY,
    nombre VARCHAR(200),
    precio INT,
    id_categoria INT FOREIGN KEY REFERENCES DIM_CATEGORIA(id_categoria)
);

CREATE TABLE DETALLE_VENTA (
    id_venta INT,
    id_producto INT FOREIGN KEY REFERENCES DIM_PRODUCTO(id_producto),
    precio INT,
    descuento DECIMAL(5,2),
    cantidad INT,
    id_sucursal INT FOREIGN KEY REFERENCES DIM_SUCURSAL(id_sucursal),
    id_fecha INT FOREIGN KEY REFERENCES DIM_FECHA(id_fecha),
    CONSTRAINT PrimaryKeyVentas UNIQUE (id_venta, id_producto)
);
