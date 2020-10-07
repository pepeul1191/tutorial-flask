-- migrate:up

CREATE TABLE 'teachers' (
	'id'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  'code'	INTEGER NOT NULL,
	'names'	VARCHAR(50) NOT NULL,
  'last_names'	VARCHAR(50) NOT NULL,
  'email'	VARCHAR(50),
  'personal_email'	VARCHAR(50),
  'gender_id'	INTEGER,
  'country_id'	INTEGER,
  'teacher_type_id'	INTEGER,
  'photo_url' VARCHAR(100),
  FOREIGN KEY(`gender_id`) REFERENCES 'genders' ( 'id' ) ON DELETE CASCADE,
  FOREIGN KEY(`country_id`) REFERENCES 'countries' ( 'id' ) ON DELETE CASCADE,
  FOREIGN KEY(`teacher_type_id`) REFERENCES 'teacher_types' ( 'id' ) ON DELETE CASCADE
);

-- migrate:down

DROP TABLE IF EXISTS 'teachers';