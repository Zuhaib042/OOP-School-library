require_relative '../classroom'
require_relative '../student'

describe Classroom do
  context 'Classroom Book class' do
    it 'should be an instance of Classroom' do
      student = Student.new('Ahmad', 18, true)
      classroom = Classroom.new('Arts Class')
      expect(classroom).to be_instance_of Classroom
      classroom.add_student(student)
      expect(classroom.students.pop).to be_instance_of Student
    end
  end
end
