require_relative 'item'

class App
  def initialize
    @items = []
    @genres = []
    @labels = []
    @authors = []
  end

  def option_select
    option = gets.chomp.to_i
    case option
    when 1
      list_books
    when 2
      list_music_albums
    when 3
      list_games
    when 4
      list_genres
    when 5
      list_labels
    when 6
      list_authors
    when 7
      add_book
    when 8
      add_music_album
    when 9
      add_game
    when 10
      puts 'Thank you for using this app!'
      exit
    else
      puts 'Invalid option, try again.'
    end
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
