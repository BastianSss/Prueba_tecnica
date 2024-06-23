CREATE DATABASE biblioteca;

USE bibliotecasys_config;

CREATE TABLE estudiantes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    documento VARCHAR(50) NOT NULL UNIQUE,
    programa VARCHAR(255) NOT NULL
);

CREATE TABLE libros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    autor VARCHAR(255) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    lugar_nacimiento VARCHAR(255) NOT NULL,
    nombre_libro VARCHAR(255) NOT NULL,
    fecha_publicacion DATE NOT NULL
);
