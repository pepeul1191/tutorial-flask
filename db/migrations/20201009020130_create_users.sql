-- migrate:up

CREATE TABLE 'users' (
	'id'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT
);

-- migrate:down

DROP TABLE IF EXISTS 'users';