require_relative 'item'

class App
  def initialize
    @items = []
    @genres = []
    @labels = []
    @authors = []
  end

  def option_select
  end

  def run
    options = [
      'List all books',
      'List all music albums',
      'List all games',
      'List all genres',
      'List all labels',
      'List all authors',
      'Add a book',
      'Add a music album',
      'Add a game',
      'Exit'
    ]
    puts "Welcome, please select an option by entering the corresponding number: \n\n"
    options.each_with_index { |option, index| puts "#{index + 1} - #{option}" }
    option_select
    puts "\nPress Enter key to continue..."
    gets
    run
  end


end
