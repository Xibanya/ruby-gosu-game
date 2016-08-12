require 'gosu'
require_relative 'Main/GameEngine'

class GameWindow < Gosu::Window
  attr_accessor :game_engine
  attr_accessor :resolution_width
  attr_accessor :resolution_height
  attr_accessor :fullscreen
  attr_accessor :box_sprite

  def initialize
    @resolution_width = 640
    @resolution_height = 480
    @fullscreen = false
    super(@resolution_width, @resolution_height, fullscreen: @fullscreen)
    self.caption = 'Roobings'
    @game_engine = GameEngine.new(self)

  end

  def update
    if @game_engine
      @game_engine.update
    end
  end

  def draw
      if @game_engine
        @game_engine.draw
      end
  end

end

window = GameWindow.new
window.show