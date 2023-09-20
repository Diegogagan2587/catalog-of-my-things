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

  def can_be_archived?
    super || @cover_state == 'bad'
  end
end
