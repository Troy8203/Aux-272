1)

CREATE OR REPLACE FUNCTION nroemple_x_sucursal(xidsuc IN number, IvSw IN number) RETURN NUMBER
IS
    cant NUMBER;
BEGIN
    IF IvSw = 0 THEN
        SELECT COUNT(*)
        INTO cant
        FROM (SELECT * FROM sucursal, empleado, persona
            WHERE sucursal.idsuc = empleado.idsuc AND ciempleado=ci AND sexo LIKE 'Femenino' AND sucursal.idsuc=xidsuc) TMP;
    ELSIF IvSw = 1 THEN
        SELECT COUNT(*)
        INTO cant
        FROM (SELECT * FROM sucursal, empleado, persona
            WHERE sucursal.idsuc = empleado.idsuc AND ciempleado=ci AND sexo LIKE 'Masculino' AND sucursal.idsuc=xidsuc) TMP;
    ELSIF IvSw = 2 THEN
        SELECT COUNT(*)
        INTO cant
        FROM (SELECT * FROM sucursal, empleado, persona
            WHERE sucursal.idsuc = empleado.idsuc AND ciempleado=ci AND sucursal.idsuc=xidsuc) TMP;
    END IF;
    RETURN cant;
END nroemple_x_sucursal;

-- Solucion

SELECT direccion, obtap_nom(cigerente),
    nroemple_x_sucursal (idsuc,0) NroFem,
    nroemple_x_sucursal (idsuc,1) NroMas,
    nroemple_x_sucursal (idsuc,2) Total
FROM sucursal
ORDER BY direccion

2)

CREATE OR REPLACE FUNCTION obtprecio_x_producto (xidprod IN number) RETURN NUMBER
IS
    xprecio NUMBER;
BEGIN
    SELECT costo INTO xprecio
    FROM producto
    WHERE idprod = xidprod;
    RETURN xprecio;
END obtprecio_x_producto;

CREATE OR REPLACE FUNCTION monto_x_pedido(xnropedido IN number) RETURN NUMBER
IS
	xmonto NUMBER;
BEGIN
    SELECT SUM(cantidad*obtprecio_x_producto(idprod)) total INTO xmonto
    FROM detalle_pedido
    WHERE nropedido=xnropedido
    GROUP BY nropedido
    ORDER BY nropedido;

	RETURN xmonto;
END monto_x_pedido;

CREATE OR REPLACE FUNCTION full_name (xci IN NUMBER) RETURN VARCHAR
IS
    name VARCHAR(100);
BEGIN
    SELECT apepaterno || ' ' || apematerno || ' ' || persona.nombre INTO name
    FROM persona
    WHERE ci=xci;
    RETURN name;
END full_name;

-- Solucion
SELECT nropedido, full_name(cicliente) cliente, monto_x_pedido(nropedido) monto_cancelar
FROM pedido