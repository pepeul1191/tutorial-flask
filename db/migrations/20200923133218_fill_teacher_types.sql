-- migrate:up

INSERT INTO teacher_types (id, name) VALUES
  (1, 'Profesor'),
  (2, 'Jefe de Prácticas');

-- migrate:down

DELETE FROM teacher_types;