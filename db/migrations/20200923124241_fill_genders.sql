-- migrate:up

INSERT INTO genders (id, name) VALUES
  (1, 'male'),
  (2, 'female');

-- migrate:down

DELETE FROM genders;