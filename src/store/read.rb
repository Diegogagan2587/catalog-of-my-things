require_relative '../genre'
require_relative '../music_album'

class Read
  # then restore genres
  def and_restore_genres(state)
    return unless File.exist?('./data/genres.json')

    store = File.open('./data/genres.json')
    genres_data = JSON.parse(store.read)
    genres_data.each do |genre|
      state.push(Genre.new(genre['name']))
    end
    store.close
  end

  # then restore albums
  def and_restore_albums(state)
    return unless File.exist?('./data/music_albums.json')

    store = File.open('./data/music_albums.json')
    albums_data = JSON.parse(store.read)
    albums_data.each do |album|
      album = {
        genre: Genre.new(album['genre']),
        author: album['author'],
        source: album['source'],
        label: album['label'],
        publish_date: album['publish_date'],
        on_spotify: album['on_spotify']
      }
      state.push(MusicAlbum.new(album))
    end
  end
end
