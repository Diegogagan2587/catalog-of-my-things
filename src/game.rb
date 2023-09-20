require_relative 'item'
require 'date'

class Game < Item
  attr_accessor :multiplayer, :last_played_at

end