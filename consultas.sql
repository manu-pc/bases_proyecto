-- seleccionar todos los socios
SELECT * FROM socio;

-- seleccionar todos los creadores
SELECT * FROM creador;

-- seleccionar los nombres, tipos e id de todos los materiales
SELECT titulo, tipo, id_material FROM material_prestamo;

-- seleccionar todos los ordenadores
SELECT * FROM ordenador;

-- Obtener todos los libros en préstamo
SELECT * FROM material_prestamo WHERE tipo = 'libro' AND socio_prestamo IS NOT NULL;

-- seleccionar todos los turnos de un empleado específico (Juan)
SELECT * FROM turno WHERE empleado = '00000000Y';

-- Obtener todos los préstamos previos de un socio específico
SELECT * FROM prestamo_previo WHERE socio_prestamo = 1;

-- seleccionar todos los usos previos de un ordenador específico
SELECT * FROM uso_previo WHERE id_ordenador = 3000000;

-- seleccionar todos los nombres de los creadores de nacionalidad estadounidense
SELECT nombre, apellido1, apellido2 FROM creador WHERE nacionalidad = 'EEUU';

