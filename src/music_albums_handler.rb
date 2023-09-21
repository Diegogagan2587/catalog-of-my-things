require_relative 'music_album'
require_relative 'genre'
require_relative 'genre_handler'

module MusicAlbumHandler
  include GenreHandler
  def create_music_album
    puts ['Select a Gender by number or add one,']
    list_genres(@genres)
    print 'Genre: '
    genre_input = gets.chomp
    puts genre_input    
    genre = if genre_input.match?(/\A-?\d+\z/)
      @genres[genre_input.to_i]
    else
      Genre.new(genre_input)
    end
    
    #@genres[genre_input.to_i] || Genre.new(genre_input)
  
    print 'Author: '
    author = gets.chomp
    print 'Source: '
    src = gets.chomp
    print 'Label: '
    label = gets.chomp
    print 'Publish date: '
    publish_date = gets.chomp
    print ['Is on spotify ? (type true or false)']
    spotify_input = gets.chomp.strip.downcase
    on_spotify = spotify_input == 'true'

    album_data = {
      genre: genre,
      author: author,
      source: src,
      label: label,
      publish_date: publish_date,
      on_spotify: on_spotify
    }
    music_album = MusicAlbum.new(album_data)
    genre.add_item(music_album)
    return music_album
  end

  def add_music_album_to(items,gender)
    music_album = create_music_album
    items.push(music_album)
    gender.push(music_album.genre) unless gender.include?(music_album.genre)
    puts ['','Music album added succsesfully']
  end

  def list_all_music_albums(albums)
    albums.each do |album|
      next unless album.instance_of?(MusicAlbum)

      id = album.id
      genre = album.genre.name
      author = album.author
      src = album.source
      label = album.label
      publish_date = album.publish_date
      on_spotify = album.on_spotify
      puts [
        '',
        "Id: #{id}",
        "Genre: #{genre}",
        "Author: #{author}",
        "Source: #{src}",
        "Label: #{label}",
        "Publish_date: #{publish_date}",
        "Is on spotify?: #{on_spotify}"
      ]
    end
  end
end
