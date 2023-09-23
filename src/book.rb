class Book < Item
  attr_accessor :cover_state, :label, :publisher

  def initialize(params)
    super(
      params[:genre],
      params[:publisher],
      params[:source],
      params[:label],
      params[:publish_date],
    )
    @cover_state = params[:cover_state]
    @publisher = params[:publisher]
  end

  def to_h
    {
      id: @id,
      genre: @genre,
      publisher: @publisher,
      source: @source,
      label: @label.to_h,
      publish_date: @publish_date,
      cover_state: @cover_state
    }
  end

  private

  def can_be_archived?
    super || @cover_state == 'bad'
  end
end
