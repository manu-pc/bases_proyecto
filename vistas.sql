DROP VIEW IF EXISTS vista_prestamos_actuales;
DROP VIEW IF EXISTS vista_materiales_disponibles;
DROP VIEW IF EXISTS vista_bibliotecarios;
DROP VIEW IF EXISTS ordenadores_dispoñibles;
DROP VIEW IF EXISTS Autores_dispoñibles;

-- Crea unha vista que amose os préstamos actuais.
-- Inclúe o id do material, o título do material, o tipo do material, o id do socio, o nome do socio, o dni do empregado, o nome do empregado e a data do préstamo.
-- (Combina datos dos socios e tamén dos materiais)
CREATE VIEW vista_prestamos_actuales AS
SELECT
    mp.id_material AS id_material,
    mp.titulo AS titulo_material,
    mp.tipo AS tipo_material,
    s.id_socio AS id_socio,
    s.nombre AS nombre_socio,
    e.dni AS dni_empleado,
    e.nombre AS nombre_empleado,
    mp.fecha_prestamo
FROM
    material_prestamo mp
    LEFT JOIN socio s ON mp.socio_prestamo = s.id_socio -- úsase 'left join' para que se amose o material que non ten socio asignado
    -- (left join inclúe elementos que teñen NULL na tabla dereita, neste caso socio)
    -- en este caso socio_prestamo será NULL, o cal é posible na base de datos
    LEFT JOIN empleado e ON mp.empleado_prestamo = e.dni -- empleado pode ser null, igual que socio
WHERE
    -- Só inclúe os materiais actualmente en préstamo
    mp.fecha_prestamo IS NOT NULL;

-- Crea unha vista que amose todo o material da biblioteca ordeados por xénero.
-- Inclúe o id do material, o título do material, o tipo do material, o nome do creador, a data de publicación, o xénero e se está dispoñible.
CREATE VIEW vista_materiales_disponibles AS
SELECT
    mp.id_material AS id_material,
    mp.titulo AS titulo_material,
    mp.tipo AS tipo_material,
    c.nombre AS nombre_creador,
    mp.fecha_publicacion,
    mp.genero AS xenero,
    CASE
        WHEN mp.fecha_prestamo IS NULL THEN 'sí'
        ELSE 'no'
    END AS "disponible?"
FROM
    material_prestamo mp
    JOIN creador c ON mp.creador = c.id_creador
ORDER BY
    mp.tipo, mp.genero;

-- Crea unha vista que amose os empregados que son bibliotecarios ou xerentes.
-- Inclúe o dni do empregado, o nome do empregado, o seu cargo (que é bibliotecario) e a conta dos préstamos que han manejado.
-- Inclúe tamén unha columna de 'turnos traballados' que se calcula contando os turnos do empregado.
CREATE VIEW vista_bibliotecarios AS
SELECT
    e.dni AS dni_empleado,
    e.nombre AS nombre_empleado,
    c.cargo,
    COUNT(mp.id_material) AS cuenta_prestamos,
    COUNT(t.dia) AS turnos_trabajados
FROM
    empleado e
    JOIN cargo c ON e.dni = c.dni_empleado
    LEFT JOIN material_prestamo mp ON e.dni = mp.empleado_prestamo
    LEFT JOIN turno t ON e.dni = t.empleado
WHERE
    -- só inclúe os empregados con cargo de bibliotecario ou xerente
    c.cargo = 'bibliotecario' OR c.cargo = 'gerente'
GROUP BY
    e.dni, e.nombre, c.cargo
ORDER BY
    cuenta_prestamos DESC;


-- Crea unha vista que amose os ordenadores da biblioteca, e se están dispoñibles.
-- Inclúe o id do ordenador, SO do ordenador e o modelo do ordenador
CREATE VIEW ordenadores_dispoñibles AS
SELECT
    o.id_ordenador AS ID,
    o.SO AS Sistema_Operativo,
    o.modelo AS modelo,
    CASE
        WHEN o.usuario IS NULL THEN 'sí'
        ELSE 'no'
    END AS "disponible?"
FROM
    ordenador o;

-- Crea unha vista que amose os creadores que crearan algun material de prestamo da biblioteca
-- Inclúe o id do creador, o nombre e os apelidos do creador e a nacionalidade
CREATE VIEW autores_dispoñibles AS
SELECT
    c.id_creador AS id_Autor,
    c.nombre AS nombre_Autor,
    c.apellido1 AS apellido1_Autor,
    c.apellido2 AS apellido2_Autor,
    c.nacionalidad AS nacinalidad_Autor
FROM
    creador c
WHERE
    c.id_creador IN (
        SELECT
            mp.creador
        FROM
            material_prestamo mp
    ); -- Só inclúe creadores que teñan algun material creado por eles na biblioteca


    -- Para probar as vistas creadas, descomenta as seguintes liñas:
    SELECT * FROM vista_prestamos_actuales;
    SELECT * FROM vista_materiales_disponibles;
    SELECT * FROM vista_bibliotecarios;
    SELECT * FROM ordenadores_dispoñibles;
    SELECT * FROM autores_dispoñibles;