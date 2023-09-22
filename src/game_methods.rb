require 'json'
require_relative 'author'
require_relative 'game'

module PreservegameLabel
  create_data
  create_file_if_not_exists('./data/games.json')
  create_file_if_not_exists('./data/authors.json')
  load_data_from_files
end

# Creates a data directory if not exists
def create_data
  return if Dir.exist?('./data')

  Dir.mkdir('./data')
end

# Sets the arrays to be empty or to be the parsed info from the files
def load_data_from_files
  @games = load_json_file('./data/games.json', [])
  @authors = load_json_file('./data/authors.json', [])
end

# A method to check if the files are empty or not, and parse the info
def load_json_file(file_path, default_value)
  file = File.open(file_path)
  file_data = file.read
  if file_data.empty?
    default_value
  else
    JSON.parse(file_data)
  end
end

# Creates the json files if they don't exist
def create_file_if_not_exists(file_path)
  return if File.exist?(file_path)

  File.open(file_path, 'w')
end

 # Options to entry a new game
 def add_game
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