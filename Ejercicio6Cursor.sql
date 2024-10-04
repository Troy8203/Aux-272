DECLARE
    CURSOR cursor_per_col is SELECT ci, (apepaterno || ' ' || apematerno || ' ' || persona.nombre) name, nacionalidad
        FROM persona
        WHERE sexo LIKE 'Femenino' and nacionalidad LIKE 'Colombiana'
        ORDER BY apepaterno;

        xci NUMBER;
        xname VARCHAR(30);
        xnacionalidad VARCHAR(30);
BEGIN
    dbms_output.put_line('CI        APELLIDOS Y NOMBRES             NACIONALIDAD'); 
    dbms_output.put_line('========================================'); 
    OPEN cursor_per_col;
        LOOP
            FETCH cursor_per_col INTO xci, xname, xnacionalidad;
            EXIT WHEN cursor_per_col%NOTFOUND;
            dbms_output.put_line(xci||'        '||xname||'            '||xnacionalidad);
        END LOOP;
    CLOSE cursor_per_col;
END;

--2)
DECLARE
    CURSOR cursor_emp(xnamesuc IN VARCHAR) IS SELECT apepaterno, apematerno, nombre
        FROM (SELECT *
        FROM sucursal, empleado, persona
        WHERE sucursal.idsuc = empleado.idsuc AND direccion LIKE xnamesuc AND ciempleado=ci) tmp
        ORDER BY apepaterno;

        xapep VARCHAR(50);
        xapem VARCHAR(50);
        xname VARCHAR(50);
        xcout NUMBER;
        xnamesuc VARCHAR(50);
BEGIN
    dbms_output.put_line('=================================================='); 
    xcout:=0;
    xnamesuc:='Central';
    OPEN cursor_emp(xnamesuc);
        LOOP
            FETCH cursor_emp INTO xapep, xapem, xname;
            EXIT WHEN cursor_emp%NOTFOUND;
            xcout:=xcout+1;
            dbms_output.put_line(xcout||' '||xapep||'        '||xapem||'            '||xname);
        END LOOP;
    CLOSE cursor_emp;
END;
--3)
DECLARE
    CURSOR cursor_ing IS SELECT iding, nombre, stock
        FROM ingrediente
        ORDER BY nombre;

        xiding NUMBER;
        xname VARCHAR(50);
        xstock NUMBER;
BEGIN
    dbms_output.put_line('=================================================='); 
    OPEN cursor_ing;
        LOOP
            FETCH cursor_ing INTO xiding, xname, xstock;
            EXIT WHEN cursor_ing%NOTFOUND;
            IF xstock<=20 THEN
                dbms_output.put_line(xiding||' '||xname||'        SOLICITAR PRODUCTO');
            ELSE
                dbms_output.put_line(xiding||' '||xname||'        ---');
            END IF;

        END LOOP;
    CLOSE cursor_ing;
END;