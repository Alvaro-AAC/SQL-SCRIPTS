-- ----------------------------------------
-- Sistema de Salud Metropolitano Sur Oriente
-- ----------------------------------------
-- Creacion de tablas y constraints
-- ----------------------------------------
-- ** ** ** DDL ** ** **
-- ----------------------------------------


CREATE TABLE atencion (
    id_atencion      NUMBER(12) NOT NULL,
    fecha            DATE NOT NULL,
    motivo           VARCHAR2(200) NOT NULL,
    descripcion      VARCHAR2(1000),
    id_medico        NUMBER(7) NOT NULL,
    id_paciente      NUMBER(12) NOT NULL,
    id_interconsulta NUMBER(12)
);

CREATE UNIQUE INDEX atencion__idx ON
    atencion (
        id_interconsulta
    ASC );

ALTER TABLE atencion ADD CONSTRAINT atencion_pk PRIMARY KEY ( id_atencion );

CREATE TABLE bitacora_cirugia (
    id_bitacora_cirugia NUMBER(16) NOT NULL,
    detalle             VARCHAR2(3000) NOT NULL,
    fecha               DATE NOT NULL,
    hora                TIMESTAMP NOT NULL,
    id_cirugia          NUMBER(12) NOT NULL
);

ALTER TABLE bitacora_cirugia ADD CONSTRAINT bitacora_cirugia_pk PRIMARY KEY ( id_bitacora_cirugia );

CREATE TABLE cargo (
    id_cargo    NUMBER(5) NOT NULL,
    descripcion VARCHAR2(50) NOT NULL
);

ALTER TABLE cargo ADD CONSTRAINT cargo_pk PRIMARY KEY ( id_cargo );

CREATE TABLE cirugia (
    id_cirugia         NUMBER(12) NOT NULL,
    fecha              DATE NOT NULL,
    id_reserva_cirugia NUMBER(12) NOT NULL
);

CREATE UNIQUE INDEX cirugia__idx ON
    cirugia (
        id_reserva_cirugia
    ASC );

ALTER TABLE cirugia ADD CONSTRAINT cirugia_pk PRIMARY KEY ( id_cirugia );

CREATE TABLE ciudad (
    id_ciudad   NUMBER(4) NOT NULL,
    descripcion VARCHAR2(150) NOT NULL,
    id_region   NUMBER(2) NOT NULL
);

ALTER TABLE ciudad ADD CONSTRAINT ciudad_pk PRIMARY KEY ( id_ciudad );

CREATE TABLE comuna (
    id_comuna   NUMBER(5) NOT NULL,
    descripcion VARCHAR2(150) NOT NULL,
    id_ciudad   NUMBER(4) NOT NULL
);

ALTER TABLE comuna ADD CONSTRAINT comuna_pk PRIMARY KEY ( id_comuna );

CREATE TABLE detalle_unidad (
    id_detalle_unidad NUMBER(20) NOT NULL,
    id_unidad         NUMBER(12) NOT NULL,
    id_medico         NUMBER(7) NOT NULL
);

ALTER TABLE detalle_unidad ADD CONSTRAINT detalle_unidad_pk PRIMARY KEY ( id_detalle_unidad );

CREATE TABLE disponibilidad_pabellon (
    id_disponibilidad_pabellon NUMBER(20) NOT NULL,
    disponible                 CHAR(1) NOT NULL,
    id_pabellon                NUMBER(4) NOT NULL,
    id_modulo                  NUMBER(4) NOT NULL
);

ALTER TABLE disponibilidad_pabellon ADD CONSTRAINT disponibilidad_pabellon_pk PRIMARY KEY ( id_disponibilidad_pabellon );

CREATE TABLE evaluacion (
    id_evaluacion NUMBER(12) NOT NULL,
    id_paciente   NUMBER(12) NOT NULL,
    fecha         DATE NOT NULL,
    atencion      VARCHAR2(50) NOT NULL,
    riesgo        NUMBER(5, 2) NOT NULL,
    id_atencion   NUMBER(12) NOT NULL
);

ALTER TABLE evaluacion ADD CONSTRAINT evaluacion_pk PRIMARY KEY ( id_evaluacion,
                                                                  id_paciente );

