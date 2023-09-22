require_relative '../src/game'
require_relative '../src/author'
require_relative '../src/genre'
require_relative '../src/label'

describe Game do
  context 'When testing the Game class' do
    it "Create a new instance and shouldn't be archieved" do
      author = Author.new('Mojang', '')
      genre = Genre.new('Adventure')
      label = Label.new('Minecraft')
      game = Game.new({
                        genre: genre,
                        author: author,
                        label: label,
                        publish_date: '2009',
                        multiplayer: true,
                        last_played_at: '2022'
                      })
      expect(game.can_be_archived?).to be false
    end

    it 'Create a new instance and should be archieved' do
      author = Author.new('Mojang', '')
      genre = Genre.new('Adventure')
      label = Label.new('Minecraft')
      game = Game.new({
                        genre: genre,
                        author: author,
                        label: label,
                        publish_date: '2009',
                        multiplayer: true,
                        last_played_at: '2020'
                      })
      expect(game.can_be_archived?).to be true
    end
  end
end