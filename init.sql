CREATE DATABASE IF NOT EXISTS acmeNoticiasDB 
    DEFAULT CHARACTER SET utf8 
    DEFAULT COLLATE utf8_general_ci;

USE acmeNoticiasDB;

-- Tabla: Administradores
CREATE TABLE Administradores (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    email VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL UNIQUE,
    pwd VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL
) CHARACTER SET utf8 COLLATE utf8_general_ci;

-- Tabla: Redactor
CREATE TABLE Redactor (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    apellido VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    dni VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL UNIQUE,
    email VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL UNIQUE,
    pwd VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    rutaimg VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci
) CHARACTER SET utf8 COLLATE utf8_general_ci;

-- Tabla: Categorias
CREATE TABLE Categorias (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    descripcion TEXT CHARACTER SET utf8 COLLATE utf8_general_ci
) CHARACTER SET utf8 COLLATE utf8_general_ci;

-- Tabla: Articulos
CREATE TABLE Articulos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    cuerpo TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    fecha VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    redactor_id BIGINT,
    categoria_id BIGINT,
    FOREIGN KEY (redactor_id) REFERENCES Redactor(id) ON DELETE SET NULL,
    FOREIGN KEY (categoria_id) REFERENCES Categorias(id) ON DELETE SET NULL
) CHARACTER SET utf8 COLLATE utf8_general_ci;

-- Tabla: Comentarios
CREATE TABLE Comentarios (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    cuerpo TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    fecha VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    desactivado BOOLEAN NOT NULL DEFAULT FALSE,
    articulo_id BIGINT,
    FOREIGN KEY (articulo_id) REFERENCES Articulos(id) ON DELETE CASCADE
) CHARACTER SET utf8 COLLATE utf8_general_ci;

-- Datos de ejemplo
-- Administradores
INSERT INTO Administradores (nombre, email, pwd)
VALUES 
('Lucia', 'lucia@acme.com', '0192023a7bbd73250516f069df18b500'); -- admin123

-- Redactores
INSERT INTO Redactor (nombre, apellido, dni, email, pwd, rutaimg)
VALUES 
('Carlos', 'Perez', '12345678A', 'carlos@acme.com', '32250170a0dca92d53ec9624f336ca24', null),
('Ana', 'Lopez', '87654321B', 'ana@acme.com', '32250170a0dca92d53ec9624f336ca24', null),
('Diego', 'Martinez', '45678901C', 'diego@acme.com', '32250170a0dca92d53ec9624f336ca24', null);

-- Categorias
INSERT INTO Categorias (nombre, descripcion) VALUES
('Tecnologia', 'Articulos sobre innovacion y tecnologia.'),
('Salud', 'Contenido relacionado con bienestar y salud.'),
('Educacion', 'Temas educativos, aprendizaje y pedagogia.'),
('Cultura', 'Noticias sobre arte, cine, musica y mas.');

-- Articulos
INSERT INTO Articulos (titulo, cuerpo, fecha, redactor_id, categoria_id) VALUES
('La revolucion de la IA', 'El impacto de la inteligencia artificial en el mundo moderno...', '2025-05-18', 1, 1),
('Cuidando la salud mental', 'Importancia del autocuidado y la salud emocional...', '2025-05-18', 1, 2),
('Tendencias educativas 2025', 'Nuevas metodologias que cambiaran la forma de ensenar...', '2025-05-19', 2, 3),
('La musica como forma de protesta', 'Analisis de como los artistas utilizan su voz...', '2025-05-19', 2, 4),
('Tecnologia en la educacion', 'La integracion de nuevas tecnologias en el aula...', '2025-05-20', 3, 1),
('Alimentacion saludable', 'Consejos para una dieta equilibrada y sostenible...', '2025-05-20', 3, 2);

-- Comentarios
INSERT INTO Comentarios (nombre, cuerpo, fecha, articulo_id) VALUES
('Ana', 'Muy interesante, gracias por compartir.', '2025-05-18', 1),
('Luis', 'Gran aporte sobre el tema de salud.', '2025-05-18', 2),
('Maria', 'Este articulo me ayudo mucho, gracias.', '2025-05-19', 3),
('Pedro', 'La cultura tambien puede ser politica.', '2025-05-19', 4),
('Javier', 'Muy buen enfoque educativo.', '2025-05-20', 5),
('Lucia', 'Interesante como se conecta la tecnologia con el aula.', '2025-05-20', 5),
('Clara', 'Cuidado con los mitos sobre alimentacion.', '2025-05-20', 6),
('Sofia', 'Gracias por los consejos de salud.', '2025-05-20', 2);