CREATE TABLE medico (
    id_medico     NUMBER(7) NOT NULL,
    rut           NUMBER(8) NOT NULL,
    dv            CHAR(1) NOT NULL,
    nombre        VARCHAR2(50) NOT NULL,
    apellido_p    VARCHAR2(50) NOT NULL,
    apellido_m    VARCHAR2(50) NOT NULL,
    genero        CHAR(1) NOT NULL,
    fecha_nac     DATE NOT NULL,
    telefono      NUMBER(9) NOT NULL,
    correo        VARCHAR2(200) NOT NULL,
    password      VARCHAR2(2000) NOT NULL,
    direccion     VARCHAR2(100) NOT NULL,
    administrador CHAR(1) NOT NULL,
    habilitado    CHAR(1) NOT NULL,
    id_cargo      NUMBER(5) NOT NULL,
    id_comuna     NUMBER(5) NOT NULL,
    id_jefe       NUMBER(7)
);

ALTER TABLE medico ADD CONSTRAINT medico_pk PRIMARY KEY ( id_medico );

ALTER TABLE medico ADD CONSTRAINT medico_rut_un UNIQUE ( rut );

CREATE TABLE modulo (
    id_modulo NUMBER(4) NOT NULL,
    hora_ini  DATE NOT NULL,
    hora_fin  DATE NOT NULL
);

ALTER TABLE modulo ADD CONSTRAINT modulo_pk PRIMARY KEY ( id_modulo );

CREATE TABLE pabellon (
    id_pabellon NUMBER(4) NOT NULL,
    piso        NUMBER(2) NOT NULL,
    numeracion  NUMBER(4) NOT NULL,
    habilitado  CHAR(1) NOT NULL
);

ALTER TABLE pabellon ADD CONSTRAINT pabellon_pk PRIMARY KEY ( id_pabellon );

CREATE TABLE paciente (
    id_paciente NUMBER(12) NOT NULL,
    rut         NUMBER(8) NOT NULL,
    dv          CHAR(1) NOT NULL,
    nombre      VARCHAR2(50) NOT NULL,
    apellido_p  VARCHAR2(50) NOT NULL,
    apellido_m  VARCHAR2(50) NOT NULL,
    genero      CHAR(1) NOT NULL,
    fecha_nac   DATE NOT NULL,
    telefono    NUMBER(9) NOT NULL,
    correo      VARCHAR2(200) NOT NULL
);

ALTER TABLE paciente ADD CONSTRAINT paciente_pk PRIMARY KEY ( id_paciente );

CREATE TABLE programacion_cirugia (
    id_reserva_cirugia NUMBER(12) NOT NULL,
    fecha              DATE NOT NULL,
    notificado         CHAR(1) NOT NULL,
    id_medico          NUMBER(7) NOT NULL,
    id_evaluacion      NUMBER(12) NOT NULL,
    id_paciente        NUMBER(12) NOT NULL,
    id_detalle_unidad  NUMBER(20) NOT NULL
);

ALTER TABLE programacion_cirugia ADD CONSTRAINT programacion_cirugia_pk PRIMARY KEY ( id_reserva_cirugia );

CREATE TABLE recurso (
    id_recurso       NUMBER(3) NOT NULL,
    nombre           VARCHAR2(50) NOT NULL,
    descripcion      VARCHAR2(200) NOT NULL,
    cantidad_actual  NUMBER(9) NOT NULL,
    cantidad_maxima  NUMBER(9) NOT NULL,
    cantidad_peligro NUMBER(9)
);

ALTER TABLE recurso ADD CONSTRAINT recurso_pk PRIMARY KEY ( id_recurso );

CREATE TABLE region (
    id_region   NUMBER(2) NOT NULL,
    descripcion VARCHAR2(150) NOT NULL
);

ALTER TABLE region ADD CONSTRAINT region_pk PRIMARY KEY ( id_region );

CREATE TABLE reserva_pabellon (
    id_reserva                 NUMBER(16) NOT NULL,
    fecha                      DATE NOT NULL,
    id_reserva_cirugia         NUMBER(12) NOT NULL,
    id_disponibilidad_pabellon NUMBER(20) NOT NULL
);

CREATE UNIQUE INDEX reserva_pabellon__idx ON
    reserva_pabellon (
        id_reserva_cirugia
    ASC );

ALTER TABLE reserva_pabellon ADD CONSTRAINT reserva_pabellon_pk PRIMARY KEY ( id_reserva );

CREATE TABLE reserva_recurso (
    cantidad   NUMBER(9) NOT NULL,
    id_recurso NUMBER(3) NOT NULL,
    id_reserva NUMBER(16) NOT NULL
);

ALTER TABLE reserva_recurso ADD CONSTRAINT reserva_recurso_pk PRIMARY KEY ( id_recurso, id_reserva );

CREATE TABLE unidad (
    id_unidad NUMBER(12) NOT NULL
);

