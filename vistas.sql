-- Crea unha vista que amose os préstamos actuais.
-- Inclúe o id do material, o título do material, o tipo do material, o id do socio, o nome do socio, o dni do empregado, o nome do empregado e a data do préstamo.
CREATE VIEW vista_prestamos_actuales AS
SELECT 
    mp.id AS id_material,
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
