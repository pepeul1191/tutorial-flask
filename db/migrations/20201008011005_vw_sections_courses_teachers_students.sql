-- migrate:up

-- migrate:up

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

-- migrate:down

DROP VIEW IF EXISTS vw_sections_courses_teachers_students

-- migrate:down

