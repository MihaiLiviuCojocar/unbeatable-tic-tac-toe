module MinimaxRecommendation
  def final_state_score(game_state)
    return 1 if game_state.has_winner? and i_am_winner?(game_state)
    return 0 if game_state.draw?
    return -1
  end

  def minimax_recommendation
    minimax(game)
    return best_move
  end

  private

  attr_reader :best_move

  def minimax(game)
    return final_state_score(game) if game.over?
    scores = []
    moves  = []

    game.available_moves.each do |move|
      possible_game = Marshal.load(Marshal.dump(game))
      begin
        possible_game.make_move(move)
      rescue GameOverError
      rescue DrawGameError
      end
      scores << minimax(possible_game)
      moves << move
    end

    if i_am_current_player?(game)
      max_score_index = scores.index(scores.max)
      @best_move      = moves[max_score_index]
      return scores[max_score_index]
    else
      min_score_index = scores.index(scores.min)
      @best_move      = moves[min_score_index]
      return scores[min_score_index]
    end
  end

  def i_am_winner?(game)
    game.winner.marker == marker
  end

  def i_am_current_player?(game)
    game.current_player.marker == marker
  end
end
