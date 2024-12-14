BEGIN;

-- inserciones de datos para poder debuggear las consultas posteriormente
-- tres socios
INSERT INTO
    socio
VALUES
    (
        DEFAULT,
        'Alberto',
        'Rey',
        'Abuelo',
        '1980-05-15',
        'Ciudad, Calle nº5',
        '123456789'
    );

INSERT INTO
    socio
VALUES
    (
        DEFAULT,
        'José',
        'González',
        'Pérez',
        '1975-08-20',
        'Ciudad, Calle nº10',
        '999999999'
    );

INSERT INTO
    socio
VALUES
    (
        DEFAULT,
        'María',
        'Rodríguez',
        'García',
        '1990-12-05',
        'Ciudad, Calle nº20',
        '000000000'
    );

-- dos empleados
INSERT INTO
    empleado
VALUES
    (
        '99999999X',
        'Helena',
        'Martín',
        'Gómez',
        '1985-07-23',
        '2022-01-01',
        1200
    );

INSERT INTO
    empleado
VALUES
    (
        '00000000Y',
        'Juan',
        'Díaz',
        'López',
        '1990-11-15',
        '2024-02-07',
        1200
    );

-- un cargo para cada empleado
INSERT INTO
    cargo
VALUES
    ('99999999X', 'bibliotecario');

INSERT INTO
    cargo
VALUES
    ('00000000Y', 'bibliotecario');

-- un turno previo de Juan y otros de Helena
INSERT INTO
    turno
VALUES
    (
        '00000000Y',
        '2024-04-12',
        '08:00:00',
        '14:00:00'
    );


INSERT INTO
    turno
VALUES
    (
        '99999999X',
        '2024-04-12',
        '14:00:00',
        '20:00:00'
    );

    INSERT INTO
        turno
    VALUES
        (
            '99999999X',
            '2024-04-13',
            '08:00:00',
            '14:00:00'
        );
-- tres creadores
INSERT INTO
    creador
VALUES
    (
        DEFAULT,
        'Francis',
        'Scott',
        'Fitzgerald',
        '1896-09-24',
        'EEUU'
    );

INSERT INTO
    creador
VALUES
    (
        DEFAULT,
        'Vicente',
        'Risco',
        'Agüero',
        '1884-09-01',
        'España'
    );

INSERT INTO
    creador
VALUES
    (
        DEFAULT,
        'Michael',
        'Joseph',
        'Jackson',
        '1958-08-29',
        'EEUU'
    );

-- dos libros: uno disponible y el otro en préstamo a José
INSERT INTO
    material_prestamo
VALUES
    (
        DEFAULT,
        'libro',
        'El gran Gatsby',
        'Novela',
        '1925-04-10',
        1000000,
        'Scribner',
        '9788497945479',
        NULL,
        NULL,
        NULL
    );

INSERT INTO
    material_prestamo
VALUES
    (
        DEFAULT,
        'libro',
        'O porco de pé',
        'Novela',
        '1928-01-01',
        1000001,
        'Nós',
        '9738489239227',
        2,
        '00000000Y',
        '2022-01-01'
    );

-- un CD prestado a María
INSERT INTO
    material_prestamo
VALUES
    (
        DEFAULT,
        'CD',
        'Thriller',
        'Pop',
        '1982-11-30',
        1000002,
        'Epic',
        NULL,
        3,
        '99999999X',
        '2023-01-01'
    );

-- un ordenador disponible, uno en préstamo a María y otro a Alberto
INSERT INTO
    ordenador
VALUES
    (DEFAULT, 'Linux Mint', 'Dell', NULL, NULL, NULL);

INSERT INTO
    ordenador
VALUES
    (
        DEFAULT,
        'Windows XP',
        'HP',
        3,
        '00000000Y',
        '2023-10-01'
    );

INSERT INTO
    ordenador
VALUES
    (
        DEFAULT,
        'Windows 10',
        'HP',
        1,
        '00000000Y',
        '2022-01-01'
    );

-- algunos historiales de usos previos
INSERT INTO
    prestamo_previo
VALUES
    (
        2000000,
        1,
        '99999999X',
        '2021-01-01',
        '2021-01-15'
    );

INSERT INTO
    prestamo_previo
VALUES
    (
        2000001,
        2,
        '00000000Y',
        '2021-02-01',
        '2021-02-15'
    );

INSERT INTO
    prestamo_previo
VALUES
    (
        2000002,
        3,
        '99999999X',
        '2021-03-01',
        '2021-03-15'
    );

INSERT INTO
    uso_previo
VALUES
    (
        3000000,
        1,
        '99999999X',
        '2021-01-01',
        '2021-01-15'
    );

INSERT INTO
    uso_previo
VALUES
    (
        3000001,
        2,
        '00000000Y',
        '2021-02-01',
        '2021-02-15'
    );

-- más creadores
INSERT INTO
    creador
VALUES
    (
        DEFAULT,
        'Gabriel',
        'García',
        'Márquez',
        '1927-03-06',
        'Colombia'
    );

