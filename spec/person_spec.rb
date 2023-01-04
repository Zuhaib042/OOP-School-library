require_relative '../book.rb'
require_relative '../rental.rb'
require_relative '../person.rb'

describe Person do 
  context "Testing Person class" do 
    it "Should be instance of Person" do 
      person = Person.new("Lily", 24)
      expect(person).to be_instance_of Person

      book = Book.new("Sapiens", "Joshua")

      person.add_rental("12-12-2020", book)
      expect(person.rentals[0]).to be_instance_of Rental
    end
  end
end
