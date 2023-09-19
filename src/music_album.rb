require_relative 'item'

class MusicAlbum < Item
  attr_reader :on_spotify

  def initialize(album)
    super(
      album[:genre],
      album[:author],
      album[:source],
      album[:label],
      album[:publish_date],
    )
    @on_spotify = album[:on_spotify]
  end

  private

  def can_be_archived?()
    @on_spotify && super
  end
end
