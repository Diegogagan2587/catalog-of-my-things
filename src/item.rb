class Item
  attr_accessor :genre, :label
  attr_reader :id, :author, :source, :publish_date

  def initialize(genre, author, source, label, publish_date)
    @id = Random.rand(1..1000)
    @genre = genre
    @author = author
    @source = source
    @label = label
    @publish_date = begin
      Date.parse(publish_date)
    rescue StandardError
      nil
    end
  end

  def can_be_archived?
    return false unless @publish_date

    years_since_published = Time.now.year - @publish_date.year
    years_since_published >= 10
  end

  def move_to_archive
    if can_be_archived?
      @archived = true
      puts "#{@genre} has been archived."
    else
      puts "#{@genre} cannot be archived yet."
    end
  end
end
