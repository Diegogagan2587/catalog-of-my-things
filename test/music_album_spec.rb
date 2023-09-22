require_relative '../src/music_album'
require 'date'

describe MusicAlbum do
  before :each do
    @album_attributes = {
      genre: 'Rock',
      author: 'Metallica',
      source: 'Internet Stream',
      label: 'Best Exits',
      publish_date: '2023-9-19',
      on_spotify: false
    }

    @album = MusicAlbum.new(@album_attributes)
  end
  it 'Creates a MusicAlbum instance with the correct attributes' do
    expect(@album.genre).to eql(@album_attributes[:genre])
    expect(@album.author).to eql(@album_attributes[:author])
    expect(@album.source).to eql(@album_attributes[:source])
    expect(@album.label).to eql(@album_attributes[:label])
    expect(@album.publish_date).to eql(Date.new(2023, 9, 19))
    expect(@album.on_spotify).to eql(@album_attributes[:on_spotify])
  end
end
