-- CR #1: Obras disponibles (que no están en préstamo), ordenadas por género y autor
SELECT
    mp.titulo AS nombre_obra,
    mp.id_material,
    mp.genero,
    c.nombre AS nombre_autor,
    c.apellido1 AS apellido1_autor,
    c.apellido2 AS apellido2_autor
FROM
    material_prestamo mp
    JOIN creador c ON mp.creador = c.id_creador
WHERE
    mp.fecha_prestamo IS NULL
ORDER BY
    mp.genero,
    c.nombre,
    c.apellido1,
    c.apellido2;

-- CR #2: Prestamos actuales de todos los usuarios, imprimiendo sólo el nombre de la obra, el nombre del usuario, la fecha del prestamo y el nombre del empleado
SELECT
    mp.titulo AS nombre_obra,
    s.nombre AS nombre_socio,
    mp.fecha_prestamo AS fecha_prestamo,
    e.nombre AS nombre_empleado
FROM
    material_prestamo mp
    JOIN socio s ON mp.socio_prestamo = s.id_socio
    JOIN empleado e ON mp.empleado_prestamo = e.dni
WHERE
    mp.fecha_prestamo IS NOT NULL;

-- CR #3: Ordenadores en uso, junto con el usuario actualmente usándolos.
SELECT
    o.id_ordenador,
    o.so,
    o.modelo,
    o.fecha_prestamo,
    s.nombre AS nombre_usuario
FROM
    ordenador o
    JOIN socio s ON s.id_socio = o.usuario;

-- CR #4: Prestamos actuales de José, imprimiendo sólo el nombre de la obra y la fecha del préstamo.
SELECT
    s.nombre AS nombre_socio,
    mp.titulo AS nombre_obra,
    mp.fecha_prestamo
FROM
    socio s
    JOIN material_prestamo mp ON s.id_socio = mp.socio_prestamo
WHERE
    s.id_socio = (
        SELECT
            id_socio
        FROM
            socio
        WHERE
            nombre = 'José'
            AND apellido1 = 'González'
            AND apellido2 = 'Pérez'
    );

-- CR #5: Prestamos previos de una obra (Crimen y Castigo)
-- (tras ejecutar la transacción 1, debería devolver un préstamo, el de María)
SELECT
    mp.titulo AS nombre_obra,
    pp.fecha_prestamo,
    pp.fecha_devolucion,
    s.nombre AS nombre_socio
FROM
    material_prestamo mp
    JOIN prestamo_previo pp ON mp.id_material = pp.material
    JOIN socio s ON pp.socio_prestamo = s.id_socio
WHERE
    mp.titulo = 'Crimen y castigo';

-- CR #6: Usos previos de un ordenador, incluyendo la información del préstamo
SELECT
    o.id_ordenador,
    o.so,
    o.modelo,
    up.fecha_prestamo,
    up.fecha_devolucion,
    s.nombre AS nombre_socio,
    e.nombre AS nombre_empleado
FROM
    ordenador o
    JOIN uso_previo up ON o.id_ordenador = up.id_ordenador
    JOIN socio s ON up.usuario = s.id_socio
    JOIN empleado e ON up.empleado_prestamo = e.dni
WHERE
    o.id_ordenador = 3000001;

-- CR #7: Prestamos, actuales y pasados, manejados por un empleado (en este caso, Juan)
-- Los préstamos actuales tendrán NULL en la fecha de devolución
SELECT
    mp.titulo AS nombre_obra,
    mp.fecha_prestamo,
    NULL AS fecha_devolucion,
    s.nombre AS nombre_socio,
    e.nombre AS nombre_empleado
FROM
    material_prestamo mp
    JOIN socio s ON mp.socio_prestamo = s.id_socio
    JOIN empleado e ON mp.empleado_prestamo = e.dni
WHERE
    e.dni = '00000000Y'
UNION
ALL
SELECT
    mp.titulo AS nombre_obra,
    pp.fecha_prestamo,
    pp.fecha_devolucion,
    s.nombre AS nombre_socio,
    e.nombre AS nombre_empleado
FROM
    prestamo_previo pp
    JOIN material_prestamo mp ON pp.material = mp.id_material
    JOIN socio s ON pp.socio_prestamo = s.id_socio
    JOIN empleado e ON pp.empleado_prestamo = e.dni
WHERE
    e.dni = '00000000Y'
ORDER BY
    fecha_devolucion DESC,
    -- esto asegura que se imprimen primero los préstamos actuales, luego los pasados (DESC - descendiente)
    fecha_prestamo;

-- CR #8: Obras cuyo creador es estadounidense, ordenadas por número de veces que han sido prestadas
SELECT
    mp.titulo AS nombre_obra,
    mp.genero,
    c.nombre AS nombre_autor,
    c.apellido1 AS apellido1_autor,
    c.apellido2 AS apellido2_autor,
    COUNT(pp.material) AS veces_prestada
FROM
    material_prestamo mp
    JOIN prestamo_previo pp ON mp.id_material = pp.material
    JOIN creador c ON mp.creador = c.id_creador
WHERE
    c.nacionalidad = 'EEUU'
GROUP BY
    mp.titulo,
    mp.genero,
    c.nombre,
    c.apellido1,
    c.apellido2
ORDER BY
    veces_prestada DESC;

-- CR #9: De cada socio, imprimir su nombre y préstamos previos (sólo nombre de obra y fecha de prestamo y devolucion)
SELECT
    s.nombre AS nombre_socio,
    mp.titulo AS nombre_obra,
    mp.tipo AS tipo_material,
    pp.fecha_prestamo,
    pp.fecha_devolucion
FROM
    socio s
    JOIN prestamo_previo pp ON s.id_socio = pp.socio_prestamo
    JOIN material_prestamo mp ON pp.material = mp.id_material
ORDER BY
    s.nombre,
    pp.fecha_prestamo;

-- CR #10: Contar el número de CDs y libros prestados (y devueltos) por cada socio, y ordenar por número de material total prestado
SELECT
    s.nombre AS nombre_socio,
    COUNT(
        CASE
            WHEN mp.tipo = 'libro' THEN 1
        END
    ) AS total_libros,
    COUNT(
        CASE
            WHEN mp.tipo = 'CD' THEN 1
        END
    ) AS total_cds,
    COUNT(pp.material) AS total_prestamos
FROM
    socio s
    JOIN prestamo_previo pp ON s.id_socio = pp.socio_prestamo
    JOIN material_prestamo mp ON pp.material = mp.id_material
GROUP BY
    s.nombre
ORDER BY
    total_prestamos DESC;