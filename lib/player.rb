class Player
  attr_reader   :name,   :grid, :moves_count
  attr_accessor :marker, :solutions_calculator

  def initialize(options = {})
    @name        = options.fetch(:name)
    @grid        = options.fetch(:grid)
    @winner      = false
    @moves_count = 0
  end

  def winner?
    @winner
  end

  def place_marker(at_coordinate)
    become_winner if winning_solutions.include?(at_coordinate)
    grid.place_marker(at_coordinate, marker)
    increase_moves_count_by_one
  end

  def winning_solutions
    solutions_calculator.winning_solutions
  end

  def ask_for_recommendation
    case moves_count
    when 0 then solutions_calculator.first_move_recommendation
    when 1 then solutions_calculator.second_move_recommendation
    when 2 then solutions_calculator.third_move_recommendation
    else
      solutions_calculator.recommendation
    end
  end

  private

  def increase_moves_count_by_one
    @moves_count += 1
  end

  def become_winner
    @winner = true
  end
end
