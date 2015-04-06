require_relative 'player'

class Ai < Player
  def initialize(opt = {})
    super(name: 'Computer', grid: opt[:grid])
  end

  def ask_for_recommendation
    case moves_count
      when 0 then solutions_calculator.first_move_recommendation
      when 1 then solutions_calculator.second_move_recommendation
      when 2 then solutions_calculator.third_move_recommendation
      else solutions_calculator.recommendation
    end
  end
end
