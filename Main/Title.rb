require_relative 'GameEngine'

class Title < WidgetWindow

def draw
  super
  draw_box(20, 20, 5, 70, 40)
  @font.draw('TITLE MENU',50,50, @text_z)
end
end