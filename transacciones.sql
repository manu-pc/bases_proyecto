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

-- Se presta este libro a María, siENDo el préstamo manejado por Juan.
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

--transacción 2 (llegada de nuevos ordenadores y uso de uno de ellos por un nuevo socio)
BEGIN;

do $$

    DECLARE
	v_socio_id integer;
	v_empleado_id char(9) := '99999999X'; --helena
	v_ordenador_id integer;
BEGIN

INSERT INTO socio VALUES (default, 'Pablo', 'Rodríguez', 'Pérez', '2001-04-12', 'Ciudad, Calle nº15', '678969493')
RETURNING id_socio INTO v_socio_id;

INSERT INTO ordenador (id_ordenador, so, modelo)
VALUES 
	(default, 'Pop OS', 'MSI'),
	(default, 'Pop OS', 'MSI'),
	(default, 'Windows 11', 'Asus'),
	(default, 'macOS', 'Apple');

-- ordenador estrenado por pablo

INSERT INTO ordenador (so, modelo, usuario, fecha_prestamo, empleado_prestamo) VALUES ('macOS', 'Apple', v_socio_id, '2024-11-29', v_empleado_id)
RETURNING id_ordenador INTO v_ordenador_id;


-- acaba de usar el ordenador
UPDATE ordenador 
SET usuario = null, fecha_prestamo = null, empleado_prestamo = null
WHERE id_ordenador = v_ordenador_id;



END $$;

COMMIT;

--transacción 3 (nuevo empleado, ascenso, préstamo y turno)

BEGIN;

-- nuevo empleado bibliotecario
INSERT INTO empleado VALUES ('44445555X', 'Carla', 'Sánchez', 'López', '1999-04-23', '2024-11-30', 1200);

INSERT INTO cargo VALUES ('44445555X', 'bibliotecario');


-- asciENDen a helena
UPDATE cargo
SET cargo = 'gerente'
WHERE dni_empleado = '99999999X';

-- realizan un prestamo
UPDATE material_prestamo 
SET socio_prestamo = 1, empleado_prestamo = '44445555X', fecha_prestamo = '2024-11-30'
WHERE id_material = 2000005;
-- turno de Carla
INSERT INTO turno VALUES ('44445555X', '2024-11-30', '08:00:00', '14:00:00');

COMMIT;

-- transaccion 4 (nuevos autores y obras, préstamos, devolución y turnos)
BEGIN;
do $$
    DECLARE
        nuevo_socio integer;
        nuevo_libro_2 integer;
        nuevo_libro_1 integer;
        creador_1 integer;
        creador_2 integer;
    BEGIN
        INSERT INTO creador -- se añade a George Orwell y a Patrick Rothfuss como nuevos creadores.
        VALUES (default, 'Eric', 'Arthur', 'Blair', '1903-06-13', 'India Britanica')
        RETURNING id_creador INTO creador_1;
        INSERT INTO creador
        VALUES (default, 'Patrick', 'James', 'Rothfuss', '1973-08-13', 'Estadounidense')
        RETURNING id_creador INTO creador_2;
        INSERT INTO material_prestamo -- se añaden dos nuevos libros a la base de datos
        VALUES (default, 'libro', '1984', 'Ciencia ficción', '2011-10-14', creador_1, 'Secker & Warburg', '9780451524935', null, null, null)
        RETURNING id_material INTO nuevo_libro_1;
        INSERT INTO material_prestamo
        VALUES (default, 'libro', 'El nombre del viento', 'Fantasía', '2009-04-27', creador_2, 'Plaza & Janés', '9788498385542', null, null, null)
        RETURNING id_material INTO nuevo_libro_2;

         
        INSERT INTO socio VALUES (default, 'María', 'Fernández', 'Souto', '2004-04-02', 'Ciudad, Calle nº2', '682346273') -- se añade un nuevo socio a la base de datos
        RETURNING id_socio INTO nuevo_socio;

        -- se realiza un préstamo de El nombre del viento a María
        UPDATE material_prestamo
            SET socio_prestamo = nuevo_socio, empleado_prestamo = '44445555X', fecha_prestamo = '2024-12-04'
            WHERE id_material = nuevo_libro_2;

        -- se añade un turno para Carla
        INSERT INTO turno VALUES ('44445555X', '2024-12-04', '08:00:00', '14:00:00');

        -- se devuelve el libro
        UPDATE material_prestamo
            SET socio_prestamo = null, empleado_prestamo = null, fecha_prestamo = null
            WHERE id_material = nuevo_libro_2;

        -- se realiza un préstamo de 1984 a María
        UPDATE material_prestamo
            SET socio_prestamo = nuevo_socio, empleado_prestamo = '00000000Y', fecha_prestamo = '2024-12-04'
            WHERE id_material = nuevo_libro_1;

        -- se añade un turno para Juan
        INSERT INTO turno VALUES ('00000000Y', '2024-12-04', '16:00:00', '21:00:00');

