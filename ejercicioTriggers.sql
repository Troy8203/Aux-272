--1
--CReacion de tabla
CREATE TABLE HISTORICO_PERSONA(
    ci  NUMBER,
    nombre_ant VARCHAR2(100),
    nombre_act VARCHAR2(100),
    apepaterno_ant VARCHAR2(100),
    apepaterno_act VARCHAR2(100),
    apellidomaterno_ant VARCHAR2(100),
    apellidomaterno_act VARCHAR2(100),
    sexo_ant VARCHAR2(100),
    sexo_act VARCHAR2(100),
    nacionalidad_ant VARCHAR2(100),
    nacionalidad_act VARCHAR2(100),
    fecha_nac_ant DATE,
    fecha_nac_act DATE
)

CREATE OR REPLACE TRIGGER tr_add_historico_persona
AFTER UPDATE ON persona
FOR EACH ROW

DECLARE
BEGIN
    INSERT INTO historico_persona
    VALUES(:OLD.ci, :OLD.nombre, :NEW.nombre, :OLD.apepaterno, :NEW.apepaterno, :OLD.apematerno, :NEW.apematerno,  :OLD.sexo, :NEW.sexo, :OLD.nacionalidad, :NEW.nacionalidad, :OLD.fechanaci, :NEW.fechanaci);
END;

UPDATE persona
SET ci=766572, nombre="Roberta", apepaterno="ApellidoMater", apematerno="ApePaterno", fechanaci="10/03/2023";nacionalidad="Peruano", sexo="Femenino";
--2
CREATE OR REPLACE TRIGGER act_ingrediente
AFTER INSERT ON provee
FOR EACH ROW

DECLARE
BEGIN
    UPDATE ingrediente
    SET stock=stock+:NEW.cantidad
    WHERE ingrediente.iding=:NEW.iding;
END;

INSERT INTO provee
VALUES(914701, 1719153, 8);

DELETE FROM provee
WHERE idprov=1719153 AND iding=914701;