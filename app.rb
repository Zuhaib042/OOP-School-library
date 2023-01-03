require_relative 'book'
require_relative 'teacher'
require_relative 'student'
require_relative 'rental'
require 'json'

class App
  def initialize
    @persons = []
    @books = []
    @rentals = []
  end

  def run
    puts 'Welcome to School Library App!'
    menu
  end

  def menu
    loop do
      puts '' * 30
      puts 'Please choose an option by entering a number:'
      puts '1 - List all books'
      puts '2 - List all people'
      puts '3 - Create a person'
      puts '4 - Create a book'
      puts '5 - Create a rental'
      puts '6 - List all rentals for a given person id'
      puts '7 - Exit'
      puts ''
      input = gets.chomp.to_i
      case input
      when 1..6 then options(input)
      when 7 
        save_data
        puts 'Thank you for using our app.'
      end
      break if input == 7
    end
  end
  
  def save_data
    books_json   = []
    persons_json = []
    rentals_json = []

    @books.each do |book|
      books_json.push({Name: book.title, Author: book.author})
    end
    
    @persons.each do |person|
     if (person.type == "Student")
      persons_json.push({json_class: person.type, name: person.name, age: person.age, parent_permission: person.parent_permission})
     else
      persons_json.push({json_class: person.type, name: person.name, age: person.age, parent_permission: person.parent_permission, specialization: person.specialization})
     end
    end

    @rentals.each do |rental|
      rentals_json.push({Date: rental.date, Person: rental.person.name, Book: rental.book.title})
    end

    File.open("data_files/books.json", "w") do |file| 
      @books.each do |book|
        file.write JSON.generate(books_json) 
      end
      
    end

    File.open("data_files/people.json", "w") do |file| 
      file.write JSON.generate(persons_json) 
    end

    File.open("data_files/rentals.json", "w") do |file| 
      file.write JSON.generate(rentals_json) 
    end

  end

  def options(input)
    case input
    when 1
      list_books
    when 2
      list_people
    when 3
      create_person
    when 4
      create_book
    when 5
      create_rental
    when 6
      list_all_rentals
    end
  end

  def create_person
    puts 'Do you want to create a student (1) or a teacher (2) [input the number]: '
    input = gets.chomp.to_i
    case input
    when 1
      create_student
    when 2
      create_teacher
    else
      puts 'Please enter a valid number: 1 or 2'
    end
  end

  def create_student
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Has parent permission? [Y/N]: '
    permission = gets.chomp
    if %w[Y y YES yes].include?(permission)
      permission = true
    elsif %w[N n NO no].include?(permission)
      permission = false
    end
    each_student = Student.new(age, name, permission)
    @persons.push(each_student)
    puts "Student '#{name}' created successfully"
  end

  def create_teacher
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Specialization: '
    specialization = gets.chomp
    each_teacher = Teacher.new(age, specialization, name)
    @persons.push(each_teacher)
    puts "Teacher '#{name}' created successfully"
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    each_book = Book.new(title, author)
    @books.push(each_book)
    puts "Book '#{title}' created successfully"
  end

  def list_books
    if @books.empty?
      puts 'Sorry, there is no book in the Collection'
    else
      @books.each_with_index do |book, index|
        puts "#{index}- Title: '#{book.title}', Author: #{book.author}"
      end
    end
  end

  def list_people
    if @persons.empty?
      puts 'Sorry, there is no person in the Database'
    else
      @persons.each_with_index do |person, index|
        puts "#{index}- [#{person.type}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      end
    end
  end

  def create_rental
    if @books.empty?
      puts 'Sorry, there is no book in the collection to rent out.'
    elsif @persons.empty?
      puts 'Sorry, there is no person in the Database. Add a person first in the database'
    else
      puts 'Select a book from the following list by number: '
      @books.each_with_index { |book, i| puts "#{i}- Title:'#{book.title}', Author: #{book.author}" }
      book_index = gets.chomp.to_i
      book = @books[book_index]
      puts 'Select a person from the following list by number (not id): '
      @persons.each_with_index do |person, index|
        puts "#{index}- [#{person.type}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      end
      person_id = gets.chomp.to_i
      person = @persons[person_id]
      print 'Date: '
      date = gets.chomp
      rental = Rental.new(date, person, book)
      @rentals.push(rental)
      puts 'Rental created successfully'
    end
  end

  def list_all_rentals
    puts 'ID of person: '
    person_id = gets.chomp.to_i
    puts 'Rentals: '
    @rentals.each do |rental|
      puts "Date: #{rental.date}, Book '#{rental.book.title}' by #{rental.book.author}" if person_id == rental.person.id
    end
  end
end
