BEGIN;
-- inserciones de datos para poder debuggear las consultas posteriormente


-- tres socios
INSERT INTO socio VALUES (DEFAULT, 'Alberto', 'Rey', 'Abuelo', '1980-05-15', 'Ciudad, Calle nº5', '123456789');
INSERT INTO socio VALUES (DEFAULT, 'José', 'González', 'Pérez', '1975-08-20', 'Ciudad, Calle nº10', '999999999');
INSERT INTO socio VALUES (DEFAULT, 'María', 'Rodríguez', 'García', '1990-12-05', 'Ciudad, Calle nº20', '000000000');

-- dos empleados
INSERT INTO empleado VALUES ('99999999X', 'Helena', 'Martín', 'Gómez', '1985-07-23', '2022-01-01', 1200);
INSERT INTO empleado VALUES ('00000000Y', 'Juan', 'Díaz', 'López', '1990-11-15', '2024-02-07', 1200);

-- un cargo para cada empleado
INSERT INTO cargo VALUES ('99999999X', 'gerente');
INSERT INTO cargo VALUES ('00000000Y', 'bibliotecario');

-- un turno previo de Juan
INSERT INTO turno VALUES ('00000000Y', '2024-04-12', '08:00:00', '14:00:00');

-- tres creadores
INSERT INTO creador VALUES (DEFAULT, 'Francis', 'Scott', 'Fitzgerald', '1896-09-24', 'EEUU');
INSERT INTO creador VALUES (DEFAULT, 'Vicente', 'Risco', 'Agüero', '1884-09-01', 'España');
INSERT INTO creador VALUES (DEFAULT, 'Michael', 'Joseph', 'Jackson', '1958-08-29', 'EEUU');

-- dos libros: uno disponible y el otro en préstamo a José
INSERT INTO material_prestamo VALUES (DEFAULT, 'libro', 'El gran Gatsby', 'Novela', '1925-04-10', 1000000, 'Scribner', '9788497945479', NULL, NULL, NULL);
INSERT INTO material_prestamo VALUES (DEFAULT, 'libro', 'O porco de pé', 'Novela', '1928-01-01', 1000001, 'Nós', '9738489239227', 0000002, '00000000Y', '2022-01-01');

-- un CD prestado a María
INSERT INTO material_prestamo VALUES (DEFAULT, 'CD', 'Thriller', 'Pop', '1982-11-30', 1000002, 'Epic', NULL, 0000003, '99999999X', '2023-01-01');

-- un ordenador disponible y otro en préstamo a Alberto
INSERT INTO ordenador VALUES (DEFAULT, 'Linux Mint', 'Dell', NULL, NULL, NULL);
INSERT INTO ordenador VALUES (DEFAULT, 'Windows 10', 'HP', 0000001, '2022-01-01', '00000000Y');


-- algunos historiales de usos previos
INSERT INTO prestamo_previo VALUES ('2021-01-01', '2021-01-15', 0000001, '99999999X', 2000000);
INSERT INTO prestamo_previo VALUES ('2021-02-01', '2021-02-15', 0000002, '00000000Y', 2000001);
INSERT INTO prestamo_previo VALUES ('2021-03-01', '2021-03-15', 0000003, '99999999X', 2000002);


INSERT INTO uso_previo VALUES ('2021-01-01', 3000000, 0000001, '2021-01-15', '99999999X');
INSERT INTO uso_previo VALUES ('2021-02-01', 3000001, 0000002, '2021-02-15', '00000000Y');

COMMIT;
