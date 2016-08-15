class Rectangle

  attr_accessor :pos_x
  attr_accessor :pos_y
  attr_accessor :width
  attr_accessor :height

  def initialize(x, y, width, height)
    @pos_x = x
    @pos_y = y
    @width = width
    @height = height
  end

  def contains(point_x, point_y)
    if point_x > @pos_x && point_x < @pos_x + width && point_y > @pos_y && point_y < @pos_y + height
      true
    else
      false
    end
  end


end