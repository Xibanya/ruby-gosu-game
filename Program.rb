require 'gosu'
require_relative 'Main/GameEngine'

class GameWindow < Gosu::Window


  FULLSCREEN = true
  WINDOWED = false

  GAME_TITLE = 'Roobee Game'
  RESOLUTION_WIDTH = 640
  RESOLUTION_HEIGHT = 480

  attr_accessor :game_engine
  attr_accessor :box_sprite
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