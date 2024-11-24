create table socio(
    idsocio VARCHAR(9) PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    apellido1 VARCHAR(20) NOT NULL,
    apellido2 VARCHAR(20) NOT NULL,
    fecha_nacimiento DATE NOT NULL, -- cambiado do diccionario: estes atributos non poden ser nulos
    direccion VARCHAR(30) NOT NULL,
    telefono VARCHAR(12) NOT NULL
);

CREATE TABLE empleado(
    DNI CHAR(9) PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    apellido1 VARCHAR(20) NOT NULL,
    apellido2 VARCHAR(20) NOT NULL,
    fecha_nacimiento DATE,
    fecha_inicio_contrato DATE NOT NULL,
    salario FLOAT NOT NULL
);

CREATE TABLE cargo(
    DNI_empleado CHAR(9) PRIMARY KEY,
    cargo VARCHAR(20) NOT NULL,
    FOREIGN KEY (DNI_empleado) REFERENCES empleado(DNI)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE turno(
    empleado CHAR(9) PRIMARY KEY,
    dia DATE NOT NULL,
    hora_entrada TIME NOT NULL,
    hora_salida TIME NOT NULL,
    FOREIGN KEY (empleado) REFERENCES empleado(DNI)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE material_prestamo(
    id VARCHAR(9) PRIMARY KEY,
    socio_prestamo VARCHAR(9),
    empleado_prestamo CHAR(9), --segun el modelo relacional pueden ser nulos 
    fecha_prestamo DATE, 
    tipo VARCHAR(10) NOT NULL, --libro o cd
    titulo VARCHAR(20) NOT NULL,
    fecha_publicacion DATE,
    productora VARCHAR(20),
    isbn VARCHAR(13),
    creador VARCHAR(9),
    FOREIGN KEY (socio_prestamo) REFERENCES socio(idsocio)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
    FOREIGN KEY (empleado_prestamo) REFERENCES empleado(DNI)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
    FOREIGN KEY (creador) REFERENCES creador(idcreador)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
    CHECK (tipo IN ('libro', 'CD'))
); --lo de que solo se puede reservar un libro o un cd ns como hacerlo

CREATE TABLE creador(
    idcreador VARCHAR(9) PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    apellido1 VARCHAR(20),
    apellido2 VARCHAR(20),
    fecha_nacimiento DATE,
    nacionalidad VARCHAR(20)
);

CREATE TABLE pertenecer_estilo(
    id_creador VARCHAR(9),
    estilo VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_creador) REFERENCES creador(idcreador)
    ON DELETE CASCADE
    ON UPDATE CASCADE
    PRIMARY KEY (id_creador, estilo)
);

CREATE TABLE prestamo_previo(
    fecha_prestamo DATE,
    fecha_devolucion DATE,
    socio_prestamo VARCHAR(9),
    empleado_prestamo CHAR(9),
    material VARCHAR(9),
    FOREIGN KEY (socio_prestamo) REFERENCES socio(idsocio)
    ON DELETE SET NULL
    ON UPDATE CASCADE
    FOREIGN KEY (empleado_prestamo) REFERENCES empleado(DNI)
    ON DELETE SET NULL
    ON UPDATE CASCADE
    FOREIGN KEY (material) REFERENCES material_prestamo(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
    PRIMARY KEY (fecha_prestamo, socio_prestamo, empleado_prestamo, material)
);

CREATE TABLE ordenador(
    ID_ordenador VARCHAR(9) PRIMARY KEY,
    SO VARCHAR(10),
    modelo VARCHAR(20),
    usuario  VARCHAR(9),
    fecha_prestamo DATE,
    empleado_prestamo CHAR(9),
    FOREIGN KEY (usuario) REFERENCES socio(idsocio)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
    FOREIGN KEY (empleado_prestamo) REFERENCES empleado(DNI)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

CREATE TABLE uso_previo(
    fecha_prestamo DATE,
    ID_ordenador VARCHAR(9),
    usuario  VARCHAR(9),
    fecha_devolucion DATE,
    empleado_prestamo CHAR(9),
    FOREIGN KEY (usuario) REFERENCES socio(idsocio)
    ON DELETE SET NULL
    ON UPDATE CASCADE
    FOREIGN KEY (empleado_prestamo) REFERENCES empleado(DNI)
    ON DELETE SET NULL
    ON UPDATE CASCADE
    FOREIGN KEY (ID_ordenador) REFERENCES ordenador(ID_ordenador)
    ON DELETE CASCADE
    ON UPDATE CASCADE
    PRIMARY KEY (fecha_prestamo, usuario, empleado_prestamo, ID_ordenador)
);