require_relative 'Rectangle'
class Hero

  MOVE_SPEED = 1
  FRICTION = 2
  MOVE_VELOCITY = 5
  MAX_SPEED = 100

  GRAVITY = 25
  JUMP_SPEED = 1
  JUMP_VELOCITY = 150
  MAX_JUMP = 100

  def initialize(initial_x, initial_y)
  @sprite = Gosu::Image.new('content/serghei.png')
    @pos_x = initial_x
    @pos_y = initial_y
    @height = @sprite.height
    @width = @sprite.width
    @delta = 0
  @y_delta = 0
  @ground = 300
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

    if @jump_cooldown > 0
      @jump_cooldown -= GRAVITY
      if @jump_cooldown <= 0
        @jump_cooldown = 0
        @falling = true
      end
    end

    if @pos_y < (@ground - @height - MAX_JUMP)
      @falling = true
    end

    if @falling
      if @pos_y + @height < @ground
        @pos_y += GRAVITY
      end
    end

    if @pos_y + @height >= @ground
      @falling = false
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

    if up_pressed
      if @falling
        return
      end
      @jump_cooldown += JUMP_VELOCITY
      if @jump_cooldown > MAX_JUMP
        @jump_cooldown = MAX_JUMP
      end
      delta = (JUMP_SPEED * @jump_cooldown) / 10
      @pos_y -= delta
    end

  end

  def draw
    @sprite.draw(@pos_x, @pos_y, 2, scale_x = 1, scale_y = 1, color = 0xff_ffffff, mode = :default)

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