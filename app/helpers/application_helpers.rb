module ApplicationHelpers
  def computer_makes_his_move(game)
    if game.current_player.is_a?(Ai) and game.current_player.solutions_calculator.respond_to?(:recommendation)
      game.make_move(game.current_player.ask_for_rule_based_recommendation)
    end
    if game.current_player.is_a?(Ai) and game.current_player.solutions_calculator.respond_to?(:minimax_recommendation)
      game.make_move(game.current_player.ask_for_minimax_recommendation(game))
    end
  end

  def prepare_player(player, game)
    assign_marker_to_player(player, game)
    player.solutions_calculator = SolutionsCalculator.new(
      grid:   game.grid,
      marker: player.marker
    )
  end

  def prepare_minimax_ai(ai, game)
    assign_marker_to_player(ai, game)
    ai.solutions_calculator = SolutionsCalculator.new(
      grid:   game.grid,
      marker: ai.marker
    ).extend(MinimaxRecommendation)
  end

  def prepare_rule_based_ai(ai, game)
    assign_marker_to_player(ai, game)
    ai.solutions_calculator = SolutionsCalculator.new(
      grid:   game.grid,
      marker: ai.marker
    ).extend(Recommendation)
  end

  def assign_marker_to_player(player, game)
    player.marker = game.player_one == player ? :X : :O
  end
end
