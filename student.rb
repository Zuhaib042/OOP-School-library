require_relative 'person'

class Student < Person
  attr_reader :classroom
  attr_accessor :type, :parent_permission

  def initialize(age, name, parent_permission)
    super(age, name, parent_permission: parent_permission)
    @classroom = classroom
    @type = 'Student'
  end

  def classroom=(classroom)
    classroom.students.push(self) unless classroom.students.include?(self)
  end

  def play_hooky
    '¯\(ツ)/¯'
  end
end
