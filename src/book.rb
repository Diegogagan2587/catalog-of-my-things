class Book < Item
  attr_accessor :cover_state, :label

  def initialize(params)
    super(
      params[:genre],
      params[:author],
      params[:source],
      params[:label],
      params[:publish_date],
    )
    @cover_state = params[:cover_state]
  end

  def to_h
    {
      id: @id,
      genre: @genre,
      author: @author,
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
