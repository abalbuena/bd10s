CREATE TABLE REGISTRO_DE_ABOGADOS (
    CEDULA NUMBER(11) NOT NULL,
    NRO_REGISTRO NUMBER(4) NOT NULL,
    FECHA_BAJA DATE NULL
);
CREATE TABLE SUMARIO (
    ID_SUMARIO NUMBER(8) NOT NULL,
    COD_INSTITUCION NUMBER(8) NOT NULL,
    RESOLUCION_LEGAL VARCHAR2(20) NULL,
    FECHA_REGISTRO DATE NOT NULL,
    FECHA_INICIO_EFECTIVO DATE NOT NULL,
    FECHA_LIMITE DATE NOT NULL,
    FECHA_FIN DATE NULL
);
CREATE TABLE PERMISOS (
    ID_PERMISO NUMBER(12) NOT NULL,
    MOTIVO VARCHAR2(20) NOT NULL,
    FECHA_INI DATE NOT NULL,
    DIAS_PERMISO NUMBER(2) NOT NULL,
    FECHA_FIN DATE NULL,
    CEDULA NUMBER(11) NULL
);
CREATE TABLE FERIADOS (
    DIA_FERIADO DATE NOT NULL,
    MOTIVO VARCHAR2(20) NOT null
);
CREATE TABLE JUECES (
    CEDULA NUMBER(11),
    ID_SUMARIO NUMBER(8),
    TITULAR_SUPLENTE VARCHAR2(2) NOT NULL
);
CREATE TABLE SEGUIMIENTO(
    ID_SEGUIMIENTO NUMBER(8) NOT NULL,
    ID_SUMARIO NUMBER(8) NULL,
    FECHA_EVENTO DATE NOT NULL,
    DESCRIPCION VARCHAR2(4000) 
);
INSERT INTO SUMARIO (ID_SUMARIO, COD_INSTITUCION, RESOLUCION_LEGAL, FECHA_REGISTRO, FECHA_INICIO_EFECTIVO)
VALUES (1, 1, 'SABE', SYSDATE, SYSDATE);
INSERT INTO SEGUIMIENTO(ID_SEGUIMIENTO, ID_SUMARIO, FECHA_EVENTO, DESCRIPCION)
 VALUES (1, 1, ADD_MONTHS(SYSDATE, 5), 'AAAaaAA');