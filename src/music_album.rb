require_relative 'item'

class MusicAlbum < Item
  attr_reader :on_spotify
  def initialize(genre, author, source,label, publish_date, on_spotify)
    super(genre, author, source, label, publish_date)
    @on_spotify = on_spotify
  end
  private
  def can_be_archived?()
    on_spotify && super
  end
end
