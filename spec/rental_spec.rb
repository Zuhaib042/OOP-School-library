require_relative '../book'
require_relative '../rental'
require_relative '../person'

describe Rental do
  context 'Testing Rental class' do
    it 'Should be instance of Rental' do
      book = Book.new('Sapiens', 'Joshua')
      person = Person.new(24, 'Lily')
      rental = Rental.new('20-10-2022', person, book)
      expect(rental).to be_instance_of Rental
    end
  end
end
