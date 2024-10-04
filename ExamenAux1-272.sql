--Ejer2

SELECT entidad.nombre, (empleado.nombre || ' ' || empleado.paterno|| ' ' || empleado.materno) as empleado
FROM entidad, trabaja, empleado
WHERE entidad.codent=trabaja.codent AND trabaja.codemp=empleado.codemp;

--Ejer3

SELECT entidad.nombre, (empleado.nombre || ' ' || empleado.paterno|| ' ' || empleado.materno) as empleado, xp.fechaini, xp.fechafin, cargo.nombre
FROM entidad, experienciatrabajo xp, empleado, cargo
WHERE entidad.codent = xp.codent AND xp.codemp=empleado.codemp AND xp.codcar=cargo.codcar


--Ejer4

SELECT (empleado.nombre || ' ' || empleado.paterno|| ' ' || empleado.materno) as empleado, (2024-EXTRACT(YEAR FROM fechanacimiento)) as edad
FROM empleado
WHERE 2024-EXTRACT(YEAR FROM fechanacimiento) BETWEEN 50 AND 55;


--Ejer5

UPDATE empleado
SET nombre = UPPER(SUBSTR(nombre, 0, 1)) || LOWER(SUBSTR(nombre, 2)), paterno = UPPER(SUBSTR(paterno, 0, 1)) || LOWER(SUBSTR(paterno, 2)), materno = UPPER(SUBSTR(materno, 0, 1)) || LOWER(SUBSTR(materno, 2));

SELECT empleado.*
FROM empleado


--Reset
UPDATE empleado
SET nombre = LOWER(nombre), paterno = LOWER(paterno), materno=(LOWER(materno));

SELECT empleado.*
FROM empleado

--Alternative
UPDATE empleado
SET nombre=INITCAP(nombre), paterno=INITCAP(paterno), materno=INITCAP(materno);

SELECT *
FROM empleado