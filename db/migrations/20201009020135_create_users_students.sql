-- migrate:up

CREATE TABLE 'users_students' (
	'id'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  'user_id'	INTEGER,
  'student_id'	INTEGER,
  FOREIGN KEY(`user_id`) REFERENCES 'users' ( 'id' ) ON DELETE CASCADE,
  FOREIGN KEY(`student_id`) REFERENCES 'students' ( 'id' ) ON DELETE CASCADE
);

-- migrate:down

DROP TABLE IF EXISTS 'users_students';