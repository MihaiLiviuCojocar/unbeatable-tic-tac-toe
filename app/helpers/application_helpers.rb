module ApplicationHelpers
  def computer_makes_his_move(game)
    if game.current_player.is_a?(Ai) and game.current_player.solutions_calculator.respond_to?(:recommendation)
      game.make_move(game.current_player.ask_for_rule_based_recommendation)
    end
    if game.current_player.is_a?(Ai) and game.current_player.solutions_calculator.respond_to?(:minimax_recommendation)
      game.make_move(game.current_player.ask_for_minimax_recommendation)
    end
  end
end
