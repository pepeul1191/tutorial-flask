-- migrate:up

CREATE TABLE 'teacher_types' (
	'id'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	'name'	VARCHAR(20) NOT NULL
);

-- migrate:down

DROP TABLE IF EXISTS 'teacher_types';