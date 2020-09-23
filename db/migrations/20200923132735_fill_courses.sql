-- migrate:up

INSERT INTO courses (code, name, carrer_id) VALUES
  (101, 'Matemáticas', 1),
  (102, 'Historia', 1),
  (103, 'Psicología', 1);

-- migrate:down

DELETE FROM courses;