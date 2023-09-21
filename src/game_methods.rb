require 'json'
require_relative 'author'
require_relative 'game'

module PreservegameLabel
  DATA_DIR = 'data'.freeze
  GAME_FILE = File.join(DATA_DIR, 'game.json')
  AUTHOR_FILE = File.join(DATA_DIR, 'author.json')
end