-- Drop all functions and triggers

-- Drop triggers
DROP TRIGGER IF EXISTS trigger_limite_prestamos ON material_prestamo;
DROP TRIGGER IF EXISTS trigger_prestamo_previo ON material_prestamo;
DROP TRIGGER IF EXISTS trigger_uso_previo ON ordenador;

-- Drop functions
DROP FUNCTION IF EXISTS limite_prestamos();
DROP FUNCTION IF EXISTS actualizar_prestamo_previo();
DROP FUNCTION IF EXISTS actualizar_uso_previo();


-- El límite de 'cada socio sólo puede tomar prestado un libro o un CD a la vez' se implementa con un trigger y una función
-- Debido a la implementación de 'CDs' y 'libros' como tipos de una misma relación material_prestamo, se necesita un trigger para
-- asegurarse de que un socio no puede tomar prestado más de un libro o CD a la vez.
CREATE OR REPLACE FUNCTION limite_prestamos()
RETURNS TRIGGER AS $$
BEGIN

    IF (NEW.tipo = 'libro') THEN -- si el material a prestar es un libro
        IF (SELECT COUNT(*) 
            FROM material_prestamo 
            WHERE socio_prestamo = NEW.socio_prestamo AND tipo = 'libro') >= 1 THEN -- si el socio ya tiene un libro prestado
            RAISE EXCEPTION 'Este socio ya tiene prestado un libro. Debe devolverlo antes de tomar este.';
        END IF;
    END IF;


    IF (NEW.tipo = 'CD') THEN -- si el material a prestar es un CD
        IF (SELECT COUNT(*) 
            FROM material_prestamo 
            WHERE socio_prestamo = NEW.socio_prestamo AND tipo = 'CD') >= 1 THEN -- si el socio ya tiene un CD prestado
            RAISE EXCEPTION 'Este socio ya tiene prestado un CD. Debe devolverlo antes de tomar este.';
        END IF;
    END IF;

    -- si no se cumple ninguna de las condiciones anteriores, se permite el préstamo
    RETURN NEW;
END;
$$ LANGUAGE plpgsql; -- delimitador del cuerpo de la función, 'plgsql' --> postgresql


-- Trigger que se activa antes de actualizar la tabla material_prestamo
-- Por cada operación de update en material prestamo (cuando el material
-- está siendo prestado), se comprueba si el socio ya tiene un libro o CD
-- prestado. Si es así, se lanza una excepción.
CREATE TRIGGER trigger_limite_prestamos
BEFORE UPDATE ON material_prestamo
FOR EACH ROW
WHEN (NEW.fecha_prestamo IS NOT NULL)
EXECUTE FUNCTION limite_prestamos();



-- Las tablas 'prestamo previo' y 'uso previo' se pueden actualizar automáticamente
-- cuando se cancela un préstamo actual o un uso de un ordenador, para
-- facilitar el manejo de datos. Esto se puede implementar con dos funciones
-- y dos triggers, activados cuando los campos correspondientes pasan a NULL.

-- Función que actualiza la tabla 'prestamo_previo' cuando se cancela un préstamo
CREATE OR REPLACE FUNCTION actualizar_prestamo_previo()
RETURNS TRIGGER AS $$
BEGIN
    -- Inserta en `prestamo_previo` antes de modificar el registro
    INSERT INTO prestamo_previo (fecha_prestamo, fecha_devolucion, socio_prestamo, empleado_prestamo, material)
    VALUES (
        OLD.fecha_prestamo, -- Fecha original del préstamo
        CURRENT_DATE,       -- Fecha de devolución (cuando ocurre el cambio)
        OLD.socio_prestamo,
        OLD.empleado_prestamo,
        OLD.id_material
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_prestamo_previo
AFTER UPDATE OF socio_prestamo, empleado_prestamo
ON material_prestamo
FOR EACH ROW
WHEN (OLD.socio_prestamo IS NOT NULL AND NEW.socio_prestamo IS NULL)
-- si pasa de estar prstado (not null) a disponible (null)
EXECUTE FUNCTION actualizar_prestamo_previo();

-- lo mismo, para uso de ordenadores:
CREATE OR REPLACE FUNCTION actualizar_uso_previo()
RETURNS TRIGGER AS $$
BEGIN
    -- Inserta en `uso_previo` antes de modificar el registro
    INSERT INTO uso_previo (fecha_prestamo, fecha_devolucion, usuario, empleado_prestamo, id_ordenador)
    VALUES (
        OLD.fecha_prestamo, -- Fecha original del préstamo
        CURRENT_DATE,       -- Fecha de devolución (cuando ocurre el cambio)
        OLD.usuario,
        OLD.empleado_prestamo,
        OLD.id_ordenador
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- con el trigger:
CREATE TRIGGER trigger_uso_previo
AFTER UPDATE OF usuario, empleado_prestamo
ON ordenador
FOR EACH ROW
WHEN (OLD.usuario IS NOT NULL AND NEW.usuario IS NULL)
EXECUTE FUNCTION actualizar_uso_previo();


