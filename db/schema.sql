CREATE TABLE schema_migrations (version varchar(255) primary key);
CREATE TABLE 'genders' (
	'id'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	'name'	VARCHAR(15) NOT NULL
);
CREATE TABLE 'carrers' (
	'id'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	'name'	VARCHAR(25) NOT NULL
);
CREATE TABLE 'countries' (
	'id'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	'name'	VARCHAR(30) NOT NULL
);
CREATE TABLE 'students' (
	'id'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  'code'	INTEGER NOT NULL,
	'names'	VARCHAR(50) NOT NULL,
  'last_names'	VARCHAR(50) NOT NULL,
  'email'	VARCHAR(50),
  'personal_email'	VARCHAR(50),
  'gender_id'	INTEGER,
  'carrer_id'	INTEGER,
  'country_id'	INTEGER,
  FOREIGN KEY(`gender_id`) REFERENCES 'genders' ( 'id' ) ON DELETE CASCADE,
  FOREIGN KEY(`carrer_id`) REFERENCES 'carrers' ( 'id' ) ON DELETE CASCADE,
  FOREIGN KEY(`country_id`) REFERENCES 'countries' ( 'id' ) ON DELETE CASCADE
);
CREATE TABLE 'courses' (
	'id'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  'code'	INTEGER NOT NULL,
	'name'	VARCHAR(25) NOT NULL,
  'carrer_id'	INTEGER,
  FOREIGN KEY(`carrer_id`) REFERENCES 'carrers' ( 'id' ) ON DELETE CASCADE
);
CREATE TABLE 'teachers' (
	'id'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  'code'	INTEGER NOT NULL,
	'names'	VARCHAR(50) NOT NULL,
  'last_names'	VARCHAR(50) NOT NULL,
  'email'	VARCHAR(50),
  'personal_email'	VARCHAR(50),
  'gender_id'	INTEGER,
  'country_id'	INTEGER,
  FOREIGN KEY(`gender_id`) REFERENCES 'genders' ( 'id' ) ON DELETE CASCADE,
  FOREIGN KEY(`country_id`) REFERENCES 'countries' ( 'id' ) ON DELETE CASCADE
);
CREATE TABLE 'sections' (
	'id'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  'code'	INTEGER NOT NULL,
  'course_id'	INTEGER,
  'teacher_id'	INTEGER,
  FOREIGN KEY(`course_id`) REFERENCES 'courses' ( 'id' ) ON DELETE CASCADE,
  FOREIGN KEY(`teacher_id`) REFERENCES 'teachers' ( 'id' ) ON DELETE CASCADE
);
CREATE TABLE 'sections_students' (
	'id'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  'section_id'	INTEGER,
  'student_id'	INTEGER,
  FOREIGN KEY(`section_id`) REFERENCES 'sections' ( 'id' ) ON DELETE CASCADE,
  FOREIGN KEY(`student_id`) REFERENCES 'students' ( 'id' ) ON DELETE CASCADE
);
-- Dbmate schema migrations
INSERT INTO schema_migrations (version) VALUES
  ('20200923124142'),
  ('20200923124241'),
  ('20200923124923'),
  ('20200923125052'),
  ('20200923125053'),
  ('20200923125539'),
  ('20200923132228'),
  ('20200923132735'),
  ('20200923133317'),
  ('20200923223826'),
  ('20200923223844');
