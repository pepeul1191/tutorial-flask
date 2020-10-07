-- migrate:up

INSERT INTO periods (id, name) VALUES
  (1, '2020-0'),
  (2, '2020-I');

-- migrate:down

DELETE FROM periods;