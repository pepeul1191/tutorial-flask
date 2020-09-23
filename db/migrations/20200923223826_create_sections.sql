-- migrate:up

CREATE TABLE 'sections' (
	'id'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  'code'	INTEGER NOT NULL,
  'course_id'	INTEGER,
  'teacher_id'	INTEGER,
  FOREIGN KEY(`course_id`) REFERENCES 'courses' ( 'id' ) ON DELETE CASCADE,
  FOREIGN KEY(`teacher_id`) REFERENCES 'teachers' ( 'id' ) ON DELETE CASCADE
);

-- migrate:down

DROP TABLE IF EXISTS 'sections';