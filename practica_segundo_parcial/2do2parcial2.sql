CREATE OR REPLACE TYPE T_CEDULAS IS TABLE OF NUMBER(11);
/
CREATE OR REPLACE PACKAGE PCK_JUECES AS
    FUNCTION F_VALIDAR_JUECES(P_CEDULA NUMBER, P_ID_SUMARIO NUMBER) RETURN NUMBER;
    FUNCTION F_CALCULAR_VENCIMIENTO(P_FECHA_INICIO DATE, P_CANT_DIAS NUMBER) RETURN DATE;
    PROCEDURE P_SELECCIONAR_CANDIDATOS(P_ID_SUMARIO NUMBER);
END;
/
CREATE OR REPLACE PACKAGE BODY PCK_JUECES IS
    FUNCTION F_VALIDAR_JUECES(P_CEDULA NUMBER, P_ID_SUMARIO NUMBER) RETURN NUMBER IS
    V_ABOGADO REGISTRO_DE_ABOGADOS%ROWTYPE;
    V_SUMARIO SUMARIO%ROWTYPE;
    V_PERMISO_ABOGADO NUMBER;
    V_ABOGADO_JUEZ_TITULAR NUMBER;
    BEGIN
        SELECT * INTO V_ABOGADO FROM REGISTRO_DE_ABOGADOS rda
        WHERE rda.CEDULA = P_CEDULA;

        SELECT * INTO V_SUMARIO FROM SUMARIO s 
        WHERE s.ID_SUMARIO = P_ID_SUMARIO;

        SELECT COUNT(*) INTO V_PERMISO_ABOGADO
        FROM PERMISOS p 
        WHERE p.CEDULA = P_CEDULA 
        AND (p.FECHA_INI + p.DIAS_PERMISO) >= V_SUMARIO.FECHA_INICIO_EFECTIVO;

        IF V_PERMISO_ABOGADO >= 1 THEN
            RETURN 0;
        END IF;

        SELECT COUNT(*) INTO V_ABOGADO_JUEZ_TITULAR
        FROM JUECES j JOIN SUMARIO s ON j.ID_SUMARIO = s.ID_SUMARIO
        WHERE j.CEDULA = P_CEDULA AND j.TITULAR_SUPLENTE = 'TI' AND s.FECHA_FIN IS NULL;

        IF V_ABOGADO_JUEZ_TITULAR >= 1 THEN
            RETURN 0;
        END IF;

        IF V_ABOGADO.FECHA_BAJA IS NOT NULL THEN
            RETURN 0;
        END IF;

        RETURN 1;
    END;
    FUNCTION F_CALCULAR_VENCIMIENTO(P_FECHA_INICIO DATE, P_CANT_DIAS NUMBER) RETURN DATE IS
    V_FECHA_VENCIMIENTO DATE;
    DIAS NUMBER := 1;
    V_FECHA_AUX DATE;
    V_FECHA_FERIADO NUMBER;
    V_DIA_SEMANA NUMBER(2);
    BEGIN
        V_FECHA_VENCIMIENTO := P_FECHA_INICIO;
        WHILE DIAS < P_CANT_DIAS LOOP
            SELECT COUNT(*) INTO V_FECHA_FERIADO FROM FERIADOS f WHERE TRUNC(f.DIA_FERIADO) = TRUNC(V_FECHA_VENCIMIENTO);
            V_DIA_SEMANA := TO_NUMBER(TO_CHAR(V_FECHA_VENCIMIENTO, 'D'));
            IF V_DIA_SEMANA > 5 AND V_FECHA_FERIADO = 0 THEN
                DIAS := DIAS+1;
            END IF;
            V_FECHA_VENCIMIENTO := V_FECHA_VENCIMIENTO + 1;
        END LOOP;
        RETURN V_FECHA_VENCIMIENTO;
    END;
       
    PROCEDURE P_SELECCIONAR_CANDIDATOS(P_ID_SUMARIO NUMBER) IS
    V_CEDULAS T_CEDULAS := T_CEDULAS();
    CURSOR C_CEDULAS_VALIDAS IS 
        SELECT rda.CEDULA FROM REGISTRO_DE_ABOGADOS rda 
        WHERE PCK_JUECES.F_VALIDAR_JUECES(rda.CEDULA, P_ID_SUMARIO) = 1;
    IND NUMBER(2) := 1;
    V_CEDULA_TITULAR NUMBER(11);
    V_CEDULA_PRIMER_SUPLENTE NUMBER(11);
    V_CEDULA_SEGUNDO_SUPLENTE NUMBER(11);
    
    BEGIN
        FOR CED IN C_CEDULAS_VALIDAS LOOP
            V_CEDULAS.EXTEND;
            V_CEDULAS(IND) := CED.CEDULA;
            IND := IND + 1;
        END LOOP;

        V_CEDULA_TITULAR := V_CEDULAS(ROUND(DBMS_RANDOM.VALUE(1, IND)));
        V_CEDULA_PRIMER_SUPLENTE := V_CEDULAS(ROUND(DBMS_RANDOM.VALUE(1, IND)));
        WHILE V_CEDULA_PRIMER_SUPLENTE = V_CEDULA_TITULAR LOOP
            V_CEDULA_PRIMER_SUPLENTE := V_CEDULAS(ROUND(DBMS_RANDOM.VALUE(1, IND)));
        END LOOP;
        
        V_CEDULA_SEGUNDO_SUPLENTE := V_CEDULAS(ROUND(DBMS_RANDOM.VALUE(1, IND)));
        WHILE V_CEDULA_SEGUNDO_SUPLENTE = V_CEDULA_TITULAR OR V_CEDULA_SEGUNDO_SUPLENTE = V_CEDULA_PRIMER_SUPLENTE LOOP
            V_CEDULA_SEGUNDO_SUPLENTE := V_CEDULAS(ROUND(DBMS_RANDOM.VALUE(1, IND)));
        END LOOP;

        INSERT INTO JUECES (CEDULA, ID_SUMARIO, TITULAR_SUPLENTE) VALUES (V_CEDULA_TITULAR, P_ID_SUMARIO, 'TI');
        INSERT INTO JUECES (CEDULA, ID_SUMARIO, TITULAR_SUPLENTE) VALUES (V_CEDULA_PRIMER_SUPLENTE, P_ID_SUMARIO, 'S1');
        INSERT INTO JUECES (CEDULA, ID_SUMARIO, TITULAR_SUPLENTE) VALUES (V_CEDULA_SEGUNDO_SUPLENTE, P_ID_SUMARIO, 'S2');
    END;
END PCK_JUECES;
/