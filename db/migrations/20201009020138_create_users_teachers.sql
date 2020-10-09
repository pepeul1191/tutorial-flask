-- migrate:up

CREATE TABLE 'users_teachers' (
	'id'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  'user_id'	INTEGER,
  'teacher_id'	INTEGER,
  FOREIGN KEY(`user_id`) REFERENCES 'users' ( 'id' ) ON DELETE CASCADE,
  FOREIGN KEY(`teacher_id`) REFERENCES 'teachers' ( 'id' ) ON DELETE CASCADE
);

-- migrate:down

DROP TABLE IF EXISTS 'users_teachers';