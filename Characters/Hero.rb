require_relative 'Rectangle'
class Hero

  MOVE_SPEED = 1
  FRICTION = 2
  MOVE_VELOCITY = 5
  MAX_SPEED = 100

  GRAVITY = 15
  JUMP_SPEED = 2
  JUMP_VELOCITY = 150
  MAX_JUMP = 200

  def initialize(initial_x, initial_y)
  @sprite = Gosu::Image.new('content/serghei.png')
    @pos_x = initial_x
    @pos_y = initial_y
    @box = Rectangle.new(@pos_x, @pos_y, 94, 159)
    @delta = 0
  @y_delta = 0
  @ground = initial_y
    @move_cooldown = 0
    @jump_cooldown = 0
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
      if @move_cooldown > MAX_SPEED
        @move_cooldown = MAX_SPEED
      end
      @delta = (MOVE_SPEED * @move_cooldown) / 10
      @pos_x += @delta
    elsif left_pressed
      @move_cooldown += MOVE_VELOCITY
      if @move_cooldown > MAX_SPEED
        @move_cooldown = MAX_SPEED
      end
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

    if @jump_cooldown > 0
      @jump_cooldown -= GRAVITY
      if @jump_cooldown < 0
        @jump_cooldown = 0
      end
    end

      @y_delta = (JUMP_SPEED * @jump_cooldown) / 10
    if @y_delta > 0
      if @pos_y - @y_delta >= @ground - MAX_JUMP
      @pos_y -= @y_delta
        end
    else
      @pos_y += GRAVITY
      end
      if @pos_y > @ground
        @pos_y = @ground
      end

    if up_pressed
      if @pos_y == @ground
      @jump_cooldown += JUMP_VELOCITY
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

  def up_pressed
    Gosu::button_down? Gosu::KbUp
  end
end