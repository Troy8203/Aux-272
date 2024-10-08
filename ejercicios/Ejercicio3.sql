CREATE OR REPLACE FUNCTION montoVendido_x_sucursal(xidsuc IN number) RETURN NUMBER
IS
    xmonto NUMBER;
BEGIN
    SELECT SUM(monto) INTO xmonto
    FROM (SELECT DISTINCT idsuc,nropedido,monto_x_pedido(nropedido) monto
    FROM detalle_pedido WHERE idsuc=xidsuc) TMP;

    RETURN NVL(xmonto, 0);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 0;
END montoVendido_x_sucursal;

CREATE OR REPLACE FUNCTION emple_joven_x_Sucursal(xidsuc IN number) RETURN VARCHAR
IS
    xname VARCHAR(100);
BEGIN
    log('Getting Name');
    SELECT (apepaterno || ' ' || apematerno || ' ' || persona.nombre) name INTO xname
    FROM persona, empleado
    WHERE fechanaci=(SELECT MIN(fechanaci) FROM persona, empleado WHERE ci=ciempleado AND idsuc = xidsuc) AND ci=ciempleado AND idsuc = xidsuc;
    log('Returning Name');
    RETURN xname;
END emple_joven_x_Sucursal;

-- Solucion

-- Este codigo muestra la cantidad de ventas realizadas en cada sucursal y la cantidad de empleados jovenes que trabajan en cada una de ellas.

SELECT idsuc, montoVendido_x_Sucursal(idsuc) Monto_Vendido, emple_joven_x_Sucursal(idsuc) Emple_Joven
FROM sucursal