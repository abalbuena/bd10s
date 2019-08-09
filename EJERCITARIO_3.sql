

-- ejercicio 1
-- 1. El salario de cada empleado está dado por su posición, y la asignación de la categoría vigente
-- en dicha posición. Tanto la posición como la categoría vigente tienen la fecha fin nula – Un
-- solo salario está vigente en un momento dado). Tomando como base la lista de empleados,
-- verifique cuál es el salario máximo, el mínimo y el promedio. Formatee la salida para que se
-- muestren los puntos de mil.
-- TODO FORMATEAR CORRECTAMENTE.
SELECT MAX(cs.ASIGNACION) AS MAXIMO, MIN(cs.ASIGNACION) AS MINIMO, AVG(cs.ASIGNACION) AS PROMEDIO  
FROM B_POSICION_ACTUAL pa
JOIN B_CATEGORIAS_SALARIALES cs ON pa.COD_CATEGORIA = cs.COD_CATEGORIA
WHERE pa.FECHA_FIN IS NULL AND cs.FECHA_FIN IS NULL;

-- ejercicio 2
-- Basado en la consulta anterior, determine la mayor y menor asignación en cada área. Su
-- consulta tendrá: Nombre de área, Asignación Máxima, Asignación Mínima.

SELECT MAX(cs.ASIGNACION) AS MAXIMO, MIN(cs.ASIGNACION) AS MINIMO, AVG(cs.ASIGNACION) AS PROMEDIO  
FROM B_POSICION_ACTUAL pa
JOIN B_CATEGORIAS_SALARIALES cs ON pa.COD_CATEGORIA = cs.COD_CATEGORIA
WHERE pa.FECHA_FIN IS NULL AND cs.FECHA_FIN IS NULL;

-- ejercicio 3.a
-- Determine el nombre y apellido, nombre de categoría, asignación y área del empleado (o
-- empleados) que tienen la máxima asignación vigente. Pruebe con un subquery normal, y luego

SELECT e.NOMBRE ||' '||e.APELLIDO, cs.NOMBRE_CAT, cs.ASIGNACION, a.NOMBRE_AREA
FROM B_POSICION_ACTUAL pa
JOIN B_CATEGORIAS_SALARIALES cs ON pa.COD_CATEGORIA = cs.COD_CATEGORIA
JOIN B_EMPLEADOS e ON pa.CEDULA = pa.CEDULA
JOIN B_AREAS a ON pa.ID_AREA = a.ID
WHERE cs.ASIGNACION = 
	(SELECT MAX(cs.ASIGNACION) FROM B_POSICION_ACTUAL pa 
	 JOIN B_CATEGORIAS_SALARIALES cs ON pa.COD_CATEGORIA = cs.COD_CATEGORIA
	 WHERE cs.FECHA_FIN IS NULL AND pa.FECHA_FIN IS NULL);
	 
-- ejercicio 3.b
WITH salarios AS 
	(SELECT cs.ASIGNACION FROM B_POSICION_ACTUAL pa 
	JOIN B_CATEGORIAS_SALARIALES cs ON pa.COD_CATEGORIA = cs.COD_CATEGORIA
	WHERE cs.FECHA_FIN IS NULL AND pa.FECHA_FIN IS NULL)
SELECT e.NOMBRE ||' '||e.APELLIDO, cs.NOMBRE_CAT, cs.ASIGNACION, a.NOMBRE_AREA
FROM B_POSICION_ACTUAL pa
JOIN B_CATEGORIAS_SALARIALES cs ON pa.COD_CATEGORIA = cs.COD_CATEGORIA
JOIN B_EMPLEADOS e ON pa.CEDULA = pa.CEDULA
JOIN B_AREAS a ON pa.ID_AREA = a.ID	
WHERE cs.ASIGNACION = (SELECT MAX(s.ASIGNACION) FROM salarios s);


-- ejercicio 4.a
-- . Determine el nombre y apellido, nombre de categoría, asignación y área del empleado (o
-- empleados) que tienen una asignación INFERIOR al promedio. Ordene por monto de salario en
-- forma DESCENDENTE. Intente la misma consulta con y sin WITH.

