CREATE TABLE socio (
    idsocio VARCHAR(9) PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    apellido1 VARCHAR(20) NOT NULL,
    apellido2 VARCHAR(20) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    direccion VARCHAR(30) NOT NULL,
    telefono VARCHAR(12) NOT NULL
);

CREATE TABLE empleado (
    dni CHAR(9) PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    apellido1 VARCHAR(20) NOT NULL,
    apellido2 VARCHAR(20) NOT NULL,
    fecha_nacimiento DATE,
    fecha_inicio_contrato DATE NOT NULL,
    salario FLOAT NOT NULL
);

CREATE TABLE cargo (
    dni_empleado CHAR(9) PRIMARY KEY,
    cargo VARCHAR(20) NOT NULL,
    FOREIGN KEY (dni_empleado) REFERENCES empleado(dni)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE turno (
    empleado CHAR(9),
    dia DATE NOT NULL,
    PRIMARY KEY (empleado, dia), -- Un empleado puede tener múltiples turnos
    hora_entrada TIME NOT NULL,
    hora_salida TIME NOT NULL,
    FOREIGN KEY (empleado) REFERENCES empleado(dni)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE creador (
    idcreador VARCHAR(9) PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    apellido1 VARCHAR(20),
    apellido2 VARCHAR(20),
    fecha_nacimiento DATE,
    nacionalidad VARCHAR(20)
);

CREATE TABLE material_prestamo (
    id VARCHAR(9) PRIMARY KEY,
    tipo VARCHAR(10) NOT NULL, -- 'libro' o 'cd'
    titulo VARCHAR(20) NOT NULL,
    genero VARCHAR(20) NOT NULL,
    fecha_publicacion DATE NOT NULL,
    creador VARCHAR(9) NOT NULL,
    productora VARCHAR(20) NOT NULL,
    isbn VARCHAR(13), -- null en cds

    socio_prestamo VARCHAR(9),
    empleado_prestamo CHAR(9), -- Puede ser NULL
    fecha_prestamo DATE, 
    
    FOREIGN KEY (socio_prestamo) REFERENCES socio(idsocio)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
    FOREIGN KEY (empleado_prestamo) REFERENCES empleado(dni)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
    FOREIGN KEY (creador) REFERENCES creador(idcreador)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
    CHECK (tipo IN ('libro', 'CD'))
);

CREATE TABLE prestamo_previo (
    fecha_prestamo DATE,
    fecha_devolucion DATE,
    socio_prestamo VARCHAR(9),
    empleado_prestamo CHAR(9),
    material VARCHAR(9),
    FOREIGN KEY (socio_prestamo) REFERENCES socio(idsocio)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
    FOREIGN KEY (empleado_prestamo) REFERENCES empleado(dni)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
    FOREIGN KEY (material) REFERENCES material_prestamo(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    PRIMARY KEY (fecha_prestamo, socio_prestamo, empleado_prestamo, material)
);

CREATE TABLE ordenador (
    id_ordenador VARCHAR(9) PRIMARY KEY,
    so VARCHAR(10),
    modelo VARCHAR(20),
    usuario VARCHAR(9),
    fecha_prestamo DATE,
    empleado_prestamo CHAR(9),
    FOREIGN KEY (usuario) REFERENCES socio(idsocio)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
    FOREIGN KEY (empleado_prestamo) REFERENCES empleado(dni)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

CREATE TABLE uso_previo (
    fecha_prestamo DATE,
    id_ordenador VARCHAR(9),
    usuario VARCHAR(9),
    fecha_devolucion DATE,
    empleado_prestamo CHAR(9),
    FOREIGN KEY (usuario) REFERENCES socio(idsocio)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
    FOREIGN KEY (empleado_prestamo) REFERENCES empleado(dni)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
    FOREIGN KEY (id_ordenador) REFERENCES ordenador(id_ordenador)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    PRIMARY KEY (fecha_prestamo, usuario, empleado_prestamo, id_ordenador)
);
