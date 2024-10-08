--BASE
CREATE OR REPLACE FUNCTION function_name(param1 datatype, param2 datatype)
RETURN return_datatype
IS
    output_value return_datatype;
BEGIN
    -- cuerpo de la función
    RETURN output_value;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN value_default;
END function_name;

----EJEMPLO CREAR UNA FUNCION QUE CALCULE EL SALARIO EN DOLARES
--QUERY
SELECT ROUND((SALARY/6.91), 2) AS salary_dolar
FROM customer
WHERE id = 1;
---FUNCTION SOLUTION
CREATE OR REPLACE FUNCTION convert_to_dolar(xid IN NUMBER)
RETURN NUMBER
IS
    salary_dolar NUMBER;
BEGIN
    -- cuerpo de la función
    SELECT ROUND(SUM(SALARY/6.91), 2) AS salary_dolar INTO salary_dolar
      FROM customer
      WHERE id = xid;

    RETURN salary_dolar;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END convert_to_dolar;

---EXE EJECUCION INDIVIDUAL
SELECT convert_to_dolar(1) FROM dual;

---EXE EJECUCION EN CONSULTA
SELECT customer.*, convert_to_dolar(id) AS dolar
FROM customer;