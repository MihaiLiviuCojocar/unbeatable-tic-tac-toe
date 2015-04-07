require_relative 'player'

class Ai < Player
  def initialize(opt = {})
    super(name: 'Computer', grid: opt[:grid])
  end

  def ask_for_recommendation
      return solutions_calculator.first_move_recommendation if first_move?
      return solutions_calculator.second_move_recommendation if second_move?
      return solutions_calculator.third_move_recommendation if third_move?
      solutions_calculator.recommendation
  end

  private

  def first_move?
    moves_count == 0
  end

  def second_move?
    moves_count == 1
  end

  def third_move?
    moves_count == 2
  end
end
