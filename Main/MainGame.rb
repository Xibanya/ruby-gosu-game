require_relative 'GameEngine'
require_relative '../Characters/Hero'

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

    @serghei = Hero.new(30, 0)

    @platforms = Array.new
    @mobs = Array.new

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
          parent.pending_control_state = TITLE
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

      else
        @serghei.update(@platforms)

      end
      # end input handling
    end

  end

  def draw
    super

    if @paused
      draw_pause_menu
    else
      draw_hud
    end



    if @platforms.length > 0
      @platforms.each do |platform|
        platform.draw
      end
    end

    if @mobs.length > 0
      @mobs.each do |mob|
        mob.draw
      end
    end

    @serghei.draw

  end

  def draw_hud
    @font.draw("Pretend this is a good-lookin' HUD", 15, 15, TEXT_LAYER, 0.7, 0.7, UNSELECTED, mode = :default)

  end

  def draw_pause_menu
    draw_box(20, 20, BOX_DEPTH, 70, 40)
    @font.draw_centered_text('Game Paused', RESOLUTION_WIDTH / 2, @title_pos_y, 1.5, UNSELECTED)


    for i in 0..@pause_items.length
      color = UNSELECTED
      if i == @pause_selection
        color = SELECTED
      end
      @font.draw_text(@pause_items[i], @title_pos_x, @title_pos_y + 70, i, color)
    end
  end


end