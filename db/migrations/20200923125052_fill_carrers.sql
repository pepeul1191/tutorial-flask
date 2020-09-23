-- migrate:up

INSERT INTO carrers (id, name) VALUES
  (1, 'Estudios General'),
  (2, 'Administracion'),
  (3, 'Economía'),
  (4, 'Derecho'),
  (5, 'Ingeniería');

-- migrate:down

DELETE FROM carrers;