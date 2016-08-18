module GameState

  GAME_TITLE = 'Roobee Game'

  RESOLUTION_WIDTH = 640
  RESOLUTION_HEIGHT = 480

  # Text Colors
  UNSELECTED = Gosu::Color.argb(0xff_ffffff) #white
  SELECTED = Gosu::Color.argb(0xff_00ffff) #aqua

  TEXT_LAYER = 10

  # Control States
  NONE = 0
  TITLE = 1
  MAIN = 2
end