END $$;
COMMIT;

-- Transacción 5: Nuevo CD y libros, préstamos y devolución, además de un nuevo ordenador y su uso
BEGIN;

DO $$
DECLARE
    nuevo_socio_id INTEGER;
    nuevo_creador_id INTEGER;
    nuevo_cd_id INTEGER;
    nuevo_libro1_id INTEGER;
    nuevo_libro2_id INTEGER;
    nuevo_ordenador_id INTEGER;
    empleado_id CHAR(9) := '44445555X'; -- ID de Carla
BEGIN

-- Se añade un nuevo socio a la base de datos
INSERT INTO socio (nombre, apellido1, apellido2, fecha_nacimiento, direccion, telefono)
VALUES ('Carlos', 'Martínez', 'Gómez', '1985-07-20', 'Ciudad, Calle nº20', '623456789')
RETURNING id_socio INTO nuevo_socio_id;

-- Se añade un nuevo creador a la base de datos
INSERT INTO creador (nombre, apellido1, apellido2, fecha_nacimiento, nacionalidad)
VALUES ('Ludwig', 'van', 'Beethoven', '1770-12-17', 'Alemania')
RETURNING id_creador INTO nuevo_creador_id;

-- Se añade un nuevo CD a la base de datos, y se presta directamente a Carlos
INSERT INTO material_prestamo (tipo, titulo, genero, fecha_publicacion, creador, productora, isbn, socio_prestamo, empleado_prestamo, fecha_prestamo)
VALUES ('CD', 'Sinfonía No. 9', 'Clásica', '1824-05-07', nuevo_creador_id, 'Deutsche Grammophon', NULL, nuevo_socio_id, empleado_id, CURRENT_DATE)
RETURNING id_material INTO nuevo_cd_id;

-- El socio devuelve el CD
UPDATE material_prestamo
SET socio_prestamo = NULL, empleado_prestamo = NULL, fecha_prestamo = NULL
WHERE id_material = nuevo_cd_id;

-- Se añaden dos nuevos libros a la base de datos
INSERT INTO creador (nombre, apellido1, apellido2, fecha_nacimiento, nacionalidad)
VALUES ('George', 'Orwell', NULL, '1903-06-25', 'Reino Unido')
RETURNING id_creador INTO nuevo_creador_id;

INSERT INTO material_prestamo (tipo, titulo, genero, fecha_publicacion, creador, productora, isbn, socio_prestamo, empleado_prestamo, fecha_prestamo)
VALUES ('libro', '1984', 'Distopía', '1949-06-08', nuevo_creador_id, 'Secker & Warburg', '9780451524935', NULL, NULL, NULL)
RETURNING id_material INTO nuevo_libro1_id;

INSERT INTO material_prestamo (tipo, titulo, genero, fecha_publicacion, creador, productora, isbn, socio_prestamo, empleado_prestamo, fecha_prestamo)
VALUES ('libro', 'Rebelión en la granja', 'Satira', '1945-08-17', nuevo_creador_id, 'Secker & Warburg', '9780451526342', NULL, NULL, NULL)
RETURNING id_material INTO nuevo_libro2_id;

-- El socio toma prestado uno de los nuevos libros
UPDATE material_prestamo
SET socio_prestamo = nuevo_socio_id, empleado_prestamo = empleado_id, fecha_prestamo = CURRENT_DATE
WHERE id_material = nuevo_libro1_id;

-- Se añade un nuevo ordenador a la base de datos
INSERT INTO ordenador (so, modelo)
VALUES ('Windows 10', 'Dell')
RETURNING id_ordenador INTO nuevo_ordenador_id;

-- El socio empieza a usar el ordenador
UPDATE ordenador
SET usuario = nuevo_socio_id, fecha_prestamo = CURRENT_DATE, empleado_prestamo = empleado_id
WHERE id_ordenador = nuevo_ordenador_id;

END $$;

COMMIT;