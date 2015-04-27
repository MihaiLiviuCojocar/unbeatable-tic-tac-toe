module MinimaxRecommendation
  def score(game_state, depth)
    return 10 - depth if game_state.has_winner? and i_am_winner?(game_state)
    return -10 - depth if game_state.has_winner? and !i_am_winner?(game_state)
    0
  end

  def i_am_winner?(game_state)
    game_state.winner.marker == marker
  end

  def maximizing_player
    winning_solutions.any?
  end

  def scores
    @scores ||= []
  end

  def moves
    @moves ||= []
  end

  def minimax(game_state, depth)
    return score(game_state, depth) if game_state.over?

    depth += 1

    interm_moves = []
    game_state.available_moves.each do |move|
      possible_game = Marshal.load(Marshal.dump(game_state))
      begin
        possible_game.make_move(move)
      rescue GameOverError => e
      rescue DrawGameError => e
      end
      scores << minimax(possible_game, depth)
      interm_moves << move
      scores.compact!
    end
    moves << interm_moves
    moves.reverse!
    nil
  end

  def best_move
    max_score_index = scores.index(scores.max)
    moves[max_score_index].first
  end

  def recommendation
    minimax(game, 0)
  end
end
