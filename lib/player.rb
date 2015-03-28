class Player
  attr_reader   :name,   :grid
  attr_accessor :marker, :solutions_calculator

  def initialize(options = {})
    @name   = options.fetch(:name)
    @grid   = options.fetch(:grid)
    @winner = false
  end

  def winner?
    @winner
  end

  def place_marker(at_coordinate)
    grid.place_marker(at_coordinate, marker)
    become_winner if winning_solutions.include?(at_coordinate)
  end

  def winning_solutions
    solutions_calculator.winning_solutions
  end

  private

  def become_winner
    @winner = true
  end
end
