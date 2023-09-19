require_relative '../src/music_album'
require_relative '../src/item'
=begin
All MusicAlbum class properties visible in the diagram should
 be defined and set up in the constructor method.
=end
  
describe MusicAlbum do
  before :each do
    @album = MusicAlbum.new(
      "Rock",
      "Metallica",
      "Internet",
      "Best one",
      "1990-12-25",
      archived:false
    )
  end

  it 'Should return true if parent\' method .can_be_archived? returns true AND if on_spotify 
  equals true ' do 
    allow(@album).to receive(:on_spotify) {true}
    expect(@album.can_be_archived?).to eql(true)
  end

  it 'Should return false if parent method .can_be_archived? is true AND if on_spotify is false' do
    allow(@album).to receive(:on_spotify) {false}
    expect(@album.can_be_archived?).to eql(false)
  end
end

