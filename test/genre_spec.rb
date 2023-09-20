require_relative '../src/genre'
require_relative '../src/item'
# One Genre can have multiple 
#items
describe Genre do

  it "creates a Genre instance with a name" do 
    name = "Rock and Roll"
    genre = Genre.new(name)

    expect(genre.name).to eql(name)
  end

  it 'adds an item to the genre items\' array' do
    item = Item.new('rock','x','x','x','x')
    name = "Rock and Roll"
    genre = Genre.new(name)

    genre.add_item(item)

    expect(genre.items).to include(item)
  end

  it 'Set the genre fo the added item' do
    genre = Genre.new('Classical')
    item = Item.new('x','x','x','x','x')

    genre.add_item(item)
    expect(item.genre).to eql(genre)
  end
end