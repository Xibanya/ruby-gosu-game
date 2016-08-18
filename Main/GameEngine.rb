require_relative 'WidgetWindow'
require_relative 'Title'
require_relative 'MainGame'

class GameEngine
  # Control States
  NONE = 0
  TITLE = 1
  MAIN = 2

  attr_accessor :pending_control_state

  def initialize(window)
    @control_state = NONE
    @pending_control_state = TITLE
    @terminate_program = false

    @window = window
    @window_list = Array.new
  end

  def update
    if @terminate_program
      GameWindow.close
    end

    if @pending_control_state != NONE
      case @pending_control_state
        when TITLE
          @current_window = Title.new(@window)
          @control_state = TITLE
          @pending_control_state = NONE
        when MAIN
          @current_window = MainGame.new(@window)
          @control_state = MAIN
          @pending_control_state = NONE
        else
          puts 'pending control state is something else'
      end
    end

    @current_window.update(self)

  end

  def draw
    @current_window.draw
  end

end