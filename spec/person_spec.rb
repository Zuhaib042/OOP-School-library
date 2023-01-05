require_relative '../book'
require_relative '../rental'
require_relative '../person'

describe Person do
  context 'Testing Person class' do
    it 'Should be instance of Person' do
      person = Person.new(24, 'Lily')
      expect(person).to be_instance_of Person

      book = Book.new('Sapiens', 'Joshua')

      person.add_rental('12-12-2020', book)
      expect(person.rentals[0]).to be_instance_of Rental

      expect(person.can_use_services?).to be_truthy
    end
  end
end
