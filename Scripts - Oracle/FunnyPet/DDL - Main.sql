DROP TABLE usuario CASCADE CONSTRAINTS;
DROP TABLE cliente CASCADE CONSTRAINTS;
DROP TABLE mascota CASCADE CONSTRAINTS;
DROP TABLE producto CASCADE CONSTRAINTS;
DROP TABLE carrito CASCADE CONSTRAINTS;
DROP TABLE carrito_producto CASCADE CONSTRAINTS;
DROP TABLE raza_mascota CASCADE CONSTRAINTS;
DROP TABLE tipo_mascota CASCADE CONSTRAINTS;
DROP TABLE ciudad CASCADE CONSTRAINTS;
DROP TABLE region CASCADE CONSTRAINTS;

DROP SEQUENCE seq_id_usuario;
DROP SEQUENCE seq_id_carrito;
DROP SEQUENCE seq_id_carrito_productos;
DROP SEQUENCE seq_id_producto;
DROP SEQUENCE seq_id_cliente;
DROP SEQUENCE seq_id_mascota;
DROP SEQUENCE seq_id_tipo;
DROP SEQUENCE seq_id_region;
DROP SEQUENCE seq_id_ciudad;

CREATE SEQUENCE seq_id_usuario;
CREATE SEQUENCE seq_id_carrito;
CREATE SEQUENCE seq_id_carrito_productos;
CREATE SEQUENCE seq_id_producto;
CREATE SEQUENCE seq_id_cliente;
CREATE SEQUENCE seq_id_mascota;
CREATE SEQUENCE seq_id_tipo;
CREATE SEQUENCE seq_id_region;
CREATE SEQUENCE seq_id_ciudad START WITH 0 MINVALUE 0;

CREATE TABLE region(
    id NUMBER(2) PRIMARY KEY,
    descripcion VARCHAR2(80) NOT NULL
);

CREATE TABLE ciudad(
    id NUMBER(4) PRIMARY KEY,
    id_region NUMBER(2) NOT NULL,
    descripcion VARCHAR2(80) NOT NULL,
    CONSTRAINT ciudad_region_fk FOREIGN KEY (id_region)
    REFERENCES region(id)
);

CREATE TABLE cliente (
    id NUMBER(6) PRIMARY KEY,
    rut NUMBER(8) UNIQUE NOT NULL,
    dv CHAR(1) NOT NULL,
    nombre VARCHAR2(40) NOT NULL,
    apellido VARCHAR2(40) NOT NULL,
    edad NUMBER(3) NOT NULL,
    tel NUMBER(12),
    ciudad NUMBER(4) NOT NULL,
    calle VARCHAR2(100) NOT NULL,
    num_casa NUMBER(6) NOT NULL,
    CONSTRAINT cliente_ciudad_fk FOREIGN KEY (ciudad)
    REFERENCES ciudad(id)
);

CREATE TABLE usuario (
    id NUMBER(6) PRIMARY KEY,
    id_cliente NUMBER(6) NOT NULL UNIQUE,
    correo VARCHAR2(200) NOT NULL UNIQUE,
    password VARCHAR2(500) NOT NULL,
    CONSTRAINT usuario_cliente_fk FOREIGN KEY (id_cliente)
    REFERENCES cliente(id) ENABLE
);

CREATE INDEX usuario ON usuario(correo, password);

CREATE TABLE tipo_mascota (
    id NUMBER(3) PRIMARY KEY,
    descripcion VARCHAR(25)
);

CREATE TABLE raza_mascota (
    id NUMBER(3) PRIMARY KEY,
    id_tipo NUMBER(3) UNIQUE,
    descripcion VARCHAR(30),
    CONSTRAINT raza_tipo_fk FOREIGN KEY (id_tipo)
    REFERENCES tipo_mascota(id)
);

CREATE TABLE mascota (
    id NUMBER(15) PRIMARY KEY,
    id_cliente NUMBER(6) NOT NULL UNIQUE,
    nombre VARCHAR2(50) NOT NULL,
    edad NUMBER(3) NOT NULL,
    enfermedad NUMBER(1) NOT NULL,
    enfermedad_desc VARCHAR2(80),
    tipo NUMBER(3) NOT NULL,
    raza NUMBER(3) NOT NULL,
    sexo CHAR(1) NOT NULL,
    esterilizado NUMBER(1),
    CONSTRAINT mascota_cliente_fk FOREIGN KEY (id_cliente)
    REFERENCES cliente(id) ENABLE,
    CONSTRAINT mascota_tipo_fk FOREIGN KEY (tipo)
    REFERENCES tipo_mascota(id) ENABLE,
    CONSTRAINT mascota_raza_fk FOREIGN KEY (raza)
    REFERENCES raza_mascota(id) ENABLE,
    CONSTRAINT mascota_enfermedad_bool CHECK (enfermedad IN (0, 1)) ENABLE,
    CONSTRAINT mascota_sexo CHECK (sexo IN ('H', 'M')) ENABLE,
    CONSTRAINT mascota_esterilizado CHECK (esterilizado IN (0, 1)) ENABLE
);

CREATE TABLE producto (
    id NUMBER(6) PRIMARY KEY,
    nombre VARCHAR2(40) NOT NULL,
    precio NUMBER(10) NOT NULL,
    descripcion VARCHAR2(200),
    CONSTRAINT producto_precio_check CHECK (precio>0)
);

CREATE TABLE carrito (
    id NUMBER(10) PRIMARY KEY,
    id_cliente NUMBER(6) NOT NULL UNIQUE,
    CONSTRAINT carrito_cliente_fk FOREIGN KEY (id_cliente)
    REFERENCES cliente(id)
);

CREATE TABLE carrito_producto (
    id NUMBER (16) PRIMARY KEY,
    id_carrito NUMBER(10) NOT NULL,
    id_producto NUMBER(6) NOT NULL,
    cantidad NUMBER(4) NOT NULL,
    CONSTRAINT carrito_productos_check CHECK (cantidad>0),
    CONSTRAINT carrito_productos_carrito_fk FOREIGN KEY (id_carrito)
    REFERENCES carrito(id) ENABLE,
    CONSTRAINT carrito_productos_producto_fk FOREIGN KEY (id_producto)
    REFERENCES producto(id) ENABLE
);