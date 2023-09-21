require 'json'
require 'fileutils'

class Write
  def create_file(file_name)
    FileUtils.mkdir_p('./data') unless File.directory?('./data')
    FileUtils.touch("./data/#{file_name}.json") unless File.exist?("./data/#{file_name}.json")
  end

  def store(albums, genres)
    write_music_albums(albums)
    write_genres(genres)
  end

  def write_genres(genres)
    puts 'Saving genres into storage...! '
    data_to_store = []
    genres.each do |genre|
      data_to_store.push({
                           'name' => genre.name,
                           'number_of_items' => genre.items.length
                         })
    end
    return if data_to_store.empty?

    create_file('genres')
    File.write('./data/genres.json', JSON.pretty_generate(data_to_store))
  end

  def write_music_albums(albums)
    puts 'Saving music albums into storage...! '
    data_to_store = []
    albums.each do |album|
      next unless album.instance_of?(MusicAlbum)

      data_to_store.push({
                           'genre' => album.genre.name,
                           'author' => album.author,
                           'source' => album.source,
                           'label' => album.label,
                           'publish_date' => album.publish_date,
                           'on_spotify' => album.on_spotify
                         })
    end
    # preven saving if no data
    return if data_to_store.empty?

    create_file('music_albums')
    File.write('./data/music_albums.json', JSON.pretty_generate(data_to_store))
  end
end
