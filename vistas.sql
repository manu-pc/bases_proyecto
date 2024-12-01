-- Crea unha vista que amose os préstamos actuais.
-- Inclúe o id do material, o título do material, o tipo do material, o id do socio, o nome do socio, o dni do empregado, o nome do empregado e a data do préstamo.
-- (Combina datos dos socios e tamén dos materiais)
CREATE VIEW vista_prestamos_actuales AS
SELECT 
    mp.id_material AS id_material,
    mp.titulo AS titpueulo_material,
    mp.tipo AS tipo_material,
    s.id_socio AS id_socio,
    s.nombre AS nombre_socio,
    e.dni AS dni_empleado,
    e.nombre AS nombre_empleado,
    mp.fecha_prestamo
FROM 
    material_prestamo mp
LEFT JOIN 
    socio s ON mp.socio_prestamo = s.id_socio
    -- úsase 'left join' para que se amose o material que non ten socio asignado
    -- (left join inclúe elementos que teñen NULL na tabla dereita, neste caso socio)
    -- en este caso socio_prestamo será NULL, o cal é posible na base de datos
LEFT JOIN 
    empleado e ON mp.empleado_prestamo = e.dni
    -- empleado pode ser null, igual que socio
WHERE 
    mp.fecha_prestamo IS NOT NULL;
    -- só inclúe os materiais actualmente en préstamo

-- Crea unha vista que amose os materiais dispoñibles.
-- Inclúe o id do material, o título do material, o tipo do material, o nome do creador e a data de publicación.
CREATE VIEW vista_materiales_disponibles AS
SELECT 
    mp.id_material AS id_material,
    mp.titulo AS titulo_material,
    mp.tipo AS tipo_material,
    c.nombre AS nombre_creador,
    mp.fecha_publicacion
FROM
    material_prestamo mp
JOIN    
    creador c ON mp.creador = c.id_creador
WHERE 
    mp.fecha_prestamo IS NULL;
    -- só inclúe os materiais dispoñibles

-- Crea unha vista que amose os empregados con cargo de bibliotecario.
-- Inclúe o dni do empregado, o nome do empregado e o seu cargo (que é bibliotecario).
CREATE VIEW vista_bibliotecarios AS
SELECT 
    e.dni AS dni_empleado,
    e.nombre AS nombre_empleado,
    c.cargo
FROM
    empleado e
JOIN
    cargo c ON e.dni = c.dni_empleado
WHERE
    c.cargo = 'bibliotecario';
    -- só inclúe os empregados con cargo de bibliotecario


-- Crea unha vista que amose os ordenadores que non esten en uso
-- Inclúe o id do ordenador, SO do ordenador e o modelo do ordenador
CREATE VIEW ordenadores_dispoñibles AS
SELECT
    o.id_ordenador AS ID,
    o.SO AS Sistema_Operativo,
    o.modelo AS modelo
FROM
    ordenador o
WHERE
    o.usuario IS NULL;
    --Só se inclúe os ordenadores que non teñen usuarios

-- Crea unha vista que amose os creadores que crearan algun material de prestamo da biblioteca
-- Inclúe o id do creador, o nombre e os apelidos do creador e a nacionalidade
CREATE VIEW Autores_dispoñibles AS
SELECT
    c.id_creador AS id_Autor,
    c.nombre AS nombre_Autor,
    c.apellido1 AS apellido1_Autor,
    c.apellido2 AS apellido2_Autor,
    c.nacionalidad AS nacinalidad_Autor 
FROM
    creador c
WHERE
    c.id_creador in 
    (SELECT
        mp.creador
    FROM
        material_prestamo mp)
    -- Só inclúe creadores que teñan algun material creado por eles na biblioteca
