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
    dni CHAR(9) PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    apellido1 VARCHAR(20) NOT NULL,
    apellido2 VARCHAR(20) NOT NULL,
    fecha_nacimiento DATE,
    fecha_inicio_contrato DATE NOT NULL,
    salario FLOAT NOT NULL
);

CREATE TABLE cargo(
    dni_empleado CHAR(9) PRIMARY KEY,
    cargo VARCHAR(20) NOT NULL,
    FOREIGN KEY (DNI_empleado) REFERENCES empleado(DNI)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE turno(
    empleado CHAR(9),
    dia DATE NOT NULL,
    PRIMARY KEY (empleado, dia), -- modificado para que un empleado pueda tener múltiples turnos
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
    disponible BOOLEAN GENERATED ALWAYS AS (socio_prestamo IS NULL) STORED, -- nuevo atributo: 'disponible' si el material está disponible o no
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