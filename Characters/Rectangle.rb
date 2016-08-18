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

  def left
    pos_x
  end

  def right
    pos_x + width
  end

  def top
    pos_y
  end

  def bottom
    pos_y + height
  end

  def contains(point_x, point_y)
    if point_x > @pos_x && point_x < @pos_x + width && point_y > @pos_y && point_y < @pos_y + height
      true
    else
      false
    end
  end

  def contains_rectangle(value)
      self.pos_x <= value.pos_x && (value.pos_x + value.width) <= (self.pos_x + self.width) && self.pos_y <= value.pos_y && (value.pos_y + value.height) <= (self.pos_y + self.height)
  end

  def intersects(rectangle)
    !(rectangle.left > right || rectangle.right < left || rectangle.top > bottom || rectangle.bottom < top)
  end

  def center_x
    (pos_x + width) / 2
  end
  
  def center_y
    (pos_y + height) / 2
  end



end