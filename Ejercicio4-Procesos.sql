-- *1)
-- !main procedure 1)

CREATE OR REPLACE PROCEDURE p1_datos_sucursal (
    xidsucursal IN NUMBER, xdireccion OUT VARCHAR2, xgerente OUT VARCHAR2)
IS
BEGIN
    SELECT direccion INTO xdireccion
    FROM sucursal
    WHERE idsuc=xidsucursal;

    SELECT obtap_nom(cigerente) INTO xgerente
    FROM sucursal
    WHERE idsuc=xidsucursal;
END p1_datos_sucursal;

-- *execute procedure
DECLARE
    xidsucursal number;
    xdireccion varchar2(150);
    xnom_gerente varchar2(150);
    xjoven varchar2(150);
BEGIN
    xidsucursal := 10;
    p1_datos_sucursal (xidsucursal, xdireccion, xnom_gerente);
    SELECT Emple_joven_x_Sucursal(xidsucursal) INTO Xjoven
    FROM dual;
    dbms_output.put_line('Id Sucursal : '||xidsucursal);
    dbms_output.put_line(' Direccion: '||xdireccion);
    dbms_output.put_line(' Gerente : '||xnom_gerente);
    dbms_output.put_line(' Empleado más joven : '||xnom_gerente);
END;

-- *2)

CREATE OR REPLACE FUNCTION f1_ci_pedido (xnropedido IN NUMBER) RETURN NUMBER
IS
    xci NUMBER;
BEGIN
    SELECT cicliente INTO xci
    FROM pedido
    WHERE nropedido=xnropedido;
    RETURN xci;
END f1_ci_pedido;

CREATE OR REPLACE FUNCTION full_name (xci IN NUMBER) RETURN VARCHAR
IS
    name VARCHAR(100);
BEGIN
    SELECT apepaterno || ' ' || apematerno || ' ' || persona.nombre INTO name
    FROM persona
    WHERE ci=xci;
    RETURN name;
END full_name;

CREATE OR REPLACE FUNCTION f2_nombre_pedido(xnropedido IN NUMBER) RETURN VARCHAR
IS
    xnombre VARCHAR(100);
BEGIN
    SELECT full_name(ci) INTO xnombre
    FROM pedido, persona
    WHERE cicliente=ci AND nropedido=xnropedido;
    RETURN xnombre;
END f2_nombre_pedido;

-- !main procedure 2)

CREATE OR REPLACE PROCEDURE p1_resumen_pedido (
    xnropedido IN NUMBER,
    xcicliente OUT NUMBER,
    xnombrecli OUT VARCHAR2,
    xfecha OUT DATE,
    xmontoTotal OUT NUMBER
)
IS
BEGIN
    SELECT f1_ci_pedido(xnropedido) INTO xcicliente
    FROM pedido
    WHERE nropedido=xnropedido;

    SELECT f2_nombre_pedido(xnropedido) INTO xnombrecli
    FROM pedido
    WHERE nropedido=xnropedido;

    SELECT fecha INTO xfecha
    FROM pedido
    WHERE nropedido=xnropedido;

    SELECT monto_x_pedido(xnropedido) INTO xmontoTotal
    FROM pedido
    WHERE nropedido=xnropedido;

    EXCEPTION
        WHEN no_data_found THEN
            xnombrecli:= 'E R R O R !!!! ';
            xcicliente:= 0;
            xfecha:= sysdate;
            xmontoTotal:= 0;
END;

--excecute

DECLARE
    xnropedido number;
    xcicliente NUMBER;
    xnombrecli varchar2(150);
    xfecha DATE;
    xmontoTotal NUMBER;
BEGIN
    xnropedido := 7;
    p1_resumen_pedido(xnropedido, xcicliente, xnombrecli, xfecha, xmontoTotal);
    dbms_output.put_line('Nro pedido: '||xidsucursal||' fecha: '||xfecha);
    dbms_output.put_line(' ci: '||xdireccion);
    dbms_output.put_line(' Cliente: '||xnom_gerente);
    dbms_output.put_line(' Total : '||xnom_gerente);
END;