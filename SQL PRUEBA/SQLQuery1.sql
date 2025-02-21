-- Crear la base de datos 
CREATE DATABASE Veterinaria; 
GO 
-- Usar la base de datos 
USE Veterinaria; 
GO 
-- Crear la tabla de propietarios
CREATE TABLE Propietarios (    
	PropietarioId INT PRIMARY KEY,     
	Nombre VARCHAR(50),     
	Apellido VARCHAR(50),     
	Direccion VARCHAR(100),     
	Telefono VARCHAR(15)
);
GO
-- Crear la tabla de mascotas
CREATE TABLE Mascotas (
    MascotaId INT PRIMARY KEY,
    PropietarioId INT,
    Nombre VARCHAR(50),
    Especie VARCHAR(50),
    Raza VARCHAR(50),
    Edad INT,
    CONSTRAINT FK_Propietario_Mascota FOREIGN KEY (PropietarioId) REFERENCES Propietarios (PropietarioId)
);
GO
-- Crear la tabla de visitas
CREATE TABLE Visitas (
    VisitaId INT PRIMARY KEY,
    MascotaId INT,
    Fecha DATE,
    Observaciones VARCHAR(200),
    CONSTRAINT FK_Mascota_Visita FOREIGN KEY (MascotaId) REFERENCES Mascotas (MascotaId)
);
GO
-- Crear la tabla de tratamientos
CREATE TABLE Tratamientos (
    TratamientoId INT PRIMARY KEY,
    VisitaId INT,
    Descripcion VARCHAR(200),
    Precio DECIMAL(8, 2),
    CONSTRAINT FK_Visita_Tratamiento FOREIGN KEY (VisitaId) REFERENCES Visitas (VisitaId)
);



-- Insertar datos en la tabla Propietarios
INSERT INTO Propietarios (PropietarioID, Nombre, Apellido, Direccion, Telefono)
VALUES (1, 'Juan', 'Perez', 'Calle 123', '1234567890'),
       (2, 'Maria', 'Lopez', 'Avenida 456', '0987654321'),
       (3, 'Carlos', 'Gonzalez', 'Plaza 789', '4567890123'),
       (4, 'Camila', 'Rosales', 'Calle 44', '4567890123'),
       (5, 'Luz', 'Casta�o', 'Calle 78', '4567890123'),
       (6, 'Gloria', 'Ramirez', 'Avenida 55', '4567890123'),
       (7, 'Roberto', 'Gaviria', 'Calle 41', '4567890123');

-- Insertar datos en la tabla Mascotas
INSERT INTO Mascotas (MascotaID, PropietarioID, Nombre, Especie, Raza, Edad)
VALUES (1, 1, 'Luna', 'Perro', 'Labrador', 5),
       (2, 1, 'Max', 'Gato', 'Siames', 3),
       (3, 2, 'Bella', 'Perro', 'Bulldog', 2),
       (4, 3, 'Simba', 'Gato', 'Persa', 1),
       (5, 4, 'Rayo', 'Gato', 'Persa', 1),
       (6, 5, 'Kira', 'Perro', 'Labrador', 1),
       (7, 6, 'Rocky', 'Perro', 'Labrador', 1),
       (8, 7, 'Zeus', 'Gato', 'Persa', 1);

-- Insertar datos en la tabla Visitas
INSERT INTO Visitas (VisitaID, MascotaID, Fecha, Observaciones)
VALUES (1, 1, '2023-06-01', 'Vacunaci�n anual'),
       (2, 2, '2023-06-02', 'Control de peso'),
       (3, 3, '2023-06-03', 'Desparasitaci�n'),
       (4, 4, '2023-05-12', 'Revisi�n general'),
       (5, 4, '2023-03-06', 'Revisi�n general'),
       (6, 5, '2023-06-04', 'Control de peso'),
       (7, 6, '2023-01-23', 'Revisi�n general'),
       (8, 7, '2023-01-01', 'Revisi�n general'),
       (9, 7, '2023-01-09', 'Control de peso'),
       (10, 7, '2023-06-05', 'Vacunaci�n anual'),
       (11, 8, '2023-04-04', 'Vacunaci�n anual'),
       (12, 8, '2023-04-03', 'Control de peso'),
       (13, 2, '2023-04-06', 'Revisi�n general'),
       (14, 3, '2023-03-16', 'Control de peso'),
       (15, 4, '2023-02-18', 'Vacunaci�n anual'),
       (16, 6, '2023-02-26', 'Desparasitaci�n'),
       (17, 7, '2023-02-25', 'Revisi�n general'),
       (19, 1, '2023-02-04', 'Desparasitaci�n'),
       (21, 2, '2023-01-04', 'Revisi�n general');

