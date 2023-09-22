require_relative 'item'
require_relative 'book'
require_relative 'label'
require_relative 'book_methods'
require_relative '../src/store/preserve_book_label'
require_relative 'music_albums_handler'
require_relative 'genre_handler'
require_relative 'game'
require_relative 'author'
require_relative 'game_methods'
require_relative 'store/write'
require_relative 'store/read'

class App
  include BookMethods
  include PreserveBookLabel
  include GenreHandler
  include MusicAlbumHandler
  def initialize
    create_data
    @items = []
    @genres = []
    @labels = []
    @authors = []
    load_from_file
    load_data_from_files
  end

  def create_data
    return if Dir.exist?('./data')

    Dir.mkdir('./data')
    create_file_if_not_exists('./data/games.json')
    create_file_if_not_exists('./data/authors.json')
  end

  def load_data_from_files
    @games = load_json_file('./data/games.json', [])
    @authors = load_json_file('./data/authors.json', [])
  end

  def load_json_file(file_path, default_value)
    return default_value unless File.exist?(file_path)

    file = File.open(file_path)
    file_data = file.read
    return default_value if file_data.empty?

    JSON.parse(file_data)
  rescue JSON::ParserError
    default_value
  end

  def create_file_if_not_exists(file_path)
    nil if File.exist?(file_path)
  end

  def exit_app
    puts 'Thank you for using this app!'
    Write.new.store(@items, @genres)
    exit
  end

  def option_select(option)
    case option
    when 1
      list_books
    when 2
      list_all_music_albums(@items)
    when 3
      list_games
    when 4
      list_genres(@genres)
    when 5
      list_labels
    when 6
      list_authors
    end
  end

  def add_element(_input)
    puts [
      'Select an option',
      '1. Add a book',
      '2. Add a music album',
      '3. Add a game'
    ]
    user_input = gets.chomp.to_i
    case user_input
    when 1
      add_book
    when 2
      add_music_album_to(@items, @genres)
    when 3
      enter_new_game
    end
  end

  def enter_new_game
    print 'Genre: '
    genre = gets.chomp
    print 'Author: '
    author = gets.chomp
    print 'Label: '
    label = gets.chomp
    print 'Publish date (year): '
    publish_date = gets.chomp
    print 'Multiplayer: '
    multiplayer = gets.chomp
    print 'Last played at (year): '
    last_played_at = gets.chomp
    add_game({
               genre: genre,
               author: author,
               label: label,
               publish_date: publish_date,
               multiplayer: multiplayer,
               last_played_at: last_played_at
             })
  end

  def list_games
    puts 'Games: '
    @games.each do |game|
      puts "Title: #{game['label']}, Author: #{game['author']}, Genre: #{game['genre']}, "
      print "Archived: #{game['archived']}"
      puts "\n"
    end
  end

  def list_authors
    puts 'Authors: '
    @authors.each do |author|
      puts "Name: #{author['first_name']} #{author['last_name']}, ID: #{author['id']}"
    end
  end

  def add_game(options)
    names = options[:author].split # Split the name at the spaces.
    first_name = names[0]
    last_name = names[1] if names.length > 1
    author_obj = Author.new(first_name, last_name)
    add_author(author_obj)
    game = create_game(options)
    game_input = {
      'id' => game.id,
      'author' => options[:author],
      'genre' => game.genre,
      'label' => game.label,
      'publish_date' => game.publish_date,
      'multiplayer' => game.multiplayer,
      'last_played_at' => game.last_played_at,
      'archived' => game.can_be_archived?
    }
    @games << game_input
    File.write('./data/games.json', JSON.pretty_generate(@games))
  end

  def add_author(author)
    author_input = {
      'id' => author.id,
      'first_name' => author.first_name,
      'last_name' => author.last_name
    }
    @authors << author_input
    File.write('./data/authors.json', JSON.pretty_generate(@authors))
  end

  def run
    puts [
      '1. List all books',
      '2. List all music albums',
      '3. List all games',
      '4. List all genres',
      '5. List all labels',
      '6. List all authors',
      '7. Add Item',
      '8. Exit'
    ]
    puts "Welcome, please select an option by entering the corresponding number: \n\n"
    input = gets.chomp.to_i
    exit_app if input == 8
    add_element(input) if input == 7
    puts 'Invalid option, try again.' if input > 8
    option_select(input)
    puts "\nPress Enter key to continue..."
    gets
    run
  end
end

def create_game(options)
  Game.new({
             genre: options[:genre],
             author: options[:author],
             label: options[:label],
             publish_date: options[:publish_date],
             multiplayer: options[:multiplayer],
             last_played_at: options[:last_played_at]
           })
end
