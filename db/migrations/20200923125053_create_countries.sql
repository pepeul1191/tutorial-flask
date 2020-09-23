-- migrate:up

CREATE TABLE 'countries' (
	'id'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	'name'	VARCHAR(30) NOT NULL
);

-- migrate:down

DROP TABLE IF EXISTS 'countries';