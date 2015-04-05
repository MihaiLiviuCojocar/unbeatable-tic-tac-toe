require_relative 'player'

class Ai < Player
  def initialize(opt = {})
    super(name: 'Computer', grid: opt[:grid])
  end

  def make_first_move
    mark_middle if is_middle_free? or mark_a_corner
  end

  def make_second_move
    defend if need_to_defend? or mark_the_middle_of_a_line
  end

  def need_to_defend?
    solutions_calculator.defending_solutions.any?
  end

  def make_move
    attack if can_win? or defend
  end

  def can_win?
    solutions_calculator.winning_solutions.any?
  end

  def attack
    coordinate = solutions_calculator.winning_solutions.first
    place_marker(coordinate)
  end

  private

  def mark_middle
    place_marker(grid.middle_coordinate)
  end

  def mark_the_middle_of_a_line
    coordinate = grid.middle_line_coordinates.sample
    place_marker(coordinate)
  end

  def defend
    coordinate = solutions_calculator.defending_solutions.first
    place_marker(coordinate)
  end

  def is_middle_free?
    grid.has_middle_free?
  end

  def mark_a_corner
    coordinate = grid.corner_coordinates.sample
    place_marker(coordinate)
  end
end
