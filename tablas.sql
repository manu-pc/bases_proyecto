-- 
DROP TABLE IF EXISTS uso_previo CASCADE;
DROP TABLE IF EXISTS ordenador CASCADE;
DROP TABLE IF EXISTS prestamo_previo CASCADE;
DROP TABLE IF EXISTS material_prestamo CASCADE;
DROP TABLE IF EXISTS creador CASCADE;
DROP TABLE IF EXISTS turno CASCADE;
DROP TABLE IF EXISTS cargo CASCADE;
DROP TABLE IF EXISTS empleado CASCADE;
DROP TABLE IF EXISTS socio CASCADE;
DROP SEQUENCE IF EXISTS ordenador_seq CASCADE;
DROP SEQUENCE IF EXISTS material_seq CASCADE;
DROP SEQUENCE IF EXISTS creador_seq CASCADE;
DROP SEQUENCE IF EXISTS socio_prestamo_seq CASCADE;

CREATE SEQUENCE socio_prestamo_seq;
CREATE TABLE socio (
    id_socio INT PRIMARY KEY DEFAULT NEXTVAL('socio_prestamo_seq'),
    nombre VARCHAR(20) NOT NULL,
    apellido1 VARCHAR(20) NOT NULL,
    apellido2 VARCHAR(20) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    direccion VARCHAR(30) NOT NULL,
    telefono VARCHAR(12) NOT NULL
);


CREATE TABLE empleado (
    dni char(9) PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    apellido1 VARCHAR(20) NOT NULL,
    apellido2 VARCHAR(20) NOT NULL,
    fecha_nacimiento DATE,
    fecha_inicio_contrato DATE NOT NULL,
    salario FLOAT NOT NULL
);
CREATE TABLE cargo (
    dni_empleado char(9) PRIMARY KEY,
    cargo VARCHAR(20) NOT NULL,
    FOREIGN KEY (dni_empleado) REFERENCES empleado(dni) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE turno (
    empleado char(9),
    dia DATE NOT NULL,
    PRIMARY KEY (empleado, dia),
    -- Un empleado puede tener múltiples turnos
    hora_entrada TIME NOT NULL,
    hora_salida TIME NOT NULL,
    FOREIGN KEY (empleado) REFERENCES empleado(dni) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE SEQUENCE creador_seq START 1000000;
CREATE TABLE creador (
    id_creador INT PRIMARY KEY DEFAULT NEXTVAL('creador_seq'),
    nombre VARCHAR(20) NOT NULL,
    apellido1 VARCHAR(20),
    apellido2 VARCHAR(20),
    fecha_nacimiento DATE,
    nacionalidad VARCHAR(20)
);
CREATE SEQUENCE material_seq START 2000000;
CREATE TABLE material_prestamo (
    id_material INT PRIMARY KEY DEFAULT NEXTVAL('material_seq'),
    tipo VARCHAR(5) NOT NULL,
    -- 'libro' o 'cd'
    titulo VARCHAR(20) NOT NULL,
    genero VARCHAR(20) NOT NULL,
    fecha_publicacion DATE NOT NULL,
    creador INT NOT NULL,
    productora VARCHAR(20) NOT NULL,
    isbn VARCHAR(13),
    -- null en cds
    socio_prestamo INT,
    empleado_prestamo CHAR(9),
    -- Puede ser NULL
    fecha_prestamo DATE,
    FOREIGN KEY (socio_prestamo) REFERENCES socio(id_socio) ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (empleado_prestamo) REFERENCES empleado(dni) ON DELETE
    SET NULL ON UPDATE CASCADE,
        FOREIGN KEY (creador) REFERENCES creador(id_creador) ON DELETE NO ACTION ON UPDATE CASCADE,
        CHECK (tipo IN ('libro', 'CD'))
);
CREATE TABLE prestamo_previo (
    fecha_prestamo DATE,
    fecha_devolucion DATE,
    socio_prestamo INT,
    empleado_prestamo CHAR(9),
    material INT,
    FOREIGN KEY (socio_prestamo) REFERENCES socio(id_socio) ON DELETE
    SET NULL ON UPDATE CASCADE,
        FOREIGN KEY (empleado_prestamo) REFERENCES empleado(dni) ON DELETE
    SET NULL ON UPDATE CASCADE,
        FOREIGN KEY (material) REFERENCES material_prestamo(id_material) ON DELETE CASCADE ON UPDATE CASCADE,
        PRIMARY KEY (
            fecha_prestamo,
            socio_prestamo,
            empleado_prestamo,
            material
        )
);
CREATE SEQUENCE ordenador_seq START 3000000;
CREATE TABLE ordenador (
    id_ordenador INT PRIMARY KEY DEFAULT NEXTVAL('ordenador_seq'),
    so VARCHAR(20),
    modelo VARCHAR(20),
    usuario INT,
    fecha_prestamo DATE,
    empleado_prestamo CHAR(9),
    FOREIGN KEY (usuario) REFERENCES socio(id_socio) ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (empleado_prestamo) REFERENCES empleado(dni) ON DELETE
    SET NULL ON UPDATE CASCADE
);
CREATE TABLE uso_previo (
    fecha_prestamo DATE,
    id_ordenador INT,
    usuario INT,
    fecha_devolucion DATE,
    empleado_prestamo char(9),
    FOREIGN KEY (usuario) REFERENCES socio(id_socio) ON DELETE
    SET NULL ON UPDATE CASCADE,
        FOREIGN KEY (empleado_prestamo) REFERENCES empleado(dni) ON DELETE
    SET NULL ON UPDATE CASCADE,
        FOREIGN KEY (id_ordenador) REFERENCES ordenador(id_ordenador) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (
        fecha_prestamo,
        usuario,
        empleado_prestamo,
        id_ordenador
    )
);





