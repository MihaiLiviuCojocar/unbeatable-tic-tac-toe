require_relative 'player'

class Ai < Player
  def initialize(opt = {})
    super(name: 'Computer', grid: opt[:grid])
  end

  def ask_for_rule_based_recommendation
    return solutions_calculator.first_move_recommendation if first_move?
    return solutions_calculator.second_move_recommendation if second_move?
    return solutions_calculator.third_move_recommendation if third_move?
    solutions_calculator.recommendation
  end

  def ask_for_minimax_recommendation
    solutions_calculator.recommendation
  end

  private

  def first_move?
    at_current_move?(0)
  end

  def second_move?
    at_current_move?(1)
  end

  def third_move?
    at_current_move?(2)
  end

  def at_current_move?(move)
    moves_count == move
  end
end
