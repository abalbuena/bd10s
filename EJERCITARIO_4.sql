-- EJERCITARIO 4.

-- Ejercicio 1.
--Inserte una nueva área denominada “Auditoría” con el ID igual al último más 1, que dependerá del
--ID perteneciente a la “Gerencia Administrativa”.

INSERT INTO B_AREAS 
(ID, NOMBRE_AREA, FECHA_CREA, ACTIVA, ID_AREA_SUPERIOR)
VALUES 
((SELECT MAX(a.ID)+1 FROM B_AREAS a),
'Auditoria',
SYSDATE,
'S',
(SELECT a.ID
 FROM B_AREAS a
 WHERE a.NOMBRE_AREA = 'Gerencia Administrativa'));

-- Ejercicio 2
--2. Inserte el nuevo empleado con los siguientes datos:
-- CEDULA | NOMBRE APELLIDO  | FECHA_ING | FECHA_NACIM | CEDULA_JEFE TELEFONO DIRECCION BARRIO
-- 123568 | MARCIO BALMACEDA | SYSDATE   | 04/02/1970  | La cédula de
-- José Caniza
-- El mismo teléfono, dirección y barrio
-- de su hermano Jose Balmaceda