require_relative '../genre'

class Read
  #then restore genres
  def and_restore_genres(state)
    return unless File.exist?('./data/genres.json')
    store = File.open('./data/genres.json')
    genres_data = JSON.parse(store.read)
    genres_data.each { | genre |
      state.push( Genre.new(genre["name"]) )
    }
    store.close
  end
  #then restore albums
  def and_restore_albums(state)
    puts 'Restoring'
  end
end