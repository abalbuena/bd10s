
---PARTE 1---

--CREACION DE TABLAS DEL DER-TALLER

CREATE TABLE L_MARCA (
    ID_MARCA NUMBER (5) GENERATED ALWAYS AS IDENTITY 
        START WITH 1
        MINVALUE 1
        MAXVALUE 999999
        INCREMENT BY 1 NOCACHE NOCYCLE NOT NULL,
    DESCRIPCION VARCHAR2 (50) NOT NULL
)TABLESPACE BASED2TP;

CREATE TABLE L_MODELO (
    ID_MODELO NUMBER (6) NOT NULL,
    ID_MARCA NUMBER (5) NOT NULL,
    DESCRIPCION VARCHAR2 (60) NOT NULL,
    ANHO_FABRICACION NUMBER (4) NOT NULL,
    CANT_PASA_SENT NUMBER (3) NOT NULL,
    CANT_PASA_PAR NUMBER (3) NOT NULL,
    ES_CONVENCIONAL VARCHAR2 (1) NOT NULL
)TABLESPACE BASED2TP;

CREATE TABLE L_COCHE (
    NUM_COCHE NUMBER (8) NOT NULL,
    CHAPA VARCHAR2 (12) NOT NULL,
    NRO_CHASIS VARCHAR2 (30) NOT NULL,
    FEC_ADQUISICION DATE NOT NULL,
    PRECIO_COMPRA NUMBER (15) NOT NULL,
    KILOMETRAJE NUMBER (8) NOT NULL,
    ULT_MANTENIMIENTO DATE NOT NULL,
    TIENE_SEGURO VARCHAR2 (1) NOT NULL,
    ESTADO VARCHAR2 (1) NOT NULL,
    FOTO BLOB NOT NULL,
    ID_MODELO NUMBER (6) NOT NULL,
    ID_MARCA NUMBER (5) NOT NULL
)TABLESPACE BASED2TP;

CREATE TABLE T_ORDEN_TRABAJO (
    COD_OT NUMBER (10) NOT NULL,
    FEC_INI_PRE DATE NOT NULL,
    FEC_FIN_PRE DATE NOT NULL,
    FEC_INI_REL DATE,
    FEC_FIN_REL DATE,
    TIPO VARCHAR2 (1) NOT NULL,
    ESTADO VARCHAR2 (1) DEFAULT ('P') NOT NULL,
    NUM_COCHE NUMBER (8) NOT NULL,
    OBSERVACION VARCHAR2 (500)
)TABLESPACE BASED2TP;

CREATE TABLE F_TIMBRADO (
    NRO_TIMBRADO NUMBER (12) NOT NULL,
    FEC_AUTORIZACION DATE NOT NULL,
    VALIDO_HASTA DATE NOT NULL,
    ESTABLECIMIENTO NUMBER (3) NOT NULL,
    EMISION NUMBER (3) NOT NULL,
    NRO_DESDE NUMBER (7) NOT NULL,
    NRO_HASTA NUMBER (7) NOT NULL,
    ULT_NUM_UTILIZADA NUMBER (7) NOT NULL,
    NUM_COCHE NUMBER (8) NOT NULL
)TABLESPACE BASED2TP;

CREATE TABLE F_BOLETOSXLOTE (
    ID_LOTE NUMBER (12) NOT NULL,
    NRO_TIMBRADO NUMBER (12) NOT NULL,
    FEC_ENTREGA DATE DEFAULT SYSDATE NOT NULL,
    NUM_BOLETO_D NUMBER (7) NOT NULL,
    NUM_BOLETO_H NUMBER (7) NOT NULL
)TABLESPACE BASED2TP;

CREATE TABLE F_REDONDO (
    ID_REDONDO NUMBER (15) NOT NULL,
    FECHA DATE NOT NULL,
    HORA_SALIDA VARCHAR2 (5) NOT NULL,
    HORA_LLEGADA VARCHAR2 (5),
    COD_CHOFER NUMBER (8) NOT NULL,
    NUM_COCHE NUMBER (8) NOT NULL,
    CANT_BOL_VEND NUMBER (7) NOT NULL,
    COMPLETADO VARCHAR2 (1),
    ID_MOTIVO NUMBER (5),
    COD_TRAMO NUMBER (5) NOT NULL,
    ID_LOTE NUMBER (12) NOT NULL
)TABLESPACE BASED2TP;

CREATE TABLE G_BARRIO (
    COD_BARRIO NUMBER (5) GENERATED ALWAYS AS IDENTITY 
        START WITH 1
        MINVALUE 1
        MAXVALUE 999999
        INCREMENT BY 1 NOCACHE NOCYCLE NOT NULL,
    NOMBRE VARCHAR2 (40) NOT NULL,
    CANT_HABITANTES NUMBER (8) NOT NULL
)TABLESPACE BASED2TP;

