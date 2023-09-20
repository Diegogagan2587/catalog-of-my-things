class Item
  attr_accessor :label
  attr_reader :id, :genre, :author, :source, :publish_date

  def initialize(genre, author, source, label, publish_date)
    @id = Random.rand(1..1000)
    @genre = genre
    @author = author
    @source = source
    @label = label
    @publish_date = publish_date
  end

  def can_be_archived?
    years_since_published = Time.now.year - @published_date.year
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
