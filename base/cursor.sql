--BASE
DECLARE
    CURSOR cursor_name IS
        SELECT column1, column2, column3
        FROM table_name
        WHERE condition
        ORDER BY column1;

    -- Declaración de variables para almacenar los resultados del cursor
    xcolumn1 datatype1;
    xcolumn2 datatype2;
    xcolumn3 datatype3;

BEGIN
    -- Encabezado opcional
    dbms_output.put_line('Column1     Column2     Column3');
    dbms_output.put_line('=============================');

    -- Abrir el cursor
    OPEN cursor_name;
    
    -- Bucle para recorrer los resultados del cursor
    LOOP
        FETCH cursor_name INTO xcolumn1, xcolumn2, xcolumn3;
        EXIT WHEN cursor_name%NOTFOUND;

        -- Mostrar los resultados procesados
        dbms_output.put_line(xcolumn1 || '     ' || xcolumn2 || '     ' || xcolumn3);
    END LOOP;

    -- Cerrar el cursor
    CLOSE cursor_name;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Error: ' || SQLERRM);
END;

----EJEMPLO MOSTRAR NOMBRE COMPLETO, EDAD Y SALARIO
--QUERY
SELECT (name || ' ' || last_name) as full_name, age, salary 
FROM customer;
--CURSOR SOLUCION
DECLARE
    CURSOR cur_detalles IS
        SELECT (name || ' ' || last_name) as full_name, age, salary 
        FROM customer;

    -- Declaración de variables para almacenar los resultados del cursor
    xname VARCHAR(30);
    xage NUMBER;
    xsalary NUMBER;

BEGIN
    -- Encabezado opcional
    dbms_output.put_line('Nombre     Edad      Salario');
    dbms_output.put_line('=============================');

    -- Abrir el cursor
    OPEN cur_detalles;
    
    -- Bucle para recorrer los resultados del cursor
    LOOP
        FETCH cur_detalles INTO xname, xage, xsalary;
        EXIT WHEN cur_detalles%NOTFOUND;

        -- Mostrar los resultados procesados
        dbms_output.put_line(xname || '     ' || xage || '     ' || xsalary);
    END LOOP;

    -- Cerrar el cursor
    CLOSE cur_detalles;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Error: ' || SQLERRM);
END;
