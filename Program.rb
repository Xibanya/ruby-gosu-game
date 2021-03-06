require 'gosu'
require_relative 'Main/GameEngine'
require_relative 'Main/GameState'

class GameWindow < Gosu::Window

  include GameState

  FULLSCREEN = true
  WINDOWED = false

  attr_accessor :game_engine
  attr_accessor :fullscreen

  def initialize(fullscreen)
    @fullscreen = fullscreen
    super(RESOLUTION_WIDTH, RESOLUTION_HEIGHT, fullscreen: @fullscreen)
    self.caption = GAME_TITLE
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

window = GameWindow.new(false)
window.show