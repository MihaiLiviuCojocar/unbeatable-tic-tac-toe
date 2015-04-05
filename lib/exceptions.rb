class GameFullError < Exception
  def to_s
    'The game is full!'
  end
end

class GameOverError < Exception
  def initialize(name)
    @name = name
  end

  def to_s
    "Game over! #{@name} wins!"
  end
end

class DrawGameError < Exception
  def to_s
    'Draw! Nobody wins! :)'
  end
end