WITH salarios_actuales AS 
	(SELECT cs.ASIGNACION FROM B_POSICION_ACTUAL pa 
	 JOIN B_CATEGORIAS_SALARIALES cs ON pa.COD_CATEGORIA = cs.COD_CATEGORIA
	 WHERE cs.FECHA_FIN IS NULL AND pa.FECHA_FIN IS NULL)
SELECT 
e.NOMBRE ||' '||e.APELLIDO AS NOMBRE_APELLIDO,
cs.NOMBRE_CAT,
cs.ASIGNACION,
a.NOMBRE_AREA
FROM B_POSICION_ACTUAL pa
JOIN B_CATEGORIAS_SALARIALES cs ON pa.COD_CATEGORIA = cs.COD_CATEGORIA
JOIN B_EMPLEADOS e ON pa.CEDULA = pa.CEDULA
JOIN B_AREAS a ON pa.ID_AREA = a.ID
WHERE cs.ASIGNACION < (SELECT AVG(s.ASIGNACION) FROM salarios_actuales s);

-- ejercicio 4.b
--sin WITH.
SELECT 
e.NOMBRE ||' '||e.APELLIDO AS NOMBRE_APELLIDO,
cs.NOMBRE_CAT,
cs.ASIGNACION,
a.NOMBRE_AREA
FROM B_POSICION_ACTUAL pa
JOIN B_CATEGORIAS_SALARIALES cs ON pa.COD_CATEGORIA = cs.COD_CATEGORIA
JOIN B_EMPLEADOS e ON pa.CEDULA = pa.CEDULA
JOIN B_AREAS a ON pa.ID_AREA = a.ID
WHERE cs.ASIGNACION < (SELECT AVG(cs.ASIGNACION) FROM B_POSICION_ACTUAL pa 
	 JOIN B_CATEGORIAS_SALARIALES cs ON pa.COD_CATEGORIA = cs.COD_CATEGORIA
	 WHERE cs.FECHA_FIN IS NULL AND pa.FECHA_FIN IS NULL);

-- Ejercicio 5.
-- Se necesita saber la cantidad de clientes que hay por cada localidad (Tenga en cuenta en la tabla
-- B_PERSONAS sólo aquellas que son clientes). Liste el id, la descripción de la localidad y la
-- cantidad de clientes. Asegúrese que se listen también las localidades que NO tienen clientes.

SELECT * FROM B_PERSONAS p 
GROUP BY 
WHERE p.ES_CLIENTE = 'S';

-- Ejercicio 7:
-- 7. Para tener una idea de movimientos, se desea conocer el volumen (cantidad) de ventas por mes
-- que se hicieron por cada artículo durante el año 2012. Debe listar también los artículos que no
-- tuvieron movimiento. La consulta debe lucir así:
-- | Nombre | Artículo | Ene | Feb | Mar | Abr | May | Jun | Jul | Ago | Sep | Oct | Nov | Dic
WITH ven AS 
(SELECT d.ID_ARTICULO,
 EXTRACT(MONTH FROM v.FECHA) AS MES,
 SUM(d.CANTIDAD)
FROM B_DETALLE_VENTAS d JOIN B_VENTAS v ON d.ID_VENTA = v.ID
WHERE EXTRACT(YEAR FROM v.FECHA) = 2018
GROUP BY d.ID_ARTICULO, EXTRACT(MONTH FROM v.FECHA))
SELECT 
a.ID,
a.NOMBRE, 
DECODE(MES, 1, CANTIDAD, 0) ENE,
DECODE(MES, 2, CANTIDAD, 0) FEB,
DECODE(MES, 3, CANTIDAD, 0) MAR,
DECODE(MES, 4, CANTIDAD, 0) ABR,
DECODE(MES, 5, CANTIDAD, 0) MAY,
DECODE(MES, 6, CANTIDAD, 0) JUN,
DECODE(MES, 7, CANTIDAD, 0) JUL,
DECODE(MES, 8, CANTIDAD, 0) AGO,
DECODE(MES, 9, CANTIDAD, 0) SEP,
DECODE(MES, 10, CANTIDAD, 0) OCT,
DECODE(MES, 11, CANTIDAD, 0) NOV,
DECODE(MES, 12, CANTIDAD, 0) DIC
FROM B_ARTICULOS a LEFT OUTER JOIN ven
ON a.ID = ven.ID_ARTICULO;

