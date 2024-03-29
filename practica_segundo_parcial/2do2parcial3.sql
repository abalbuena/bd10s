CREATE OR REPLACE TRIGGER T_CONTROL_SUMARIO
BEFORE INSERT OR UPDATE
ON SUMARIO
FOR EACH ROW
DECLARE
V_FECHA_LIMITE DATE;
BEGIN
    V_FECHA_LIMITE := PCK_JUECES.F_CALCULAR_VENCIMIENTO(:NEW.FECHA_INICIO_EFECTIVO, 30);
    :NEW.FECHA_LIMITE := V_FECHA_LIMITE;
END;
/
CREATE OR REPLACE TRIGGER T_CONTROL_FECHA_LIMITE
BEFORE INSERT ON SEGUIMIENTO
FOR EACH ROW
DECLARE
    V_FECHA_LIMITE_SUMARIO SUMARIO.FECHA_LIMITE%TYPE;
BEGIN
    SELECT TRUNC(s.FECHA_LIMITE) INTO V_FECHA_LIMITE_SUMARIO FROM SUMARIO s WHERE s.ID_SUMARIO = :new.ID_SUMARIO;

    IF TRUNC(:NEW.FECHA_EVENTO) > V_FECHA_LIMITE_SUMARIO THEN
        RAISE_APPLICATION_ERROR(-20000, 'NO SE PERMITE MODIFICAR');
    END IF;
END;