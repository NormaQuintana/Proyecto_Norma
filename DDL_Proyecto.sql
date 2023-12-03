DROP DATABASE IF EXISTS FEI; 
CREATE DATABASE FEI CHARACTER SET utf8mb4; 
Use FEI;

CREATE TABLE alumno (
    matricula INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    edad INT
); 

CREATE TABLE carrera (
    codCarrera INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(100) NOT NULL
); 

CREATE TABLE areaFormacion (
    codArea INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50)
);

CREATE TABLE materia (
    codMateria INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    codCarrera_carrera INT UNSIGNED NOT NULL, 
    FOREIGN KEY (codCarrera_carrera) REFERENCES carrera(codCarrera)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
    codArea_areaFormacion INT UNSIGNED NOT NULL,
    FOREIGN KEY (codArea_areaFormacion) REFERENCES areaFormacion(codArea)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
    nombre VARCHAR(50) NOT NULL,
    bloque INT NOT NULL,
    creditos INT NOT NULL,
    descripcion VARCHAR(100) NOT NULL
);

CREATE TABLE gradoEstudio (
    idGrado INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE profesor (
    numPersonal INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    idGrado_gradoEstudio INT UNSIGNED NOT NULL,
    FOREIGN KEY (idGrado_gradoEstudio) REFERENCES gradoEstudio(idGrado)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
    nombre VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
);

CREATE TABLE periodoEscolar (
    codPeriodo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    CONSTRAINT chk_fecha_inicio CHECK (fecha_inicio < fecha_fin),
    CONSTRAINT chk_fecha_fin CHECK (fecha_fin > fecha_inicio)

);

CREATE TABLE oferta (
    nrc INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    codPeriodo_periodoEscolar INT UNSIGNED NOT NULL,
    FOREIGN KEY (codPeriodo_periodoEscolar) REFERENCES periodoEscolar(codPeriodo)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
    codMateria_materia INT UNSIGNED NOT NULL,
    FOREIGN KEY (codMateria_materia) REFERENCES materia(codMateria)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
    numPersonal_profesor INT UNSIGNED NOT NULL,
    FOREIGN KEY (numPersonal_profesor) REFERENCES profesor(numPersonal)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT 
);

CREATE TABLE cursa (
    matricula_alumno INT UNSIGNED NOT NULL,
    nrc_oferta INT UNSIGNED NOT NULL,
    PRIMARY KEY(matricula_alumno, nrc_oferta),
    FOREIGN KEY (matricula_alumno) REFERENCES alumno(matricula)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
    FOREIGN KEY (nrc_oferta) REFERENCES oferta(nrc)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT, 
    calificacion FLOAT NOT NULL
);
