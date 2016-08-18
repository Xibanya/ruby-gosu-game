require_relative 'GameEngine'

class Title < WidgetWindow

  TITLE_MENU = 0
  START = 0
  OPTIONS = 1
  QUIT = 2

  OPTIONS_MENU = 1
  FULLSCREEN = 0
  BACK = 1

  def initialize(window)
    super
    @title_pos_x = 50
    @title_pos_y = 50


    @current_menu = TITLE_MENU

    @title_items = ['Start', 'Options', 'Quit']
    @title_selection = 0

    @options_items = ['Fullscreen', 'Back']
    @options_selection = 0
  end

  def update(parent)
    super

    # change selected item
    if down_pressed
      if @current_menu == TITLE_MENU
        @title_selection += 1
        @title_selection = 0 if @title_selection >= @title_items.length
      elsif @current_menu == OPTIONS_MENU
        @options_selection += 1
        @options_selection = 0 if @options_selection >= @options_items.length
      end

    elsif up_pressed
      if @current_menu == TITLE_MENU
        @title_selection -= 1
        @title_selection = @title_items.length - 1 if @title_selection < 0
      elsif @current_menu == OPTIONS_MENU
        @options_selection -= 1
        @options_selection = @options_items.length - 1 if @options_selection < 0
      end

      # ----------------------

      # select an item
    elsif confirm_pressed

      # if we're looking at the title menu
      if @current_menu == TITLE_MENU
        case @title_selection
          when START
            parent.pending_control_state = GameEngine::MAIN
            self.terminated = true
          when OPTIONS
            @current_menu = OPTIONS_MENU
          when QUIT
            @window.close
          else
            puts 'Unexpected value'
        end
        # if the current menu we're looking at is the options menu
      elsif @current_menu == OPTIONS_MENU
        case @options_selection
          when FULLSCREEN
            puts 'toggle fullscreen'
            if @window.fullscreen
              # ONCE YOU GO FULLSCREEN THERE'S NO GOING BACK
              # ie there's some kind of bug here
              @window.fullscreen = false
            else
              @window.fullscreen = true
            end
            new_window = GameWindow.new(@window.fullscreen)
            new_window.show
            @window.close
          when BACK
            @current_menu = TITLE_MENU
            @options_selection = 0
        end
      end
      # ---------------
    end

  end

  def draw
    super

    draw_box(20, 20, @text_box_z, 70, 40)

    if @current_menu == TITLE_MENU
      draw_title_menu
    elsif @current_menu == OPTIONS_MENU
      draw_options_menu
    end

  end

  def draw_title_menu
    @font.draw_centered_text('Title Menu', RESOLUTION_WIDTH / 2, @title_pos_y, 1.5, UNSELECTED)
    for i in 0..@title_items.length
      color = UNSELECTED
      if i == @title_selection
        color = SELECTED
      end
      @font.draw_text(@title_items[i], @title_pos_x, @title_pos_y + 70, i, color)
    end
  end

  def draw_options_menu
    @font.draw_centered_text('Options Menu', RESOLUTION_WIDTH / 2, @title_pos_y, 1.5, UNSELECTED)
    for i in 0..@options_items.length
      color = UNSELECTED
      if i == @options_selection
        color = SELECTED
      end
      @font.draw_text(@options_items[i], @title_pos_x, @title_pos_y + 70, i, color)
    end
  end

end