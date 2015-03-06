class GameFullError < Exception
  def to_s
    'The game is full!'
  end
end
