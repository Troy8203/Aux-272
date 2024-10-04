--1)
CREATE OR REPLACE TRIGGER add_xmont
AFTER INSERT ON esta_compuesto
FOR EACH ROW

DECLARE
BEGIN
    UPDATE producto
    SET costo =
        CASE
            WHEN :NEW.cantidad<10 THEN
                costo+5
            WHEN :NEW.cantidad>=10 AND :NEW.cantidad<20 THEN
                costo+10
            WHEN :NEW.cantidad>=20 THEN
                costo+15
        END 
    WHERE producto.idprod=:NEW.idprod;
END;

--pruebas
INSERT INTO esta_compuesto (iding, idprod, cantidad)
VALUES (914709, 178207, 15)


DELETE FROM esta_compuesto
WHERE idprod=178207 AND iding=914709;

--**
DELETE FROM producto
WHERE idprod=171205

INSERT INTO producto(idprod, nombre, costo)
VALUES(171205, 'POLLO FRITO SIMPLE', 18)

UPDATE producto
SET costo = 23
WHERE idprod=178207