ALTER TABLE unidad ADD CONSTRAINT unidad_pk PRIMARY KEY ( id_unidad );

ALTER TABLE atencion
    ADD CONSTRAINT atencion_atencion_fk FOREIGN KEY ( id_interconsulta )
        REFERENCES atencion ( id_atencion );

ALTER TABLE atencion
    ADD CONSTRAINT atencion_medico_fk FOREIGN KEY ( id_medico )
        REFERENCES medico ( id_medico );

ALTER TABLE atencion
    ADD CONSTRAINT atencion_paciente_fk FOREIGN KEY ( id_paciente )
        REFERENCES paciente ( id_paciente );

ALTER TABLE bitacora_cirugia
    ADD CONSTRAINT bcc_fk FOREIGN KEY ( id_cirugia )
        REFERENCES cirugia ( id_cirugia );

ALTER TABLE cirugia
    ADD CONSTRAINT cpc_fk FOREIGN KEY ( id_reserva_cirugia )
        REFERENCES programacion_cirugia ( id_reserva_cirugia );

ALTER TABLE ciudad
    ADD CONSTRAINT ciudad_region_fk FOREIGN KEY ( id_region )
        REFERENCES region ( id_region );

ALTER TABLE comuna
    ADD CONSTRAINT comuna_ciudad_fk FOREIGN KEY ( id_ciudad )
        REFERENCES ciudad ( id_ciudad );

ALTER TABLE detalle_unidad
    ADD CONSTRAINT detalle_unidad_medico_fk FOREIGN KEY ( id_medico )
        REFERENCES medico ( id_medico );

ALTER TABLE detalle_unidad
    ADD CONSTRAINT detalle_unidad_unidad_fk FOREIGN KEY ( id_unidad )
        REFERENCES unidad ( id_unidad );

ALTER TABLE disponibilidad_pabellon
    ADD CONSTRAINT dpm_fk FOREIGN KEY ( id_modulo )
        REFERENCES modulo ( id_modulo );

ALTER TABLE disponibilidad_pabellon
    ADD CONSTRAINT dpp_fk FOREIGN KEY ( id_pabellon )
        REFERENCES pabellon ( id_pabellon );

ALTER TABLE evaluacion
    ADD CONSTRAINT evaluacion_atencion_fk FOREIGN KEY ( id_atencion )
        REFERENCES atencion ( id_atencion );

ALTER TABLE evaluacion
    ADD CONSTRAINT evaluacion_paciente_fk FOREIGN KEY ( id_paciente )
        REFERENCES paciente ( id_paciente );

ALTER TABLE medico
    ADD CONSTRAINT medico_cargo_fk FOREIGN KEY ( id_cargo )
        REFERENCES cargo ( id_cargo );

ALTER TABLE medico
    ADD CONSTRAINT medico_comuna_fk FOREIGN KEY ( id_comuna )
        REFERENCES comuna ( id_comuna );

ALTER TABLE medico
    ADD CONSTRAINT medico_medico_fk FOREIGN KEY ( id_jefe )
        REFERENCES medico ( id_medico );

ALTER TABLE programacion_cirugia
    ADD CONSTRAINT pcdu_fk FOREIGN KEY ( id_detalle_unidad )
        REFERENCES detalle_unidad ( id_detalle_unidad );

ALTER TABLE programacion_cirugia
    ADD CONSTRAINT pce_fk FOREIGN KEY ( id_evaluacion, id_paciente )
        REFERENCES evaluacion ( id_evaluacion, id_paciente );

ALTER TABLE programacion_cirugia
    ADD CONSTRAINT programacion_cirugia_medico_fk FOREIGN KEY ( id_medico )
        REFERENCES medico ( id_medico );

ALTER TABLE reserva_pabellon
    ADD CONSTRAINT rpdp_fk FOREIGN KEY ( id_disponibilidad_pabellon )
        REFERENCES disponibilidad_pabellon ( id_disponibilidad_pabellon );

ALTER TABLE reserva_pabellon
    ADD CONSTRAINT rppc_fk FOREIGN KEY ( id_reserva_cirugia )
        REFERENCES programacion_cirugia ( id_reserva_cirugia );

ALTER TABLE reserva_recurso
    ADD CONSTRAINT reserva_recurso_recurso_fk FOREIGN KEY ( id_recurso )
        REFERENCES recurso ( id_recurso );

ALTER TABLE reserva_recurso
    ADD CONSTRAINT rrrp_fk FOREIGN KEY ( id_reserva )
        REFERENCES reserva_pabellon ( id_reserva );