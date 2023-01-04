require_relative '../student.rb'

describe Student do 
  context "Testing Student class" do 
    it "Should be instance of Student" do 
      student = Student.new("Lily", 24, false)
      expect(student).to be_instance_of Student
    end
  end
end