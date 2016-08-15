require_relative 'Rectangle'
class Hero

  MOVE_SPEED = 1
  FRICTION = 2
  MOVE_VELOCITY = 5

  def initialize(initial_x, initial_y)
  @sprite = Gosu::Image.new('content/serghei.png')
    @pos_x = initial_x
    @pos_y = initial_y
    @box = Rectangle.new(@pos_x, @pos_y, 94, 159)
    @delta = 0
    @move_cooldown = 0
  end

  def update
    if @move_cooldown > 0
      @move_cooldown -= FRICTION
      if @move_cooldown < 0
        @move_cooldown = 0
      end
    end

    if right_pressed
      @move_cooldown += MOVE_VELOCITY
      @delta = (MOVE_SPEED * @move_cooldown) / 10
      @pos_x += @delta
    elsif left_pressed
      @move_cooldown += MOVE_VELOCITY
      @delta = (MOVE_SPEED * @move_cooldown) / -10
      @pos_x += @delta
    else
      @move_cooldown -= FRICTION * 3
      if @move_cooldown < 0
        @move_cooldown = 0
        @delta = 0
      end
      if @delta > 0
        @delta = (MOVE_SPEED * @move_cooldown) / 10
        @pos_x += @delta
      elsif @delta < 0
        @delta = (MOVE_SPEED * @move_cooldown) / -10
        @pos_x += @delta
      end
    end


  end

  def draw
    @sprite.draw(@pos_x, @pos_y, 2)
  end

  def right_pressed
    Gosu::button_down? Gosu::KbRight
  end

  def left_pressed
    Gosu::button_down? Gosu::KbLeft
  end
end