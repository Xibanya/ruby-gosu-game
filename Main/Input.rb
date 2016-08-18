module Input

  INPUT_COOLDOWN = 10

  def down_pressed
    if @input_cooldown <= 0 && (Gosu::button_down? Gosu::KbDown)
        @input_cooldown = INPUT_COOLDOWN
        true
    end
  end

  def esc_pressed
    if @input_cooldown <= 0 && (Gosu::button_down? Gosu::KbEscape)
        @input_cooldown = INPUT_COOLDOWN
        true
    end
  end

  def up_pressed
    if @input_cooldown <= 0 && (Gosu::button_down? Gosu::KbUp)
        @input_cooldown = INPUT_COOLDOWN
        true
    end
  end

  def confirm_pressed
    if @input_cooldown <= 0 && (Gosu::button_down? Gosu::KbReturn)
        @input_cooldown = INPUT_COOLDOWN
        true
    end
  end

end