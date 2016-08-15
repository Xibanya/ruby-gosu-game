require_relative 'GameEngine'

class Title < WidgetWindow

  UNSELECTED = Gosu::Color.argb(0xff_ffffff) #white
  SELECTED = Gosu::Color.argb(0xff_00ffff) #aqua

  START = 0
  OPTIONS = 1
  QUIT = 2

def initialize(window)
  super
  @title_pos_x = 50
  @title_pos_y = 50
  @title_items = ['Start', 'Options', 'Quit']
  @title_selection = 0
  @input_cooldown = 0
end

  def update
      super

      # change selected item
      if down_pressed
        @title_selection += 1
        @title_selection = 0 if @title_selection >= @title_items.length
      elsif up_pressed
        @title_selection -= 1
        @title_selection = @title_items.length - 1 if @title_selection < 0

      # ----------------------

      # select an item
      elsif confirm_pressed
        case @title_selection
          when START
            puts 'Start game'
          when OPTIONS
            puts 'options menu'
          when QUIT
            @window.close
          else
            puts 'Unexpected value'
        end
      # ---------------
      end

  end

def draw
  super

  draw_box(20, 20, @text_box_z, 70, 40)
  @font.draw('Title Menu', @title_pos_x, @title_pos_y, @text_z, 1.5, 1.5, UNSELECTED, mode = :default)

  for i in 0..@title_items.length
    color = UNSELECTED
    if i == @title_selection
      color = SELECTED
    end
  @font.draw(@title_items[i], @title_pos_x, @title_pos_y + 70 + (40 * i), @text_z, 1, 1, color, mode = :default)
  end
end
end