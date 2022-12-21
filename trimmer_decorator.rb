require_relative 'decorator'

class TrimmerDecorator < Decorator
  def correct_name
    if @nameable.correct_name.length > 10
      @nameable.correct_name[0,10]
    end
  end
end