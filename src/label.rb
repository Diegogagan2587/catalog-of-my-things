class Label
  attr_accessor :title, :color, :items

  def initialize(title, color)
    @id = Random.rand(1..1000)
    @title = title
    @color = color
    @items = []
  end

  def to_h
    {
      id: @id,
      title: @title,
      color: @color
    }
  end

  def add_item(item)
    @items << item
    item.label = self
  end
end