INSERT INTO
    creador
VALUES
    (
        DEFAULT,
        'Miguel',
        'de Cervantes',
        'Saavedra',
        '1547-09-29',
        'España'
    );

INSERT INTO
    creador
VALUES
    (
        DEFAULT,
        'AC/DC',
        NULL,
        NULL,
        '1973-11-01',
        'Australia'
    );

INSERT INTO
    creador
VALUES
    (
        DEFAULT,
        'Pink',
        'Floyd',
        NULL,
        '1965-01-01',
        'Reino Unido'
    );

-- más libros
INSERT INTO
    material_prestamo
VALUES
    (
        DEFAULT,
        'libro',
        'Cien años de soledad',
        'Novela',
        '1967-05-30',
        1000003,
        'Sudamericana',
        '9780060883287',
        NULL,
        NULL,
        NULL
    );

INSERT INTO
    material_prestamo
VALUES
    (
        DEFAULT,
        'libro',
        'Don Quijote de la Mancha',
        'Novela',
        '1605-01-16',
        1000004,
        'Francisco de Robles',
        '9788491050223',
        NULL,
        NULL,
        NULL
    );


UPDATE
    material_prestamo
SET
    socio_prestamo = 1,
    empleado_prestamo = '00000000Y',
    fecha_prestamo = '2023-01-01'
WHERE
    titulo = 'Cien años de soledad';

-- más CDs
INSERT INTO
    material_prestamo
VALUES
    (
        DEFAULT,
        'CD',
        'Back in Black',
        'Rock',
        '1980-07-25',
        1000005,
        'Atlantic',
        NULL,
        NULL,
        NULL,
        NULL
    );

INSERT INTO
    material_prestamo
VALUES
    (
        DEFAULT,
        'CD',
        'The Dark Side of the Moon',
        'Rock',
        '1973-03-01',
        1000006,
        'Harvest',
        NULL,
        NULL,
        NULL,
        NULL
    );

-- más historiales de préstamos previos
INSERT INTO
    prestamo_previo
VALUES
    (
        2000003,
        1,
        '00000000Y',
        '2021-04-01',
        '2021-04-15'
    );

INSERT INTO
    prestamo_previo
VALUES
    (
        2000004,
        3,
        '99999999X',
        '2021-05-01',
        '2021-05-15'
    );

INSERT INTO
    prestamo_previo
VALUES
    (
        2000005,
        3,
        '00000000Y',
        '2021-06-01',
        '2021-06-15'
    );

INSERT INTO
    prestamo_previo
VALUES
    (
        2000006,
        3,
        '00000000Y',
        '2021-07-01',
        '2021-07-15'
    );

INSERT INTO
    prestamo_previo
VALUES
    (
        2000002,
        3,
        '99999999X',
        '2021-08-01',
        '2021-08-15'
    );

INSERT INTO
    prestamo_previo
VALUES
    (
        2000002,
        2,
        '00000000Y',
        '2021-09-01',
        '2021-09-15'
    );

INSERT INTO
    prestamo_previo
VALUES
    (
        2000002,
        1,
        '99999999X',
        '2021-10-01',
        '2021-10-15'
    );

-- más historiales de usos previos
INSERT INTO
    uso_previo
VALUES
    (
        3000002,
        1,
        '00000000Y',
        '2021-03-01',
        '2021-03-15'
    );

INSERT INTO
    uso_previo
VALUES
    (
        3000001,
        1,
        '00000000Y',
        '2021-04-01',
        '2021-04-15'
    );

INSERT INTO
    uso_previo
VALUES
    (
        3000002,
        1,
        '00000000Y',
        '2021-05-01',
        '2021-05-15'
    );

INSERT INTO
    uso_previo
VALUES
    (
        3000001,
        3,
        '00000000Y',
        '2021-06-01',
        '2021-06-15'
    );

-- estilos para los creadores
INSERT INTO
    pertenecer_estilo
VALUES
    (1000000, 'Modernismo');

-- Fitzgerald
INSERT INTO
    pertenecer_estilo
VALUES
    (1000001, 'Realismo');

-- Risco
INSERT INTO
    pertenecer_estilo
VALUES
    (1000001, 'Crítica social');

-- Risco
INSERT INTO
    pertenecer_estilo
VALUES
    (1000002, 'Pop');

-- Jackson
INSERT INTO
    pertenecer_estilo
VALUES
    (1000003, 'Realismo Mágico');

-- García Márquez
INSERT INTO
    pertenecer_estilo
VALUES
    (1000004, 'Renacimiento');

-- Cervantes
INSERT INTO
    pertenecer_estilo
VALUES
    (1000005, 'Rock');

-- AC/DC
INSERT INTO
    pertenecer_estilo
VALUES
    (1000006, 'Rock');

-- Pink Floyd
INSERT INTO
    pertenecer_estilo
VALUES
    (1000006, 'Rock Progresivo');

-- Pink Floyd
COMMIT;