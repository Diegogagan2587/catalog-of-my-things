require 'json'
require 'fileutils'

class Write
  def create_file(file_name)
    FileUtils.mkdir_p('../data') unless File.directory?("./data")
    FileUtils.touch("../data/#{file_name}.json") unless File.exist?("../data/#{file_name}.json")
  end

  def store(album, genre)
    write_music_albums(album)
    write_genres(genre)
  end

  def write_music_albums(albums)
    puts 'Saving music albums into storage...! '
    data_to_store = []
    albums.each do | album |
      data_to_store.push({
        'genre' => album.genre,
        'author' => album.author,
        'source' => album.source,
        'label' => album.label,
        'publish_date' => album.publish_date,
        'on_spotify' => album.on_spotify,
      })
      #preven saving if no data 
      return if data_to_store.empty?
      create_file('music_albums')
      File.write('../data/music_albums.json')
  end
end