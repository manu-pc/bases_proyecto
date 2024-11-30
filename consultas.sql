-- seleccionar todos los socios
SELECT * FROM socio;

-- seleccionar todos los creadores
SELECT * FROM creador;

-- seleccionar todo el material
SELECT * FROM material_prestamo;

-- ver todos los prestamos previos
SELECT * FROM prestamo_previo;

-- seleccionar todos los ordenadores
SELECT * FROM ordenador;

-- Obtener todos los libros en préstamo
SELECT * FROM material_prestamo WHERE tipo = 'libro' AND socio_prestamo IS NOT NULL;

-- seleccionar todos los turnos de un empleado específico
SELECT * FROM turno WHERE empleado = '00000000Y';

-- Obtener todos los préstamos previos de un socio específico
SELECT * FROM prestamo_previo WHERE socio_prestamo = '12345678A';

-- seleccionar todos los usos previos de un ordenador específico
SELECT * FROM uso_previo WHERE id_ordenador = '987654321';

-- seleccionar todos los creadores de nacionalidad estadounidense
SELECT * FROM creador WHERE nacionalidad = 'EEUU';


-- Obtener todos los materiales prestados por un empleado específico
SELECT * FROM material_prestamo WHERE empleado_prestamo = '99999999X';

-- Obtener todos los ordenadores prestados a un socio específico
SELECT * FROM ordenador WHERE usuario = '12345678A';
