-- Roles
INSERT INTO Rol (nombreRol) VALUES ('ADMIN');
INSERT INTO Rol (nombreRol) VALUES ('USER');

-- Insertar Administrador
INSERT INTO Administradores (id, nombre, email, pwd)
VALUES (1, 'Lucía', 'lucia@acme.com', '0192023a7bbd73250516f069df18b500');--admin123 es la PWD

-- Insertar Redactor
INSERT INTO Redactor (id, nombre, apellido, dni, email, pwd)
VALUES (1, 'Carlos', 'Pérez', '12345678A', 'carlos@acme.com', 'pass123');

-- Categorías
INSERT INTO Categorias (nombre, descripcion) VALUES ('Tecnología', 'Artículos sobre innovación y tecnología.');
INSERT INTO Categorias (nombre, descripcion) VALUES ('Salud', 'Contenido relacionado con bienestar y salud.');

-- Artículos
-- Nota: debes conocer los ID reales generados al insertar Redactor y Categoría. Si estás usando `create`, serán 1 y 1.
INSERT INTO Articulos (titulo, cuerpo, fecha, redactor_id, categoria_id) VALUES (
  'La revolución de la IA',
  'El impacto de la inteligencia artificial en el mundo moderno...',
  '2025-05-18',
  1,
  1
);

INSERT INTO Articulos (titulo, cuerpo, fecha, redactor_id, categoria_id) VALUES (
  'Cuidando la salud mental',
  'Importancia del autocuidado y la salud emocional...',
  '2025-05-18',
  1,
  2
);

-- Comentarios
INSERT INTO Comentarios (nombre, cuerpo, fecha, articulo_id) VALUES (
  'Ana',
  'Muy interesante, gracias por compartir.',
  '2025-05-18',
  1
);

INSERT INTO Comentarios (nombre, cuerpo, fecha, articulo_id) VALUES (
  'Luis',
  'Gran aporte sobre el tema de salud.',
  '2025-05-18',
  2
);
