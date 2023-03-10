require_relative 'person'
class Teacher < Person
  attr_accessor :type, :parent_permission, :specialization

  def initialize(age, specialization, name, parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @specialization = specialization
    @type = 'Teacher'
  end

  def can_use_services?
    true
  end
end
