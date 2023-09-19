require_relative '../src/music_album'
require 'date'

describe MusicAlbum do
  before :each do
    @genre = 'Rock'
    @author = 'Metallica'
    @source = 'Internet Stream'
    @label = 'Best Exits'
    @publish_date = Date.new(2023, 9, 19)
    @on_spotify = false
    @album = MusicAlbum.new(@genre, @author, @source, @label, @publish_date, @on_spotify)
  end
  it 'Creates a MusicAlbum instance with the correct attributes' do
    expect(@album.genre).to eql(@genre)
    expect(@album.author).to eql(@author)
    expect(@album.source).to eql(@source)
    expect(@album.label).to eql(@label)
    expect(@album.publish_date).to eql(@publish_date)
    expect(@album.on_spotify).to eql(@on_spotify)
  end
end
