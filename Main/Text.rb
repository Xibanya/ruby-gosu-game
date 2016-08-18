require_relative 'GameEngine'

class GameText < Gosu::Font

  def initialize(scale, path)
    super(scale, :name => path)
  end

  def get_string_length(text, scale = 1)
    self.text_width(text, scale)
  end

  def draw_centered_text(text, x, y, z, scale = 1, color)
      new_x = x - (get_string_length(text, scale) / 2).round
      self.draw(text = text, x = new_x, y = y, z = z, scale_x = scale, scale_y = scale, color = color)
  end

end