require_relative 'WidgetWindow'
require_relative 'Title'

class GameEngine

  # Control States
  NONE = 0
  TITLE = 1
  MAIN = 2

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
          @window_list.push(Title.new(@window))
          @control_state = TITLE
          @pending_control_state = NONE
        else
          puts 'pending control state is something else'
      end
    end

    if @window_list.length > 0
      i = 0
      while i < @window_list.length
        @window_list[i].update
        if @window_list[i].terminated
          @window_list.delete_at(i)

        else
        i += 1
      end
    end

    end
    end

  def draw
    @window_list.each do |window|
      window.draw
    end
  end

end