class Book < Item
  attr_accessor :cover_state

  def initialize(params)
    super(
      params[:genre],
      params[:author],
      params[:source],
      params[:label],
      params[:publish_date],
      archived: params[:archived]
    )
    @cover_state = params[:cover_state]
  end

  def can_be_archived?
    super || @cover_state == 'bad'
  end
end
