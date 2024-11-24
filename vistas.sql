-- Crea unha vista que amose os préstamos actuais.
-- Inclúe o id do material, o título do material, o tipo do material, o id do socio, o nome do socio, o dni do empregado, o nome do empregado e a data do préstamo.
CREATE VIEW vista_prestamos_actuales AS
SELECT 
    mp.id AS id_material,
    mp.titulo AS titulo_material,
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


-- Crea unha vista que amose os socios que teñan prestamos pendentes
-- Inclúe o id do socio, o nombre do socio, os apelidos do socio, a direccion do socio, o telefono do socio, o id do material de prestamo, a fecha do prestamo e o dni do empregado.
CREATE VIEW vista_socios_pendentes AS
SELECT
    s.id AS id_socio,
    s.nombre AS nombre_socio,
    s.apellido1 AS apellido1_socio,
    s.apellido2 AS apellido2_socio,
    s.direccion AS direccion_socio,
    s.telefono AS telefono_socio,
    mp.id AS id_material,
    mp.fecha_prestamo AS fecha_prestamo,
    mp.empleado_prestamo AS dni_empleado,
FROM 
    material_prestamo mp , socio s
WHERE
    s.id = mp.socio_prestamo
    --Só inclúe os socios con prestamos sen devolver(materiais actualmente en prestamo)

-- Crea unha vista que amose os ordenadores que non esten en uso
-- Inclúe o id do ordenador, SO do ordenador e o modelo do ordenador
CREATE VIEW ordenadores_dispoñibles AS
SELECT
    o.ID_ordenador AS ID,
    o.SO AS Sistema_Operativo,
    o.modelo AS modelo,
FROM
    ordenador o
WHERE
    o.usuario IS NULL
    --Só se inclúe os ordenadores que non teñen usuarios

-- Crea unha vista que amose os creadores que crearan algun material de prestamo da biblioteca
-- Inclúe o id do creador, o nombre e os apelidos do creador e a nacionalidade
CREATE VIEW Autores_dispoñibles AS
SELECT
    c.idcreador AS id_Autor,
    c.nombre AS nombre_Autor,
    c.apellido1 AS apellido1_Autor,
    c.apellido2 AS apellido2_Autor,
    c.nacionalidad AS nacinalidad_Autor, 
FROM
    creador c
WHERE
    c.idcreador in 
    (SELECT
        mp.idcreador 
    FROM
        material_prestamo mp)
    -- Só inclúe creadores que teñan algun material creado por eles na biblioteca

-- Crea unha vista que amose os prestamos previos que teñan socios que xa non pertencen a base de datos
-- Inclúe o id do material, o título do material, o tipo do material, a fecha do prestamo e a fecha de devolución
CREATE VIEW vista_prestamos_actuales AS
SELECT 
    mp.id AS id_material,
    mp.titulo AS titulo_material,
    mp.tipo AS tipo_material,
    pp.fecha_prestamo AS fecha_prestamo,
    pp.fecha_devolucion AS feccha_devolución,
FROM 
    material_prestamo mp, prestamo_previo pp
WHERE
    pp.socio_prestamo IS NULL
    --Só inclue os prestamos onde o socio é nulo,o que implica que o socio foi eliminado da base de datos