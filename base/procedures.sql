--BASE
CREATE OR REPLACE PROCEDURE procedure_name (param1 datatype, param2 datatype)
IS
BEGIN
    -- cuerpo del procedimientos
END procedure_name;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('No data found');
            param1 := value_default;
            param2 := value_default;

----EJEMPLO CREAR UN PROCEDIMIENTO QUE MUESTRE EL NOMBRE COMPLETO, EL SALARIO EN DOLARES(USAR LA FUNCION), MOSTRAR EL AÑO DE NACIMIENTO
---QUERY1
SELECT name || ' ' || last_name as complete_name
FROM customer
WHERE id=1
---QUERY2
SELECT convert_to_dolar(id) as dollar
FROM customer
WHERE id=1
--QUERY3
SELECT (EXTRACT(YEAR FROM SYSDATE) - age) AS year_of_birth
FROM customer
WHERE id=1
---CREACION DEL PROCEDIMIENTO
CREATE OR REPLACE PROCEDURE procedure_name 
(xid IN NUMBER, xname OUT VARCHAR2, xdollar OUT NUMBER, xyear OUT NUMBER)
IS
BEGIN
    -- cuerpo del procedimientos
    SELECT name || ' ' || last_name as complete_name INTO xname
        FROM customer
        WHERE id=xid;
    
    SELECT convert_to_dolar(id) as dollar INTO xdollar
        FROM customer
        WHERE id=xid;

    SELECT (EXTRACT(YEAR FROM SYSDATE) - age) AS year_of_birth INTO xyear
        FROM customer
        WHERE id=xid;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('No data found');
            xname := 'No data found';
            xdollar := 0;
            xyear := 0;
END procedure_name;
---EXE EJECUCION DEL PROCEDIMIENTO
DECLARE
    xid NUMBER;
    xname VARCHAR2(50);
    xdollar NUMBER;
    xyear NUMBER;
BEGIN
    xid := 1;
    procedure_name(xid, xname, xdollar, xyear);
    dbms_output.put_line('Nombre completo: '||xname);
    dbms_output.put_line('Salario en Dolares: '||xdollar);
    dbms_output.put_line('Año de nacimiento: '||xyear);
END;