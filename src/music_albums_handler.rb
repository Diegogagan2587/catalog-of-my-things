class MusicAlbumHandler
  def add_item(item, store)
    store.push(item)
  end

  def list_all_music_albums(albums)
    albums.each{ |album |
      next unless album.class == MusicAlbum
      id = album.id
      genre = album.genre
      author = album.author
      src = album.source
      label = album.label
      publish_date = album.publish_date
      on_spotify = album.on_spotify
      puts [
        "",
        "Id: #{id}",
        "Genre: #{genre}",
        "Author: #{author}",
        "Source: #{src}",
        "Label: #{label}",
        "Publish_date: #{publish_date}",
        "Is on spotify?: #{on_spotify}",
      ]
    }
  end
end