-- Insertar datos en la tabla Tratamientos
INSERT INTO Tratamientos (TratamientoID, VisitaID, Descripcion, Precio)
VALUES (1, 1, 'Vacuna DHPP', 50000),
       (2, 2, 'Consulta veterinaria', 30000),
       (3, 3, 'Desparasitante oral', 15000),
       (4, 4, 'Examen de sangre', 48000),
       (5, 5, 'Consulta veterinaria', 170000),
       (6, 6, 'Examen de sangre', 35000),
       (7, 7, 'Examen de sangre', 18000),
       (8, 7, 'Vacuna DHPP', 49000),
       (9, 7, 'Desparasitante oral', 15000),
       (10, 8, 'Consulta veterinaria', 37000),
       (11, 9, 'Examen de sangre', 86000),
       (12, 10, 'Desparasitante oral', 15000),
       (13, 11, 'Consulta veterinaria', 23000),
       (14, 12, 'Vacuna DHPP', 64000),
       (15, 13, 'Desparasitante oral', 10000),
       (16, 14, 'Examen de sangre', 78000),
       (17, 15, 'Desparasitante oral', 62000),
       (18, 16, 'Desparasitante oral', 31000);



--1)Realizar una consulta que muestre nombre de la mascota, nombre de propietario, 
-- nombre de la visita y fecha de la visita, de las mascotas que les realizaron desparasitaci�n:
SELECT 
    m.Nombre AS NombreMascota,
    p.Nombre AS NombrePropietario,
    v.Observaciones AS NombreVisita,
    v.Fecha
FROM 
    Mascotas m
JOIN 
    Propietarios p ON m.PropietarioId = p.PropietarioId
JOIN 
    Visitas v ON m.MascotaId = v.MascotaId
WHERE 
    v.Observaciones LIKE '%Desparasitaci�n%';



--2) Listar s�lo la informaci�n de las mascotas que tuvieron revisi�n en el mes de enero
SELECT 
    m.*
FROM 
    Mascotas m
JOIN 
    Visitas v ON m.MascotaId = v.MascotaId
WHERE 
    v.Observaciones LIKE '%Revisi�n%' AND
    MONTH(v.Fecha) = 1;


--3)Listar las visitas que tuvieron las mascotas de Juan P�rez:
SELECT 
    v.*
FROM 
    Visitas v
JOIN 
    Mascotas m ON v.MascotaId = m.MascotaId
JOIN 
    Propietarios p ON m.PropietarioId = p.PropietarioId
WHERE 
    p.Nombre = 'Juan' AND
    p.Apellido = 'Perez';


--4)Realizar una consulta que muestre el nombre de la mascota y el n�mero de visitas 
-- que ha tenido en el veterinario:
SELECT 
    m.Nombre AS NombreMascota,
    COUNT(v.VisitaId) AS NumeroVisitas
FROM 
    Mascotas m
JOIN 
    Visitas v ON m.MascotaId = v.MascotaId
GROUP BY 
    m.Nombre;


--5) Ordenar de mayor a menor el valor de los tratamientos de todos los gatos:
SELECT 
    t.*
FROM 
    Tratamientos t
JOIN 
    Visitas v ON t.VisitaId = v.VisitaId
JOIN 
    Mascotas m ON v.MascotaId = m.MascotaId
WHERE 
    m.Especie = 'Gato'
ORDER BY 
    t.Precio DESC;


--6) Mostrar el valor total de todos los tratamientos de la Vacuna DHPP:
SELECT 
    SUM(t.Precio) AS ValorTotal
FROM 
    Tratamientos t
WHERE 
    t.Descripcion = 'Vacuna DHPP';


--7)
SELECT 
    p.Nombre AS NombrePropietario,
    p.Apellido AS ApellidoPropietario
FROM 
    Propietarios p
JOIN 
    Mascotas m ON p.PropietarioId = m.PropietarioId
WHERE 
    m.Nombre = 'Kira';  -- Reemplazar 'NombreDeLaMascota' con el nombre real de la mascota

--8)
SELECT 
    m.*
FROM 
    Mascotas m
JOIN 
    Visitas v ON m.MascotaId = v.MascotaId
WHERE 
    m.Raza = 'Labrador' AND
    v.Observaciones LIKE '%Revisi�n general%';