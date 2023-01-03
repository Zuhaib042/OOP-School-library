class Rental
  attr_accessor :date
  attr_reader :person, :book

  def initialize(date, person, book)
    @date = date

    @person = person
    # person.rentals << self
    # person.rentals.push(self)
    print person.rentals

    @book = book
    book.rentals << self
  end
end