CREATE TABLE G_TRAMO (
    COD_TRAMO NUMBER (5) NOT NULL,
    NOMBRE VARCHAR2 (40) NOT NULL 
)TABLESPACE BASED2TP;

CREATE TABLE G_TRAMOXBARRIO (
    COD_TRAMO NUMBER (5) NOT NULL,
    COD_BARRIO NUMBER (5) NOT NULL
)TABLESPACE BASED2TP;

CREATE TABLE G_MOTIVO (
    ID_MOTIVO NUMBER (5) GENERATED ALWAYS AS IDENTITY 
        START WITH 1
        MINVALUE 1
        MAXVALUE 999999
        INCREMENT BY 1 NOCACHE NOCYCLE NOT NULL,
    DESCRIPCION VARCHAR2 (40) NOT NULL,
    ESTADO VARCHAR2 (1) NOT NULL
)TABLESPACE BASED2TP;

CREATE TABLE G_EMPLEADO (
    COD_EMPL NUMBER (8) NOT NULL,
    CI VARCHAR2 (15) NOT NULL,
    RUC VARCHAR2 (20),
    PRIMER_NOMBRE VARCHAR2 (15) NOT NULL,
    SEG_NOMBRE VARCHAR2 (15),
    PRIMER_APELL VARCHAR2 (15) NOT NULL,
    SEG_APELL VARCHAR2 (15),
    SEXO VARCHAR2 (1) NOT NULL,
    FEC_NACIMIENTO DATE NOT NULL,
    FEC_INGRESO DATE NOT NULL,
    FECHA_SALIDA DATE,
    TIPO_EMPLEADO VARCHAR2 (1) NOT NULL,
    NRO_REG_CONDUCIR VARCHAR2 (20)
)TABLESPACE BASED2TP;

CREATE TABLE T_ACTIVIDAD (
    COD_ACTIV NUMBER (5) GENERATED ALWAYS AS IDENTITY 
        START WITH 1
        MINVALUE 1
        MAXVALUE 999999
        INCREMENT BY 1 NOCACHE NOCYCLE NOT NULL,
    DESCRIPCION  VARCHAR2 (500) NOT NULL,
    HS_MIN_ASIGNADAS NUMBER (4,1) NOT NULL
)TABLESPACE BASED2TP;

CREATE TABLE T_REPUESTO (
    ID_REPUESTO NUMBER (8) NOT NULL,
    NOMBRE_LARGO VARCHAR2 (100) NOT NULL,
    NOMBRE_ABREV VARCHAR2 (30),
    UM VARCHAR2 (5) NOT NULL,
    ULT_COSTO_COMP NUMBER (10) NOT NULL
)TABLESPACE BASED2TP;

CREATE TABLE T_DEPOSITO (
    ID_DEPOSITO NUMBER (5) NOT NULL,
    DESCRIPCION VARCHAR2 (50) NOT NULL
)TABLESPACE BASED2TP;

CREATE TABLE S_REPXDEP (
    ID_REPUESTO NUMBER (8) NOT NULL,
    ID_DEPOSITO NUMBER (5) NOT NULL,
    CANT_ACT_STOCK NUMBER (8) NOT NULL,
    CANT_STK_MIN NUMBER (8) NOT NULL
)TABLESPACE BASED2TP;

CREATE TABLE S_MOVIM_DET (
    COD_MOVIMIENTO NUMBER (10) NOT NULL,
    NRO_ITEM NUMBER (5) NOT NULL,
    TIPO_MOVIM VARCHAR2 (1) NOT NULL,
    CANTIDAD NUMBER (8) NOT NULL,
    COSTO_UNIT NUMBER (10) NOT NULL,
    ID_REPUESTO NUMBER(8) NOT NULL,
    ID_DEPOSITO NUMBER (5) NOT NULL
)TABLESPACE BASED2TP;

CREATE TABLE T_OT_DETALLE (
    COD_OT NUMBER (10) NOT NULL,
    NRO_ITEM NUMBER (5) NOT NULL,
    COD_ACTIV NUMBER (5) NOT NULL,
    HS_INVERTIDAS NUMBER (4,1) NOT NULL,
    COD_MECANICO NUMBER (8) NOT NULL
)TABLESPACE BASED2TP;

CREATE TABLE S_MOVIM_REP (
    COD_MOVIMIENTO NUMBER (10) NOT NULL,
    FEC_OPERACION DATE NOT NULL,
    USUARIO_CARGA VARCHAR2 (128) NOT NULL,
    COD_OT NUMBER (10),
    NRO_ITEM NUMBER (5)
)TABLESPACE BASED2TP;

