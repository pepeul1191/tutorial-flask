require 'sequel'
require 'sqlite3'

# database and models config

Sequel::Model.plugin :json_serializer

DB = Sequel.connect('sqlite:///home/pepe/Documentos/ULima/2020-II/IngnerieaDeSoftwareII/fpp/db/app.db')
DB.sql_log_level = :debug

class Student < Sequel::Model(DB[:students])

end

class Country < Sequel::Model(DB[:countries])

end

class Teacher < Sequel::Model(DB[:teachers])

end

class Section < Sequel::Model(DB[:sections])

end

class SectionStudent < Sequel::Model(DB[:sections_students])

end

def tw_user
  rand(1..10).to_s + ' ' + rand(101..999).to_s + ' ' + rand(101..999).to_s + ' ' + rand(101..999).to_s
end

def tw_pass
  charset = Array('A'..'Z') + Array('a'..'z') + ['0', '1', '2', '3', '4', '5', '6', '7', '8' , '9']
  Array.new(6) { charset.sample }.join
end

def ad_user
  rand(101..999).to_s + ' ' + rand(101..999).to_s + ' ' + rand(101..999).to_s
end

def fill_students
  f = File.open('students.txt', "r")
  f.each_line do |line|
    data = line.split('::')
    DB.transaction do
      begin
        # create or check country
        country_name = data[6].strip
        country = Country.where(
          :name => country_name
        ).first
        if country == nil
          country = Country.new(
            :name => country_name,
          )
          country.save
        end
        # create student
        gender_id = 1
        if data[5] == 'Female'
          gender_id = 2
        end
        carrer_id = rand(1..5) 
        n = Student.new(
          :code => data[0],
          :names => data[1],
          :last_names => data[2],
          :personal_email => data[3],
          :email => data[4],
          :tw_user => tw_user(),
          :tw_pass => tw_pass(),
          :ad_user => ad_user(),
          :gender_id => gender_id,
          :carrer_id => carrer_id,
          :country_id => country.id,
        )
        n.save
      rescue Exception => e
        Sequel::Rollback
        puts 'error!'
        puts e.message
        puts e.backtrace
      end
    end
  end
  f.close
end

def fill_teachers
  f = File.open('teachers.txt', "r")
  f.each_line do |line|
    data = line.split('::')
    DB.transaction do
      begin
        # create or check country
        country_name = data[5].strip
        country = Country.where(
          :name => country_name
        ).first
        if country == nil
          country = Country.new(
            :name => country_name,
          )
          country.save
        end
        # create teacher
        gender_id = 1
        if data[4] == 'Female'
          gender_id = 2
        end
        carrer_id = rand(1..5) 
        email = data[1].to_s[0].strip + data[2][0..5].strip + '@universidad.edu.com'
        n = Teacher.new(
          :code => data[0],
          :names => data[1],
          :last_names => data[2],
          :personal_email => data[3],
          :email => email.downcase,
          :gender_id => gender_id,
          :country_id => country.id,
          :teacher_type_id => rand(1..2)
        )
        n.save
      rescue Exception => e
        Sequel::Rollback
        puts 'error!'
        puts e.message
      end
    end
  end
  f.close
end

def fill_sections_students
  DB.transaction do
    begin 
      courses = 3
      limit = 40
      total_iteration = (Student.count / 40.0).ceil
      sections = Section.all.to_a
      for k in 0..2 do
        offset = 0
        for i in 1..total_iteration do
          students = Student.limit(limit, offset).to_a
          for student in students do
            # puts k.to_s + "    " + i.to_s + "   section_id: " + sections[i + k*25 - 1].id.to_s + " student_id:  " + student.id.to_s
            n = SectionStudent.new(
              :section_id => sections[i + k*25 - 1].id,
              :student_id => student.id,
            )
            n.save
          end
          offset = offset + 40
        end
      end
    rescue Exception => e
      Sequel::Rollback
      puts 'error!'
      puts e.message
    end
  end
end

def inserts_countries
  sql = 'INSERT INTO countries (id, name) VALUES '
  countries = Country.all.to_a
  count = countries.length
  k = 0
  for country in countries do
    tmp = '(%d, "%s")' % [country.id, country.name]
    if k + 1 < count
      sql = sql + tmp + ", \n"
    else
      sql = sql + tmp
    end
    k = k + 1
  end
  puts sql += ';'
end

def inserts_students
  sql = 'INSERT INTO students (id, code, names, last_names, email, personal_email, tw_user, tw_pass, ad_user, gender_id, carrer_id, country_id, photo_url) VALUES '
  students = Student.all.to_a
  count = students.length
  k = 0
  for student in students do
    tmp = '(%d, %d, "%s", "%s", "%s", "%s", "%s", "%s", "%s", %d, %d, %d, "%s")' % [student.id, student.code, student.names, student.last_names, student.email, student.personal_email, student.tw_user, student.tw_pass, student.ad_user, student.gender_id, student.carrer_id, student.country_id, 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png']
    if k + 1 < count
      sql = sql + tmp + ", \n"
    else
      sql = sql + tmp
    end
    k = k + 1
  end
  File.write('/tmp/students.sql', sql += ';')
end

def inserts_teachers
  sql = 'INSERT INTO teachers (id, code, names, last_names, email, personal_email, gender_id, country_id, teacher_type_id, photo_url) VALUES '
  teachers = Teacher.all.to_a
  count = teachers.length
  k = 0
  for teacher in teachers do
    tmp = '(%d, %d, "%s", "%s", "%s", "%s", %d, %d, %d, "%s")' % [teacher.id, teacher.code, teacher.names, teacher.last_names, teacher.email, teacher.personal_email, teacher.gender_id, teacher.country_id, teacher.teacher_type_id, 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png']
    if k + 1 < count
      sql = sql + tmp + ", \n"
    else
      sql = sql + tmp
    end
    k = k + 1
  end
  File.write('/tmp/teachers.sql', sql += ';')
end


def inserts_sections_students
  sql = 'INSERT INTO sections_students (id, section_id, student_id) VALUES '
  sections_teachers = SectionStudent.all.to_a
  count = sections_teachers.length
  k = 0
  for section_teacher in sections_teachers do
    tmp = '(%d, %d, %d)' % [section_teacher.id, section_teacher.section_id, section_teacher.student_id]
    if k + 1 < count
      sql = sql + tmp + ", \n"
    else
      sql = sql + tmp
    end
    k = k + 1
  end
  File.write('/tmp/sections_students.sql', sql += ';')
end

# fill_students
# fill_teachers
# fill_sections_students
# inserts_countries
# inserts_students
# inserts_teachers
# inserts_sections_students
