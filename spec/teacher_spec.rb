require_relative '../teacher'

describe Teacher do
  context 'Testing Book class' do
    it 'should be an instance of Teacher' do
      teacher = Teacher.new(34, 'Science', 'Ahmad')
      expect(teacher).to be_instance_of Teacher
    end

    it 'should result in true when accessing use_services' do
      teacher = Teacher.new(34, 'Science', 'Ahmad')
      expect(teacher.can_use_services?).to eql true
    end
  end
end
