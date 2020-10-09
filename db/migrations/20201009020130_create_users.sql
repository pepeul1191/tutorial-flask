-- migrate:up

CREATE TABLE 'users' (
	'id'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	'url_picture'	VARCHAR(150) NOT NULL
);

-- migrate:down

DROP TABLE IF EXISTS 'users';