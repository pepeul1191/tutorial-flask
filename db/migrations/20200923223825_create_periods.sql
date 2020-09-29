-- migrate:up

CREATE TABLE 'periods' (
	'id'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  'name'	STRING(7) NOT NULL,
  'year'	INTEGER
);

-- migrate:down

DROP TABLE IF EXISTS 'periods';