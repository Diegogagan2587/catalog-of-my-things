require_relative '../src/store/read'
require 'json'

RSpec.describe Read do
  subject(:reader) { described_class.new }

  # Mock File class to prevent actual file operations
  before do
    allow(File).to receive(:exist?).and_return(true)
    allow(File).to receive(:open).and_return(StringIO.new(''))
    allow_any_instance_of(StringIO).to receive(:read).and_return('[]')
    allow_any_instance_of(StringIO).to receive(:close)
  end

  describe '#and_restore_genres' do
    it 'restores genres from a JSON file' do
      # Prepare some sample JSON data
      genres_data = [{ 'name' => 'Rock' }, { 'name' => 'Pop' }]
      allow_any_instance_of(StringIO).to receive(:read).and_return(JSON.dump(genres_data))

      state = []
      reader.and_restore_genres(state)

      expect(state).to all(be_an_instance_of(Genre))
      expect(state.map(&:name)).to eq(%w[Rock Pop])
    end

    it 'does nothing if the JSON file does not exist' do
      allow(File).to receive(:exist?).and_return(false)

      state = []
      reader.and_restore_genres(state)

      expect(state).to be_empty
    end
  end

  describe '#and_restore_albums' do
    it 'restores albums from a JSON file' do
      # Prepare some sample JSON data
      albums_data = [
        {
          'genre' => 'Rock',
          'author' => 'Metallica',
          'source' => 'Internet Stream',
          'label' => 'Best Exits',
          'publish_date' => '2023-09-19',
          'on_spotify' => false
        }
      ]
      allow_any_instance_of(StringIO).to receive(:read).and_return(JSON.dump(albums_data))

      state = []
      reader.and_restore_albums(state)

      expect(state).to all(be_an_instance_of(MusicAlbum))
      expect(state.first.genre.name).to eq('Rock')
      expect(state.first.author).to eq('Metallica')
      # Add more expectations for other attributes
    end

    it 'does nothing if the JSON file does not exist' do
      allow(File).to receive(:exist?).and_return(false)

      state = []
      reader.and_restore_albums(state)

      expect(state).to be_empty
    end
  end
end
