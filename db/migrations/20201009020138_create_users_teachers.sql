-- migrate:up

CREATE TABLE 'users_teachers' (
	'id'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  'user_id'	INTEGER,
  'teacher_id'	INTEGER,
  'user'	VARCHAR(45),
  'pass'	VARCHAR(45),
  'reset_key'	VARCHAR(45),
  'activation_key'	VARCHAR(45),
  FOREIGN KEY(`user_id`) REFERENCES 'users' ( 'id' ) ON DELETE CASCADE,
  FOREIGN KEY(`teacher_id`) REFERENCES 'teachers' ( 'id' ) ON DELETE CASCADE
);

-- migrate:down

DROP TABLE IF EXISTS 'users_teachers';