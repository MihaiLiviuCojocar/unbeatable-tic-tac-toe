require_relative 'player'

class Ai < Player
  def initialize(opt = {})
    super(name: 'Computer', grid: opt[:grid])
  end

  def make_first_move
    mark_middle or mark_a_corner
  end

  private

  def mark_middle
    grid.place_marker(grid.middle_coordinate, marker) if is_middle_free?
  end

  def is_middle_free?
    grid.is_middle_free?
  end

  def mark_a_corner
    coordinate = grid.corner_coordinates.sample
    grid.place_marker(coordinate, marker)
  end
end
