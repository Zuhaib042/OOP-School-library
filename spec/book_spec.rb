require_relative '../book.rb'
require_relative '../rental.rb'
require_relative '../person.rb'

describe Book do 
  context "Testing Book class" do 
    it "Should be instance of Book" do 
      book = Book.new("Sapiens", "Joshua")
      expect(book).to be_instance_of Book

      person = Person.new("John", 24)
      book.add_rental('12-12-2020', person)
      expect(book.rentals[0]).to be_instance_of Rental
    end
  end
end
