1)

CREATE OR REPLACE FUNCTION F_Edad(fecha1 IN DATE) RETURN NUMBER
IS
    edad NUMBER;
BEGIN
    edad := EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM fecha1);
    RETURN edad;
END F_Edad;

SELECT F_Edad(TO_DATE('2010-10-26', 'YYYY-MM-DD')) F_edad FROM dual;

Select cp.apePaterno, cp.apeMaterno, cp.nombre, F_Edad (cp.fechanaci) edad
From Empleado ce, Persona cp
Where cp.ci = ce.ciempleado
Order By cp.apePaterno

2)

CREATE OR REPLACE FUNCTION nroproductos_x_sucursal(xidsuc IN NUMBER) RETURN NUMBER
IS
    xcantidad NUMBER;
BEGIN
    SELECT COUNT(*) INTO xcantidad
    FROM se_sirve
    WHERE idsuc = xidsuc;
    RETURN xcantidad;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END nroproductos_x_sucursal;


SELECT idsuc, direccion, NVL(nroproductos_x_sucursal (idsuc),0) NroProductos
FROM sucursal
ORDER BY idsuc

3)

CREATE OR REPLACE FUNCTION obtap_nom (xci IN NUMBER) RETURN VARCHAR
IS
    name VARCHAR(100);
BEGIN
    SELECT apepaterno || ' ' || apematerno || ' ' || persona.nombre INTO name
    FROM sucursal, persona
    WHERE cigerente=ci AND ci=xci;
    RETURN name;
END obtap_nom;