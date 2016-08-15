require_relative 'GameEngine'

class WidgetWindow
  attr_accessor :terminated

  INPUT_COOLDOWN = 10

  def initialize(window)
    @window = window
    @box_margin = 8
    @box_source = Array.new
    box_sprite =  Gosu::Image.new('content/UI-Window.png')
    for y in 0..3
        for x in 0..3
          tile = Gosu::Image.new(window, box_sprite, true, x * @box_margin, y * @box_margin, @box_margin, @box_margin)
          @box_source.push(tile)
        end
    end

    @child_window_list = Array.new
    @widget_list = Array.new
    @window_list = Array.new

    @font  = Gosu::Font.new(50, :name => 'Content/accid.ttf')
    @text_z = 10
    @text_box_z = 9

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
      draw_box(window.x, window.y, @text_box_z, window.width, window.height)
    end

    @widget_list.each do |widget|
      widget.draw
    end
  end

  def draw_box(x, y, z, width, height)

    #top row
    @box_source[0].draw(x, y, z + 1)

    for i in 0..width
    @box_source[1].draw(x + (i * @box_margin), y, z)
    end

    @box_source[2].draw(x + (width * @box_margin) + @box_margin, y, z + 1)

    #mid row
    for i in 0..height
    @box_source[3].draw(x, y + (i * @box_margin), z)
    end

    # middle - 4

    for i in 0..height
      @box_source[5].draw(x + (width * @box_margin) + @box_margin, y + (i * @box_margin), z)
    end

    # lower row
    @box_source[6].draw(x, y + (height * @box_margin) + @box_margin, z + 1)

    for i in 0..width
      @box_source[7].draw(x + (i * @box_margin), y + (height * @box_margin) + @box_margin, z)
    end

    @box_source[8].draw(x + (width * @box_margin) + @box_margin, y + (height * @box_margin) + @box_margin, z + 1)
  end

  # Input Methods
  def confirm_pressed
    if @input_cooldown <= 0
      if Gosu::button_down? Gosu::KbReturn
        @input_cooldown = INPUT_COOLDOWN
        return true
      elsif Gosu::button_down? Gosu::KbSpace
        @input_cooldown = INPUT_COOLDOWN
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def down_pressed
    if @input_cooldown <= 0
      if Gosu::button_down? Gosu::KbDown
      @input_cooldown = INPUT_COOLDOWN
      return true
      else
        return false
      end
    else
      return false
    end
  end

  def up_pressed
    if Gosu::button_down? Gosu::KbUp

    if @input_cooldown <= 0
      @input_cooldown = INPUT_COOLDOWN
      return true
    else
      return false
    end
    else
      return false
    end
    end

end