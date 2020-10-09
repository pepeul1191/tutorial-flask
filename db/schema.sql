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
  'tw_user' VARCHAR(25),
  'tw_pass' VARCHAR(25),
  'ad_user' VARCHAR(25),
  'gender_id'	INTEGER,
  'carrer_id'	INTEGER,
  'country_id'	INTEGER,
  'photo_url' VARCHAR(100),
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
CREATE TABLE 'teacher_types' (
	'id'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	'name'	VARCHAR(20) NOT NULL
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
  'teacher_type_id'	INTEGER,
  'photo_url' VARCHAR(100),
  FOREIGN KEY(`gender_id`) REFERENCES 'genders' ( 'id' ) ON DELETE CASCADE,
  FOREIGN KEY(`country_id`) REFERENCES 'countries' ( 'id' ) ON DELETE CASCADE,
  FOREIGN KEY(`teacher_type_id`) REFERENCES 'teacher_types' ( 'id' ) ON DELETE CASCADE
);
CREATE TABLE 'periods' (
	'id'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  'name'	STRING(7) NOT NULL,
  'year'	INTEGER
);
CREATE TABLE 'sections' (
	'id'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  'code'	INTEGER NOT NULL,
  'course_id'	INTEGER,
  'period_id'	INTEGER,
  FOREIGN KEY(`course_id`) REFERENCES 'courses' ( 'id' ) ON DELETE CASCADE,
  FOREIGN KEY(`period_id`) REFERENCES 'periods' ( 'id' ) ON DELETE CASCADE
);
CREATE TABLE 'sections_students' (
	'id'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  'section_id'	INTEGER,
  'student_id'	INTEGER,
  FOREIGN KEY(`section_id`) REFERENCES 'sections' ( 'id' ) ON DELETE CASCADE,
  FOREIGN KEY(`student_id`) REFERENCES 'students' ( 'id' ) ON DELETE CASCADE
);
CREATE TABLE 'sections_teachers' (
	'id'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  'section_id'	INTEGER,
  'teacher_id'	INTEGER,
  FOREIGN KEY(`section_id`) REFERENCES 'sections' ( 'id' ) ON DELETE CASCADE,
  FOREIGN KEY(`teacher_id`) REFERENCES 'teachers' ( 'id' ) ON DELETE CASCADE
);
CREATE VIEW vw_sections_courses_teachers_students AS
  SELECT
    SC.period_id, P.name AS period_name,
    SC.id AS section_id, SC.code AS section_code,
    CO.id AS course_id, CO.name AS course_name,
    ST.id AS student_id, ST.code AS student_code, ST.names AS student_names, ST.last_names AS student_last_names, ST.email AS student_email, ST.personal_email AS student_personal_email, ST.tw_user, ST.tw_pass, ST.ad_user, ST.gender_id AS student_gender_id, G.name AS student_gender_name, ST.country_id AS student_country_id, C.name AS student_country_name, ST.carrer_id AS student_carrer_id, CA.name AS student_carrer_name, ST.photo_url AS student_photo_url,
    TE.id AS teacher_id, TE.code AS teacher_code, TE.names AS teacher_names, TE.last_names AS teacher_last_names, TE.teacher_type_id, TTE.name AS teacher_type_name, TE.email AS teacher_email, TE.personal_email AS teacher_personal_email, TE.gender_id AS teacher_gender_id, GT.name AS teacher_gender_name, TE.country_id AS teacher_country_id, CT.name AS teacher_country_name, TE.photo_url AS teacher_photo_url
  FROM sections_students SS
  JOIN sections SC ON SC.id = SS.section_id
  JOIN students ST ON ST.id = SS.student_id
  JOIN periods P ON P.id = SC.period_id
  JOIN genders G ON G.id = ST.gender_id
  JOIN countries C ON C.id = ST.country_id
  JOIN carrers CA ON CA.id = ST.carrer_id
  JOIN courses CO ON CO.id = SC.course_id
  JOIN sections_teachers STE ON STE.section_id = SC.id
  JOIN teachers TE ON TE.id = STE.teacher_id
  JOIN teacher_types TTE ON TTE.id = TE.teacher_type_id
  JOIN genders GT ON GT.id = TE.gender_id
  JOIN countries CT ON CT.id = TE.country_id
  LIMIT 20000;
CREATE TABLE 'users' (
	'id'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	'url_picture'	VARCHAR(150) NOT NULL
);
CREATE TABLE 'users_students' (
	'id'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  'user_id'	INTEGER,
  'student_id'	INTEGER,
  FOREIGN KEY(`user_id`) REFERENCES 'users' ( 'id' ) ON DELETE CASCADE,
  FOREIGN KEY(`student_id`) REFERENCES 'students' ( 'id' ) ON DELETE CASCADE
);
CREATE TABLE 'users_teachers' (
	'id'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  'user_id'	INTEGER,
  'teacher_id'	INTEGER,
  FOREIGN KEY(`user_id`) REFERENCES 'users' ( 'id' ) ON DELETE CASCADE,
  FOREIGN KEY(`teacher_id`) REFERENCES 'teachers' ( 'id' ) ON DELETE CASCADE
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
  ('20200923133217'),
  ('20200923133218'),
  ('20200923133317'),
  ('20200923223825'),
  ('20200923223826'),
  ('20200923223844'),
  ('20201002170538'),
  ('20201002170951'),
  ('20201007210901'),
  ('20201007212424'),
  ('20201007212444'),
  ('20201007212455'),
  ('20201007212516'),
  ('20201008011003'),
  ('20201008011005'),
  ('20201009020130'),
  ('20201009020135'),
  ('20201009020138');
