-- *Count how many branches there are

CREATE OR REPLACE FUNCTION nro_cant_prod(xidprod IN NUMBER) RETURN NUMBER
IS
    xcant NUMBER;
BEGIN
    SELECT COUNT(*) as cant INTO xcant
    FROM se_sirve
    WHERE idprod=xidprod;
    RETURN xcant;
END nro_cant_prod;

--* Convert number to varchar

CREATE OR REPLACE FUNCTION number_to_char(p_numero NUMBER) RETURN VARCHAR2
IS
    v_palabra VARCHAR2(255);
BEGIN
    CASE p_numero
        WHEN 0 THEN v_palabra := 'CERO';
        WHEN 1 THEN v_palabra := 'UNO';
        WHEN 2 THEN v_palabra := 'DOS';
        WHEN 3 THEN v_palabra := 'TRES';
        WHEN 4 THEN v_palabra := 'CUATRO';
        WHEN 5 THEN v_palabra := 'CINCO';
        WHEN 6 THEN v_palabra := 'SEIS';
        WHEN 7 THEN v_palabra := 'SIETE';
        WHEN 8 THEN v_palabra := 'OCHO';
        WHEN 9 THEN v_palabra := 'NUEVE';
        WHEN 10 THEN v_palabra := 'DIEZ';
        ELSE v_palabra := 'NUMERO NO VALIDO';
    END CASE;

    RETURN v_palabra;
END number_to_char;

--* How many products are ordered

CREATE OR REPLACE FUNCTION nro_cant_pedido(xidprod IN NUMBER) RETURN NUMBER
IS
    xcant NUMBER;
BEGIN
    SELECT SUM(cantidad) as cant_pedido INTO xcant
    FROM detalle_pedido
    WHERE idprod=xidprod;
    RETURN xcant;
END nro_cant_pedido;

--*PROCEDURE

CREATE OR REPLACE PROCEDURE p_ficha_prod(
    xidprod IN NUMBER,
    xnameprod OUT VARCHAR2,
    xnrosuc OUT VARCHAR,
    xcantped OUT NUMBER
)
IS
BEGIN
    SELECT nombre INTO xnameprod
    FROM producto
    WHERE idprod=xidprod;

    SELECT number_to_char(NVL(nro_cant_prod(idprod),0)) INTO xnrosuc
    FROM producto
    WHERE idprod=xidprod;

    SELECT NVL(nro_cant_pedido(idprod),0) INTO xcantped
    FROM producto
    WHERE idprod=xidprod;

    EXCEPTION
        WHEN no_data_found THEN
            xnameprod := 'ERROR';
            xnrosuc := 'ERROR';
            xcantped := 0;
END;

-- *Executes the procedure

DECLARE
    xidprod NUMBER;
    xnameprod VARCHAR2(100);
    xnrosuc VARCHAR(100);
    xcantped NUMBER;
BEGIN
    xidprod:=171201;
    p_ficha_prod(xidprod, xnameprod, xnrosuc, xcantped);
    dbms_output.put_line('Producto : '||xidprod);
    dbms_output.put_line('Nombre del Producto : '||xnameprod);
    dbms_output.put_line('Numero de sucursales que se sirve el producto : '||xnrosuc);
    dbms_output.put_line('Cantidad Solicitada del producto en los pedidos : '||xcantped);
END;