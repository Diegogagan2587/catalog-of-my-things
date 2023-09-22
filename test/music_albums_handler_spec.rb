require_relative '../src/music_albums_handler'
require_relative '../src/music_album'
require_relative '../src/genre'
require_relative '../src/item'
require_relative '../src/app'


describe MusicAlbumHandler do
  include MusicAlbumHandler
  before :each do
    # thinsg will be done before each test
    @album_attributes = {
      genre: Genre.new('Rock'),
      author: 'Metallica',
      source: 'Internet Stream',
      label: 'Best Exits',
      publish_date: Date.new(2023, 9, 19),
      on_spotify: false
    }
  end

  it 'Should Add a music album to Items and Genres' do
    music_album = MusicAlbum.new(@album_attributes)
    items = []
    genres = []
    allow(self).to receive(:create_music_album).and_return(music_album)
    add_music_album_to(items, genres)
    expect(items).to include(music_album)
    expect(genres).to include(music_album.genre)
  end

  it 'Should List all music albums' do
    music_album_one = MusicAlbum.new(@album_attributes)
    music_album_two = MusicAlbum.new(@album_attributes)
    allow(music_album_one).to receive(:id) { 1 }
    allow(music_album_two).to receive(:id) { 2 }
    items = [music_album_one, music_album_two]

    expected_output = Regexp.new(<<~PATTERN, Regexp::MULTILINE)
      Id:\\s*1\\s*Genre:\\s*Rock\\s*Author:\\s*Metallica\\s*Source:\\s*Internet Stream\\s*
      Label:\\s*Best Exits\\s*Publish_date:\\s*2023-09-19\\s*Is on spotify\\?:\\s*false\\s*
      Id:\\s*2\\s*Genre:\\s*Rock\\s*Author:\\s*Metallica\\s*Source:\\s*Internet Stream\\s*
      Label:\\s*Best Exits\\s*Publish_date:\\s*2023-09-19\\s*Is on spotify\\?:\\s*false
    PATTERN
    expect { @music_album_handler.list_all_music_albums(items) }.to output(
      expected_output
    ).to_stdout
  end

  it 'should only display music albums' do
    music_album = MusicAlbum.new(@album_attributes)
    other_item = Item.new('x', 'x', 'x', 'x', 'x')
    allow(music_album).to receive(:id) { 1 }
    allow(other_item).to receive(:id) { 2 }
    items = [music_album, other_item]
    expected_output = Regexp.new(<<~PATTERN, Regexp::MULTILINE)
      Id:\\s*1\\s*Genre:\\s*Rock\\s*Author:\\s*Metallica\\s*Source:\\s*Internet Stream\\s*
      Label:\\s*Best Exits\\s*Publish_date:\\s*2023-09-19\\s*Is on spotify\\?:\\s*false\\s*
    PATTERN

    expect { @music_album_handler.list_all_music_albums(items) }.to output(
      expected_output
    ).to_stdout
  end
end
