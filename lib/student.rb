require 'pry'

class Student
  attr_accessor :id, :name, :grade

  def self.new_from_db(row) #accepts a row from the database as an argument
    # creates a new 'Student object' given a row from the database
    new_student = self.new([id: row[0], name: row[1], grade: row[2])
    # new_student = self.new
    # new_student.id = row[0]
    # new_student.name = row[1]
    # new_student.grade = row[2]
    # new_student
  end

  def self.all
    # retrieve all the rows from the "Students" database
    # remember each row should be a new instance of the Student class
    # sql is a variable that holds data for all students returned into a database
    sql = <<-SQL
      SELECT *
      FROM students
    SQL

    DB[:conn].execute(sql).map do |row| #value of the hash(call to database) is a new instance of the SQLite3::Database class- iterate over each row and use the self.new_from_db method to create a new Ruby object for each row.
      self.new_from_db(row)
    end
  end

  def self.find_by_name(name)
    # find the student in the database given a name
    # return a new instance of the Student class
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end
end