CREATE TABLE G_PARAMETROS (
    COSTO_PASAJ_CON NUMBER (6) NOT NULL,
    COSTO_PASAJ_DIF NUMBER (6) NOT NULL,
    CANT_RED_DIA NUMBER (4) NOT NULL,
    PAGO_X_REDONDO NUMBER (8) NOT NULL,
    PAGO_MECXHORA NUMBER (8) NOT NULL
)TABLESPACE BASED2TP;

---AGREGAR LOS PK A LAS TABLAS---
ALTER TABLE L_MARCA ADD CONSTRAINT PK_COD_MARCA PRIMARY KEY(ID_MARCA);
ALTER TABLE L_MODELO ADD CONSTRAINT PK_ID_MODELO PRIMARY KEY(ID_MODELO, ID_MARCA);
ALTER TABLE L_COCHE ADD CONSTRAINT PK_NRO_COCHE PRIMARY KEY(NUM_COCHE);
ALTER TABLE T_ORDEN_TRABAJO ADD CONSTRAINT PK_COD_OT PRIMARY KEY(COD_OT);
ALTER TABLE F_TIMBRADO ADD CONSTRAINT PK_COD_TIMBRADO PRIMARY KEY(NRO_TIMBRADO);
ALTER TABLE F_BOLETOSXLOTE ADD CONSTRAINT PK_COD_LOTE PRIMARY KEY(ID_LOTE);
ALTER TABLE F_REDONDO ADD CONSTRAINT PK_COD_REDONDO PRIMARY KEY(ID_REDONDO);
ALTER TABLE G_BARRIO ADD CONSTRAINT PK_COD_BARRIO PRIMARY KEY(COD_BARRIO);
ALTER TABLE G_TRAMO ADD CONSTRAINT PK_COD_TRAMO PRIMARY KEY(COD_TRAMO);
ALTER TABLE G_TRAMOXBARRIO ADD CONSTRAINT PK_COD_TRBARR PRIMARY KEY(COD_TRAMO, COD_BARRIO);
ALTER TABLE G_MOTIVO ADD CONSTRAINT PK_COD_MOTIVO PRIMARY KEY(ID_MOTIVO);
ALTER TABLE G_EMPLEADO ADD CONSTRAINT PK_COD_EMPL PRIMARY KEY(COD_EMPL);
ALTER TABLE T_ACTIVIDAD ADD CONSTRAINT PK_COD_ACTIV PRIMARY KEY(COD_ACTIV);
ALTER TABLE T_REPUESTO ADD CONSTRAINT PK_ID_REPUE PRIMARY KEY(ID_REPUESTO);
ALTER TABLE T_DEPOSITO ADD CONSTRAINT PK_COD_DEP PRIMARY KEY(ID_DEPOSITO);
ALTER TABLE S_REPXDEP ADD CONSTRAINT PK_COD_REPDEP PRIMARY KEY(ID_REPUESTO, ID_DEPOSITO);
ALTER TABLE S_MOVIM_DET ADD CONSTRAINT PK_COD_MOVDET PRIMARY KEY(COD_MOVIMIENTO, NRO_ITEM);
ALTER TABLE T_OT_DETALLE ADD CONSTRAINT PK_COD_OTDET PRIMARY KEY(COD_OT, NRO_ITEM);
ALTER TABLE S_MOVIM_REP ADD CONSTRAINT PK_COD_MOV PRIMARY KEY(COD_MOVIMIENTO);

