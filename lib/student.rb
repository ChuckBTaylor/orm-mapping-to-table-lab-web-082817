require 'pry'
class Student

  attr_accessor :name, :grade
  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
  end

  def save
    sql = <<-SQL
      INSERT INTO students(name, grade) VALUES (?,?);
    SQL
    DB[:conn].execute(sql,self.name,self.grade)
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      );
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE IF EXISTS students;
      SQL
    DB[:conn].execute(sql)
  end

  def self.create(stud_hash)
    sql = <<-SQL
      INSERT INTO students(name, grade) VALUES (?,?);
    SQL
    DB[:conn].execute(sql,stud_hash[:name],stud_hash[:grade])
    to_make = DB[:conn].execute("SELECT * FROM students").flatten
    new_stud = Student.new(to_make[1],to_make[2])
    new_stud

  end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

end
