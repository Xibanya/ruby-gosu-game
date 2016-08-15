require_relative 'GameEngine'

class MainGame < WidgetWindow

# Pause Menu Items
  RESUME = 0
  QUIT = 1

  def initialize(window)
    super
    @title_pos_x = 50
    @title_pos_y = 50


    @paused = false

    @pause_items = ['Resume', 'Quit To Title']
    @pause_selection = 0

  end

  def update(parent)
    super

    ############################
    #
    # PAUSE MENU
    #
    ############################
    if @paused
    # change selected item
    if down_pressed
        @pause_selection += 1
        @pause_selection = 0 if @pause_selection >= @pause_items.length

    elsif up_pressed
        @pause_selection -= 1
        @pause_selection = @pause_items.length - 1 if @pause_selection < 0

      # ----------------------

      # select an item
    elsif confirm_pressed
      if @pause_selection == RESUME
        @paused = false
      elsif @pause_selection == QUIT
        parent.pending_control_state = GameEngine::TITLE
        self.terminated = true
      end
      # ---------------
    end
      #end if paused
    ##############################

    ##############################
    #
    # NOT PAUSED
    #
    ###############################
    else
      if esc_pressed
        @paused = !@paused
      end

    end
    # end input handling

  end

  def draw
    super

    if @paused
      draw_pause_menu
    end

  end

  def draw_pause_menu
    draw_box(20, 20, @text_box_z, 70, 40)
    @font.draw('Game Paused', @title_pos_x, @title_pos_y, @text_z, 1.5, 1.5, UNSELECTED, mode = :default)

    for i in 0..@pause_items.length
      color = UNSELECTED
      if i == @pause_selection
        color = SELECTED
      end
      @font.draw(@pause_items[i], @title_pos_x, @title_pos_y + 70 + (40 * i), @text_z, 1, 1, color, mode = :default)
    end
  end


end