require_relative 'GameEngine'

class GameText < Gosu::Font

  attr_accessor :offset

  TEXT_LAYER = 10

  def initialize(scale, path)
    super(scale, :name => path)
  end

  def get_string_length(text, scale = 1)
    self.text_width(text, scale)
  end

  def draw_centered_text(text, x, y, scale = 1, color)
      new_x = x - (get_string_length(text, scale) / 2).round
      self.draw(text = text, x = new_x, y = y, z = TEXT_LAYER, scale_x = scale, scale_y = scale, color = color)
  end

  def draw_text(text, x, y, row, color)
    offset = ((row * self.height) * 0.8).round
    self.draw(text, x, y + offset, TEXT_LAYER, 1, 1, color)
  end

end