-- seleccionar todos los socios
SELECT
    id_socio,
    nombre,
    apellido1,
    apellido2,
    fecha_nacimiento,
    direccion,
    telefono
FROM
    socio;

-- seleccionar todos los creadores
SELECT
    id_creador,
    nombre,
    apellido1,
    apellido2,
    fecha_nacimiento,
    nacionalidad
FROM
    creador;

-- seleccionar los nombres, tipos e id de todos los materiales
SELECT
    titulo,
    tipo,
    id_material,
    genero,
    fecha_publicacion,
    creador,
    productora,
    isbn
FROM
    material_prestamo
ORDER BY
    id_material;

-- seleccionar todos los ordenadores
SELECT
    id_ordenador,
    so,
    modelo
FROM
    ordenador;

-- Obtener todos los libros en préstamo
SELECT
    id_material,
    tipo,
    titulo,
    genero,
    fecha_publicacion,
    creador,
    productora,
    isbn
FROM
    material_prestamo
WHERE
    tipo = 'libro'
    AND socio_prestamo IS NOT NULL;

-- seleccionar todos los turnos de un empleado específico (Juan)
SELECT
    empleado,
    dia,
    hora_entrada,
    hora_salida
FROM
    turno
WHERE
    empleado = '00000000Y';

-- Obtener todos los préstamos previos de un socio específico
SELECT
    material,
    fecha_prestamo,
    fecha_devolucion
FROM
    prestamo_previo
WHERE
    socio_prestamo = 3;

-- seleccionar todos los usos previos de un ordenador específico
SELECT
    id_ordenador,
    fecha_prestamo,
    fecha_devolucion,
    usuario
FROM
    uso_previo
WHERE
    id_ordenador = 3000000;

-- seleccionar todos los nombres de los creadores de nacionalidad estadounidense
SELECT
    nombre,
    apellido1,
    apellido2
FROM
    creador
WHERE
    nacionalidad = 'EEUU';

-- seleccionar todos los materiales actualmente disponibles (no en préstamo)
SELECT
    id_material,
    tipo,
    titulo,
    genero,
    fecha_publicacion,
    creador,
    productora,
    isbn
FROM
    material_prestamo
WHERE
    socio_prestamo IS NULL;

--  seleccionar todos los materiales prestados actualmente por un socio específico
SELECT
    id_material,
    tipo,
    titulo,
    genero,
    fecha_publicacion,
    creador,
    productora,
    isbn
FROM
    material_prestamo
WHERE
    socio_prestamo = 3;

-- seleccionar todos los ordenadores actualmente disponibles (no en préstamo)
SELECT
    id_ordenador,
    so,
    modelo
FROM
    ordenador
WHERE
    fecha_prestamo IS NULL;