---AGREGAR LOS FK A LAS TABLAS---
ALTER TABLE L_MODELO ADD CONSTRAINT FK_MODELO_MARCA FOREIGN KEY (ID_MARCA) REFERENCES L_MARCA (ID_MARCA);
ALTER TABLE L_COCHE ADD CONSTRAINT FK_COCHE_MODELO FOREIGN KEY (ID_MODELO, ID_MARCA) REFERENCES L_MODELO (ID_MODELO, ID_MARCA);
ALTER TABLE T_ORDEN_TRABAJO ADD CONSTRAINT FK_ORDEN_TRABAJO_COCHE FOREIGN KEY (NUM_COCHE) REFERENCES L_COCHE (NUM_COCHE);
ALTER TABLE F_TIMBRADO ADD CONSTRAINT FK_TIMBRADO_COCHE FOREIGN KEY (NUM_COCHE) REFERENCES L_COCHE(NUM_COCHE);
ALTER TABLE F_BOLETOSXLOTE ADD CONSTRAINT FK_BOLETOSXLOTE_TIMBRADO FOREIGN KEY (NRO_TIMBRADO) REFERENCES F_TIMBRADO (NRO_TIMBRADO);
ALTER TABLE F_REDONDO ADD CONSTRAINT FK_REDONDO_COCHE FOREIGN KEY (NUM_COCHE) REFERENCES L_COCHE (NUM_COCHE);
ALTER TABLE F_REDONDO ADD CONSTRAINT FK_REDONDO_BOLETO FOREIGN KEY (ID_LOTE) REFERENCES F_BOLETOSXLOTE (ID_LOTE);
ALTER TABLE F_REDONDO ADD CONSTRAINT FK_REDONDO_TRAMO FOREIGN KEY (COD_TRAMO) REFERENCES G_TRAMO (COD_TRAMO);
ALTER TABLE F_REDONDO ADD CONSTRAINT FK_REDONDO_MOTIVO FOREIGN KEY (ID_MOTIVO) REFERENCES G_MOTIVO (ID_MOTIVO);
ALTER TABLE F_REDONDO ADD CONSTRAINT FK_REDONDO_EMPLEADO FOREIGN KEY (COD_CHOFER) REFERENCES G_EMPLEADO (COD_EMPL);
ALTER TABLE S_MOVIM_REP ADD CONSTRAINT FK_MOVIM_REP_DETALLE FOREIGN KEY (COD_OT, NRO_ITEM) REFERENCES T_OT_DETALLE (COD_OT, NRO_ITEM);
ALTER TABLE T_OT_DETALLE ADD CONSTRAINT FK_DETALLE_ORDEN_TRABAJO FOREIGN KEY (COD_OT) REFERENCES T_ORDEN_TRABAJO (COD_OT);
ALTER TABLE T_OT_DETALLE ADD CONSTRAINT FK_DETALLE_EMPLEADO FOREIGN KEY (COD_MECANICO) REFERENCES G_EMPLEADO (COD_EMPL);
ALTER TABLE T_OT_DETALLE ADD CONSTRAINT FK_DETALLE_ACTIVIDAD FOREIGN KEY (COD_ACTIV) REFERENCES T_ACTIVIDAD (COD_ACTIV);
ALTER TABLE G_TRAMOXBARRIO ADD CONSTRAINT FK_TRAMOXBARRIO_TRAMO FOREIGN KEY (COD_TRAMO) REFERENCES G_TRAMO (COD_TRAMO);
ALTER TABLE G_TRAMOXBARRIO ADD CONSTRAINT FK_TRAMOXBARRIO_BARRIO FOREIGN KEY (COD_BARRIO) REFERENCES G_BARRIO (COD_BARRIO);
ALTER TABLE S_MOVIM_DET ADD CONSTRAINT FK_MOVIM_DET_MOVIM_REP FOREIGN KEY (COD_MOVIMIENTO) REFERENCES S_MOVIM_REP (COD_MOVIMIENTO);
ALTER TABLE S_MOVIM_DET ADD CONSTRAINT FK_MOVIM_DET_REPXDEP FOREIGN KEY (ID_REPUESTO, ID_DEPOSITO) REFERENCES S_REPXDEP (ID_REPUESTO, ID_DEPOSITO);
ALTER TABLE S_REPXDEP ADD CONSTRAINT FK_REPXDEP_DEPOSITO FOREIGN KEY (ID_DEPOSITO) REFERENCES T_DEPOSITO (ID_DEPOSITO);
ALTER TABLE S_REPXDEP ADD CONSTRAINT FK_REPXDEP_REPUESTO FOREIGN KEY (ID_REPUESTO) REFERENCES T_REPUESTO (ID_REPUESTO);


---AGREGAR LOS CHECKS---
ALTER TABLE F_TIMBRADO ADD CONSTRAINT CK_DIF_MESES_FECHAS CHECK (MONTHS_BETWEEN(VALIDO_HASTA, FEC_AUTORIZACION) = 12);
ALTER TABLE F_TIMBRADO ADD CONSTRAINT CK_NUM_MAYOR_HASTA CHECK (NRO_HASTA > NRO_DESDE);
ALTER TABLE S_MOVIM_DET ADD CONSTRAINT CK_TIPO_MOVIM CHECK (TIPO_MOVIM IN('E','S'));
ALTER TABLE T_ORDEN_TRABAJO ADD CONSTRAINT CK_ESTADO CHECK (ESTADO IN ('P','C','E','X','T'));
ALTER TABLE T_ORDEN_TRABAJO ADD CONSTRAINT CK_ESTADO_E CHECK ((ESTADO = 'E' AND FEC_INI_REL IS NOT NULL) OR (ESTADO IN ('P','C','X','T') AND FEC_INI_REL IS NULL));
ALTER TABLE T_ORDEN_TRABAJO ADD CONSTRAINT CK_ESTADO_T CHECK (ESTADO = 'T' AND FEC_FIN_REL IS NOT NULL);
ALTER TABLE F_REDONDO ADD CONSTRAINT CK_COMPLETADO CHECK (COMPLETADO = 'N' AND ID_MOTIVO IS NOT NULL );
-- ALTER TABLE F_REDONDO ADD CONSTRAINT CK_HORASAL_HORALLEG CHECK ();
--ALTER TABLE L_COCHE ADD CONSTRAINT ....----
