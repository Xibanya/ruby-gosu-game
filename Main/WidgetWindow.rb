require_relative 'GameEngine'
require_relative 'Text'
require_relative 'Input'
require_relative 'GameState'

class WidgetWindow

  include GameState
  include Input

  attr_accessor :terminated

  def initialize(window)
    @window = window
    @box_source = Array.new
    box_sprite =  Gosu::Image.new(BOX_SPRITE)
    for y in 0..3
      for x in 0..3
        tile = Gosu::Image.new(window, box_sprite, true, x * BOX_MARGIN, y * BOX_MARGIN, BOX_MARGIN, BOX_MARGIN)
        @box_source.push(tile)
      end
    end

    @child_window_list = Array.new
    @widget_list = Array.new
    @window_list = Array.new

    @font = GameText.new(MENU_FONT_SIZE, MENU_FONT)

    @input_cooldown = INPUT_COOLDOWN

    @terminated = false
  end

  def update(parent)

    if @input_cooldown > 0
      @input_cooldown -= 1
    end

    i = 0

    if @child_window_list.length > 0
      # update every child window
      # if a child window has been terminated, remove it so it won't be updated anymore
      while i < @child_window_list.length
        @child_window_list[i].update
        if @child_window_list[i].terminated
          @child_window_list.delete_at(i)
        else
          i += 1
        end
      end
    else
      while i < @widget_list.length
        @widget_list[i].update
        i += 1
      end
    end

  end

  def draw
    @child_window_list.each do |window|
      window.draw
    end

    @window_list.each do |window|
      draw_box(window.x, window.y, BOX_DEPTH, window.width, window.height)
    end

    @widget_list.each do |widget|
      widget.draw
    end
  end

  def draw_box(x, y, z, width, height)

    #top row
    @box_source[0].draw(x, y, z + 1)

    for i in 0..width
      @box_source[1].draw(x + (i * BOX_MARGIN), y, z)
    end

    @box_source[2].draw(x + (width * BOX_MARGIN) + BOX_MARGIN, y, z + 1)

    #mid row
    for i in 0..height
      @box_source[3].draw(x, y + (i * BOX_MARGIN), z)
    end

    # middle - 4

    for i in 0..height
      @box_source[5].draw(x + (width * BOX_MARGIN) + BOX_MARGIN, y + (i * BOX_MARGIN), z)
    end

    # lower row
    @box_source[6].draw(x, y + (height * BOX_MARGIN) + BOX_MARGIN, z + 1)

    for i in 0..width
      @box_source[7].draw(x + (i * BOX_MARGIN), y + (height * BOX_MARGIN) + BOX_MARGIN, z)
    end

    @box_source[8].draw(x + (width * BOX_MARGIN) + BOX_MARGIN, y + (height * BOX_MARGIN) + BOX_MARGIN, z + 1)
  end


end