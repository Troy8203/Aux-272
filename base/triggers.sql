--BASE
CREATE OR REPLACE TRIGGER trigger_name
    {BEFORE | AFTER} {INSERT | UPDATE | DELETE} ON table_name
    FOR EACH ROW
DECLARE
BEGIN
    -- Lógica del trigger, cualquier consulta (por ejemplo, insertar, actualizar o eliminar registros en otra tabla)
    -- Ejemplo para un INSERT
    INSERT INTO other_table (column1, column2, ...)
    VALUES (:NEW.column1, :NEW.column2, ...);

    -- Ejemplo para un UPDATE
    UPDATE other_table
    SET column1 = :NEW.column1, column2 = :NEW.column2
    WHERE condition_column = :OLD.column1;

    -- Ejemplo para un DELETE
    DELETE FROM other_table
    WHERE condition_column = :OLD.column1;
END;

----EJEMPLO DESPUES DE REALIZAR UNA ACTUALIZACION, GUARDAR LOS CAMBIOS REALIZADOS
--CREACION TABLA HISTORIAL DONDE SE ALMACENARA LOS CAMBIOS
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
--TRIGGER
CREATE OR REPLACE TRIGGER tr_add_historico_persona
AFTER UPDATE ON persona
FOR EACH ROW

DECLARE
BEGIN
    INSERT INTO historico_persona
    VALUES(:OLD.ci, :OLD.nombre, :NEW.nombre, :OLD.apepaterno, :NEW.apepaterno, :OLD.apematerno, :NEW.apematerno,  :OLD.sexo, :NEW.sexo, :OLD.nacionalidad, :NEW.nacionalidad, :OLD.fechanaci, :NEW.fechanaci);
END;
--EXE ACTUALIZACION PERSONA
UPDATE persona
SET ci=766572, nombre="Roberta", apepaterno="ApellidoMater", apematerno="ApePaterno", fechanaci="10/03/2023";nacionalidad="Peruano", sexo="Femenino";
