---1)
DECLARE
    CURSOR cursor_musical IS SELECT DISTINCT producto.idprod, descripcion
        FROM producto, canta
        WHERE producto.idprod=canta.idprod
        ORDER BY descripcion;
    
    xidprod NUMBER;
    xsong VARCHAR(100);
    xcout NUMBER;

    CURSOR cursor_inter IS SELECT nombre
        FROM producto, canta, persona
        WHERE producto.idprod=canta.idprod AND canta.idper=persona.idper AND producto.idprod=xidprod
        ORDER BY nombre;

    xname varchar(100);
BEGIN
    xcout:=0;
    OPEN cursor_musical;
        LOOP
            FETCH cursor_musical INTO xidprod, xsong;
            EXIT WHEN cursor_musical%NOTFOUND;
            xcout:=xcout+1;
            dbms_output.put_line(xcout||') ' || xsong);

            OPEN cursor_inter;
                LOOP
                    FETCH cursor_inter INTO xname;
                    EXIT WHEN cursor_inter%NOTFOUND;
                    dbms_output.put_line('          '||xname);
                END LOOP;
            CLOSE cursor_inter;

        END LOOP;
    CLOSE cursor_musical;
END
--2)
DECLARE
    CURSOR cursor_peli IS SELECT producto.idprod, descripcion
        FROM producto, pelicula
        WHERE producto.idprod=pelicula.idprod AND genero LIKE 'drama'
        ORDER BY descripcion;
    
    xidprod NUMBER;
    xpeli VARCHAR(100);
    xnumpeli NUMBER;

    CURSOR cursor_dirige IS SELECT nombre
        FROM producto, pelicula, dirige, persona
        WHERE producto.idprod=pelicula.idprod AND genero LIKE 'drama' AND pelicula.idprod = dirige.idprod AND dirige.idper=persona.idper AND pelicula.idprod=xidprod
        ORDER BY descripcion;

    xname VARCHAR(100);

    CURSOR cursor_actua IS SELECT nombre
        FROM producto, pelicula, actua, persona
        WHERE producto.idprod=pelicula.idprod AND genero LIKE 'drama' AND pelicula.idprod=actua.idprod AND actua.idper=persona.idper AND pelicula.idprod=xidprod
        ORDER BY nombre;

    xactor VARCHAR(100);
    
BEGIN
    xnumpeli:=0;
    OPEN cursor_peli;
        LOOP
            FETCH cursor_peli INTO xidprod, xpeli;
            EXIT WHEN cursor_peli%NOTFOUND;
            xnumpeli:=xnumpeli+1;
            dbms_output.put_line(xnumpeli||') '||xpeli);
            dbms_output.put_line(' ');
            dbms_output.put_line('Dirige(n)');
            OPEN cursor_dirige;
                LOOP
                    FETCH cursor_dirige INTO xname;
                    EXIT WHEN cursor_dirige%NOTFOUND;
                    dbms_output.put_line('   '||xname);
                END LOOP;
            CLOSE cursor_dirige;
            dbms_output.put_line(' ');
            dbms_output.put_line('Actua(n)      '||contar_actores(xidprod));
            OPEN cursor_actua;
                LOOP
                    FETCH cursor_actua INTO xactor;
                    EXIT WHEN cursor_actua%NOTFOUND;
                    dbms_output.put_line('   '||xactor);                    
                END LOOP;
            CLOSE cursor_actua;
            dbms_output.put_line('-----------------');
        END LOOP;
    CLOSE cursor_peli;
END
---su funcion del 2
CREATE OR REPLACE FUNCTION contar_actores(xidprod IN NUMBER) RETURN NUMBER
IS
    xcantidad NUMBER;
BEGIN
    SELECT COUNT(*) INTO xcantidad
    FROM (SELECT nombre
            FROM producto, pelicula, actua, persona
            WHERE producto.idprod=pelicula.idprod AND pelicula.idprod=actua.idprod AND actua.idper=persona.idper AND pelicula.idprod=xidprod
            ORDER BY nombre) tmp;
    RETURN xcantidad;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END contar_actores;