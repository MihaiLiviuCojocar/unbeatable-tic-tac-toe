module MinimaxRecommendation
  def final_state_score(game_state, depth)
    return 10 - depth if game_state.has_winner? and i_am_winner?(game_state)
    return depth - 10 if game_state.has_winner? and !i_am_winner?(game_state)
    0
  end

  def i_am_winner?(game_state)
    game_state.winner.marker == marker
  end

  def intermediate_state_score(game_state, depth)
    return final_state_score(game_state, depth) if game_state.over?
    score ||= 0
    game_state.available_moves.each do |move|
      possible_game = Marshal.load(Marshal.dump(game_state))
      begin
        possible_game.make_move(move)
      rescue GameOverError
      rescue DrawGameError
      end
      score += intermediate_state_score(possible_game, depth + 1)
    end
    return score
  end

  def minimax(game_state, depth, maximizing_player)
    return winning_solutions.first if maximizing_player
    available_moves = {}
    game_state.available_moves.each do |move|
      possible_game = Marshal.load(Marshal.dump(game_state))
      begin
        possible_game.make_move(move)
      rescue GameOverError
      rescue DrawGameError
      end
      available_moves[move] = intermediate_state_score(possible_game, depth + 1)
    end
    p '+++' * 20
    p available_moves
    max_score = available_moves.values.max
    best_move = available_moves.key(max_score)
    return best_move
  end

  def best_move
    @best_move
  end

  def recommendation
    # p '===' * 20
    # p winning_solutions
    minimax(game, 0, winning_solutions.any?)
  end
end
