-- migrate:up

CREATE TABLE 'sections_teachers' (
	'id'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  'section_id'	INTEGER,
  'teacher_id'	INTEGER,
  FOREIGN KEY(`section_id`) REFERENCES 'sections' ( 'id' ) ON DELETE CASCADE,
  FOREIGN KEY(`teacher_id`) REFERENCES 'teachers' ( 'id' ) ON DELETE CASCADE
);

-- migrate:down

DROP TABLE IF EXISTS 'sections_teachers';