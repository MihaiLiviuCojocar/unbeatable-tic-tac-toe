require_relative 'player'

class Ai < Player
  def initialize(opt = {})
    super(name: 'Computer', grid: opt[:grid])
  end

  def make_first_move
    mark_middle if is_middle_free? or mark_a_corner
  end

  def make_second_move
    coordinate = solutions_calculator.defending_solutions.first
    grid.place_marker(coordinate, marker)
  end

  def need_to_defend?
    solutions_calculator.defending_solutions.any?
  end

  private

  def mark_middle
    grid.place_marker(grid.middle_coordinate, marker)
  end

  def is_middle_free?
    grid.has_middle_free?
  end

  def mark_a_corner
    coordinate = grid.corner_coordinates.sample
    grid.place_marker(coordinate, marker)
  end
end
