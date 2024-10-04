EJER1

CREATE OR REPLACE FUNCTION flag_director(xidper IN NUMBER) RETURN VARCHAR
IS
    xflag VARCHAR(100);
BEGIN
    SELECT nombre INTO xflag
    FROM director, persona
    WHERE director.idper=persona.idper and persona.idper=xidper;
    RETURN xflag;
END flag_director;

CREATE OR REPLACE FUNCTION state_director(xname VARCHAR) RETURN VARCHAR2
IS
    xflag VARCHAR2(255);
BEGIN
    IF xname IS NULL THEN
        xflag:='NO';
    ELSE
        xflag:='SI';
    END IF;

    RETURN xflag;
END state_director;

--procedure

CREATE OR REPLACE PROCEDURE ficha_per(

    xidper IN NUMBER,
    xname OUT VARCHAR,
    xdirector OUT VARCHAR2,
    xcantpeli OUT NUMBER
)

IS

BEGIN

    SELECT nombre INTO xname
    FROM persona
    WHERE idper=xidper;

    SELECT state_director(flag_director(idper)) INTO xdirector
    FROM persona
    WHERE idper=xidper;

    SELECT COUNT(idper) INTO xcantpeli
    FROM actua
    WHERE idper=xidper;

    EXCEPTION
        WHEN no_data_found THEN
            xname := 'ERROR';
            xdirector := 'ERROR';
            xcantpeli := 0;

END;

--execute
DECLARE

    xidper NUMBER;
    xname VARCHAR(100);
    xdirector VARCHAR2(100);
    xcantpeli NUMBER;

BEGIN

    xidper:=1700;
    ficha_per(xidper, xname, xdirector, xcantpeli);
    dbms_output.put_line('Persona : '||xidper||'  '||xname);
    dbms_output.put_line('Es director : '||xdirector);
    dbms_output.put_line('Cantidad de peliculas en las que actua: '||xcantpeli);
END;

EJER2

CREATE OR REPLACE PROCEDURE ficha_can(

    xidprod IN NUMBER,
    xname OUT VARCHAR,
    xyear OUT NUMBER,
    xcant OUT VARCHAR
)

IS

BEGIN

    SELECT descripcion INTO xname
    FROM producto
    WHERE idprod=xidprod;

    SELECT anio_produccion INTO xyear
    FROM producto
    WHERE idprod=xidprod;

    SELECT nombre INTO xcant
    FROM canta, persona
    WHERE canta.idper=persona.idper AND idprod=xidprod;

    EXCEPTION
        WHEN no_data_found THEN
            xname := 'ERROR';
            xyear := 0;
            xcant := 'ERROR';
        WHEN TOO_MANY_ROWS THEN
            SELECT COUNT(*) INTO xcant
            FROM (SELECT nombre
            FROM canta, persona
            WHERE canta.idper=persona.idper AND idprod=xidprod) tmp;

END;

--execute
DECLARE
    xidprod NUMBER;
    xname VARCHAR(100);
    xyear NUMBER;
    xcant VARCHAR(100);

BEGIN

    xidprod:=320;
    ficha_can(xidprod, xname, xyear, xcant);
    dbms_output.put_line('Producto : '||xidprod);
    dbms_output.put_line('Titulo cancion : '||xname);
    dbms_output.put_line('Año de produccion : '||xyear);
    dbms_output.put_line('Canta : '||xcant);
END;
