require_relative 'book'
require_relative 'teacher'
require_relative 'student'
require_relative 'rental'

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
      options(input)
      if input == 7
        puts 'Thank you for using our app.'
      end
      break
    end
  end

  def options(input)
    case (input)
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

  def menu_loop
   menu
  end

  def create_person
    puts 'Do you want to create a student (1) or a teacher (2) [input the number]: '
    input = gets.chomp.to_i
    case (input)
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
    each_student = Student.new(age, name, permission)
    @persons.push(each_student)
    puts "Student '#{name}' created successfully"
    menu_loop
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
    menu_loop
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    each_book = Book.new(title, author)
    @books.push(each_book)
    puts "Book '#{title}' created successfully"
    menu_loop
  end

  def list_books
   if @books.empty?
    puts 'Sorry, there is no book in the Collection'
    menu_loop
   else
    @books.each_with_index do |book, index| 
      puts "#{index}- Title: '#{book.title}', Author: #{book.author}"
    end
    menu_loop
   end
  end

  def list_people
    if @persons.empty?
      puts 'Sorry, there is no person in the Database'
      menu_loop
    else
      @persons.each_with_index do |person, index|
        puts "#{index}- [#{person.type}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      end
      menu_loop
    end
  end

  def create_rental
    if @books.empty?
      puts 'Sorry, there is no book in the collection to rent out.'
      menu_loop
    elsif @persons.empty?
      puts 'Sorry, there is no person in the Database. Add a person first in the database'
      menu_loop
    else
     puts 'Select a book from the following list by number: '
     @books.each_with_index do |book, index| 
      puts "#{index}- Title: '#{book.title}', Author: #{book.author}"
     end
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
     puts "Rental created successfully"
     menu_loop
    end
  end
  
  def list_all_rentals
    puts 'ID of person: '
    person_id = gets.chomp.to_i
    puts 'Rentals: '
    @rentals.each do |rental|
      if person_id == rental.person.id
        puts "Date: #{rental.date}, Book '#{rental.book.title}' by #{rental.book.author}"
      end
    end
    menu_loop
  end

end