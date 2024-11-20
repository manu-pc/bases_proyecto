create table socio(
    idsocio VARCHAR(9) PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    apellido1 VARCHAR(20) NOT NULL,
    apellido2 VARCHAR(20) NOT NULL,
    fecha_nacimiento DATE NOT NULL, -- cambiado do diccionario: estes atributos non poden ser nulos
    direccion VARCHAR(30) NOT NULL,
    telefono VARCHAR(12) NOT NULL,
)

