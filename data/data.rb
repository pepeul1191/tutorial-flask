require 'sequel'
require 'sqlite3'

# database and models config

Sequel::Model.plugin :json_serializer

DB = Sequel.connect('sqlite:///home/pepe/Documentos/ULima/2020-II/IngnerieaDeSoftwareII/fpp/db/app.db')

class Student < Sequel::Model(DB[:students])

end

class Country < Sequel::Model(DB[:countries])

end

class Teacher < Sequel::Model(DB[:teachers])

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

# fill_students
fill_teachers