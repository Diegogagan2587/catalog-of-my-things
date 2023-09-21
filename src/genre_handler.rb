require_relative 'genre'

module GenreHandler
  def list_genres(genres)
    genres.each_with_index do | genre, i |
      puts "#{i}) #{genre.name}"
    end
  end

end