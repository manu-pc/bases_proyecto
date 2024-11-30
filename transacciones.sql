-- Transacción 1:
BEGIN;

-- Variables
DO $$
DECLARE
    v_autor_id INTEGER;
    v_libro_id INTEGER;
    v_socio_id INTEGER := 3; -- ID de María
    v_empleado_id CHAR(9) := '00000000Y'; -- ID de Juan
BEGIN

-- Se añade un nuevo autor a la base de datos, Fiódor Dostoievski
INSERT INTO creador (nombre, apellido1, apellido2, fecha_nacimiento, nacionalidad)
VALUES ('Fiódor', 'Mijáilovich', 'Dostoievski', '1821-11-11', 'Rusia')
RETURNING id_creador INTO v_autor_id;

-- Se añade un nuevo libro a la base de datos, Crimen y castigo. Inicialmente está disponible (null en los ultimos atr.)
INSERT INTO material_prestamo (tipo, titulo, genero, fecha_publicacion, creador, productora, isbn, socio_prestamo, empleado_prestamo, fecha_prestamo)
VALUES ('libro', 'Crimen y castigo', 'Novela', '1866-01-01', v_autor_id, 'El Mensajero Ruso', '9780140449136', NULL, NULL, NULL)
RETURNING id_material INTO v_libro_id;

-- Se presta este libro a María, siendo el préstamo manejado por Juan.
UPDATE material_prestamo
SET socio_prestamo = v_socio_id, empleado_prestamo = v_empleado_id, fecha_prestamo = CURRENT_DATE
WHERE id_material = v_libro_id;



-- Luego, María devuelve el libro. Se comprueba que la tabla 'prestamo_previo' se actualiza correctamente.
UPDATE material_prestamo
SET socio_prestamo = NULL, empleado_prestamo = NULL, fecha_prestamo = NULL
WHERE id_material = v_libro_id;

END $$;

COMMIT;

-- Si, tras esto, realizasemos una consulta a la tabla 'prestamo_previo', deberíamos ver una nueva entrada con los datos del préstamo y devolución de Crimen y castigo.
-- La fecha de devolución (y préstamo) debería ser la fecha actual (cuando se ejecute la transacción), y el socio y empleado deberían ser María y Juan, respectivamente.