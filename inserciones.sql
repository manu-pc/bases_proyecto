BEGIN;

-- tres socios
INSERT INTO socio VALUES ('12345678A', 'Alberto', 'Rey', 'Abuelo', '1980-05-15', 'Ciudad, Calle nº5', '123456789');
INSERT INTO socio VALUES ('87654321B', 'José', 'González', 'Pérez', '1975-08-20', 'Ciudad, Calle nº10', '999999999');
INSERT INTO socio VALUES ('01010101C', 'María', 'Rodríguez', 'García', '1990-12-05', 'Ciudad, Calle nº20', '000000000');

-- dos empleados
INSERT INTO empleado VALUES ('99999999X', 'Helena', 'Martín', 'Gómez', '1985-07-23', '2022-01-01', 1200);
INSERT INTO empleado VALUES ('00000000Y', 'Juan', 'Díaz', 'López', '1990-11-15', '2024-02-07', 1200);

-- un cargo para cada empleado
INSERT INTO cargo VALUES ('99999999X', 'gerente');
INSERT INTO cargo VALUES ('00000000Y', 'bibliotecario');

-- un turno previo de Juan
INSERT INTO turno VALUES ('00000000Y', '2024-04-12', '08:00:00', '14:00:00');

-- tres creadores
INSERT INTO creador VALUES ('FSFSFSFSF', 'Francis', 'Scott', 'Fitzgerald', '1896-09-24', 'EEUU');
INSERT INTO creador VALUES ('VRVRVRVRV', 'Vicente', 'Risco', 'Agüero', '1884-09-01', 'España');
INSERT INTO creador VALUES ('MJMJMJMJM', 'Michael', 'Joseph', 'Jackson', '1958-08-29', 'EEUU');

-- dos libros: uno disponible y el otro en préstamo a José
INSERT INTO material_prestamo VALUES ('AAAAAAAAA', 'libro', 'El gran Gatsby', 'Novela', '1925-04-10', 'FSFSFSFSF', 'Scribner', '9788497945479', NULL, NULL, NULL);
INSERT INTO material_prestamo VALUES ('BBBBBBBBB', 'libro', 'O porco de pé', 'Novela', '1928-01-01', 'VRVRVRVRV', 'Nós', '9738489239227', '87654321B', '00000000Y', '2022-01-01');

-- un CD prestado a María
INSERT INTO material_prestamo VALUES ('CCCCCCCCC', 'CD', 'Thriller', 'Pop', '1982-11-30', 'MJMJMJMJM', 'Epic', NULL, '01010101C', '99999999X', '2023-01-01');

-- un ordenador disponible y otro en préstamo a Alberto
INSERT INTO ordenador VALUES ('987654321', 'Linux Mint', 'Dell', NULL, NULL, NULL);
INSERT INTO ordenador VALUES ('123456789', 'Windows 10', 'HP', '12345678A', '2022-01-01', '00000000Y');

-- algunos historiales de usos previos
INSERT INTO prestamo_previo VALUES ('2021-01-01', '2021-01-15', '12345678A', '99999999X', 'AAAAAAAAA');
INSERT INTO prestamo_previo VALUES ('2021-02-01', '2021-02-15', '87654321B', '00000000Y', 'BBBBBBBBB');
INSERT INTO prestamo_previo VALUES ('2021-03-01', '2021-03-15', '01010101C', '99999999X', 'CCCCCCCCC');

INSERT INTO uso_previo VALUES ('2021-01-01', '987654321', '12345678A', '2021-01-15', '99999999X');
INSERT INTO uso_previo VALUES ('2021-02-01', '123456789', '87654321B', '2021-02-15', '00000000Y');
INSERT INTO uso_previo VALUES ('2021-03-01', '987654321', '01010101C', '2021-03-15', '99999999X');

COMMIT;
