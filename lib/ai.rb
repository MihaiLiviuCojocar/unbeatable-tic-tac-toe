require_relative 'player'

class Ai < Player
  MIDDLE_COORDINATE = :B2

  def initialize(opt = {})
    super(name: 'Computer', grid: opt[:grid])
  end

  def make_first_move
    grid.place_marker(MIDDLE_COORDINATE, marker)
  end
end
