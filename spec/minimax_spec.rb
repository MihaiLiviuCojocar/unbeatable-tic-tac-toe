describe 'Minimax algorithm' do
  context 'scoring a final game state' do
    let(:marker)         { :X                             }
    let(:another_marker) { :O                             }
    let(:winner)         { double :player, marker: marker }
    let(:game)           { double :game                   }
    let(:default_depth)  { 0                              }

    before(:each) do
      allow(game).to receive(:winner).and_return(winner)
      allow(game).to receive(:has_winner?).and_return(true)
    end

    it 'scores with 10 a win' do
      solutions_calculator = SolutionsCalculator.new(
        game:   game,
        marker: marker
      ).extend(MinimaxRecommendation)
      expect(solutions_calculator.final_state_score(game, default_depth)).to eq 10
    end

    it 'scores with -1 a loss' do
      allow(game).to receive(:draw?).and_return(false)
      solutions_calculator = SolutionsCalculator.new(
        game:   game,
        marker: another_marker
      ).extend(MinimaxRecommendation)
      expect(solutions_calculator.final_state_score(game, default_depth)).to eq -10
    end

    it 'scores with 0 a draw' do
      allow(game).to receive(:draw?).and_return(true)
      allow(game).to receive(:has_winner?).and_return(false)
      solutions_calculator = SolutionsCalculator.new(
        game:   game,
        marker: another_marker
      ).extend(MinimaxRecommendation)
      expect(solutions_calculator.final_state_score(game, default_depth)).to eq 0
    end
  end

  context 'for different game states' do
    let(:grid) { Grid.new(size: 3)                     }
    let(:game) { Game.new(grid: grid)                  }
    let(:p1)   { Player.new(name: 'Mihai', grid: grid) }
    let(:p2)   { Ai.new(grid: grid)                    }

    before(:each) do
      grid.set_content_with(Cell)
      game.add_player(p1)
      game.add_player(p2)
      p1.marker = :X
      p2.marker = :O
      p1.solutions_calculator = SolutionsCalculator.new(
          game: game,
          marker: p1.marker
        ).extend(MinimaxRecommendation)
      p2.solutions_calculator = SolutionsCalculator.new(
          game: game,
          marker: p2.marker
        ).extend(MinimaxRecommendation)
    end

    it 'recommends best move' do
      # given a game state like this
      #   | 1 | 2 | 3 |
      # ---------------
      # A | X | O | X |
      # B | X | O | O |
      # C | O |   | X |

      moves = [:A1, :A2, :A3, :B2, :B1, :B3, :C3, :C1]
      moves.each do |move|
        game.make_move(move)
      end
      expect(p1.solutions_calculator.minimax_recommendation).to eq :C2
    end

    it 'recommends best move' do
      # given a game state like this
      #   | 1 | 2 | 3 |
      # ---------------
      # A | X | O | X |
      # B | X |   | O |
      # C | O | O | X |

      moves = [:A1, :A2, :A3, :C2, :B1, :B3, :C3, :C1]
      moves.each do |move|
        game.make_move(move)
      end
      expect(p1.solutions_calculator.minimax_recommendation).to eq :B2
    end

    it 'recommends best move' do
      # given a game state like this
      #   | 1 | 2 | 3 |
      # ---------------
      # A | X | O | X |
      # B | X | O | O |
      # C |   |   | X |

      moves = [:A1, :A2, :A3, :B2, :B1, :B3, :C3]
      moves.each do |move|
        game.make_move(move)
      end
      expect(p2.solutions_calculator.minimax_recommendation).to eq :C2
    end

    it 'recommends best move' do
      # given a game state like this
      #   | 1 | 2 | 3 |
      # ---------------
      # A | X | O | X |
      # B | X | O | O |
      # C |   |   |   |

      moves = [:A1, :A2, :A3, :B2, :B1, :B3]
      moves.each do |move|
        game.make_move(move)
      end
      expect(p1.solutions_calculator.minimax_recommendation).to eq :C1
    end

    it 'recommends best move' do
      # given a game state like this
      #   | 1 | 2 | 3 |
      # ---------------
      # A | O | X | X |
      # B | O | X |   |
      # C |   | O | X |

      moves = [:A2, :A1, :A3, :B1, :B2, :C2, :C3]
      moves.each do |move|
        game.make_move(move)
      end
      expect(p2.solutions_calculator.minimax_recommendation).to eq :C1
    end

    it 'recommends best move' do
      # given a game state like this
      #   | 1 | 2 | 3 |
      # ---------------
      # A | X | O | X |
      # B | X | O |   |
      # C | O |   |   |

      moves = [:A1, :A2, :A3, :B2, :B1, :C1]
      moves.each do |move|
        game.make_move(move)
      end
      expect(p1.solutions_calculator.minimax_recommendation).to eq :C2
    end

    it 'recommends best move' do
      # given a game state like this
      #   | 1 | 2 | 3 |
      # ---------------
      # A | X |   |   |
      # B |   | O |   |
      # C | O | X | X |

      moves = [:A1, :B2, :C2, :C1, :C3]
      moves.each do |move|
        game.make_move(move)
      end
      expect(p2.solutions_calculator.minimax_recommendation).to eq :A3
    end

    it 'recommends best move' do
      # given a game state like this
      #   | 1 | 2 | 3 |
      # ---------------
      # A | X |   |   |
      # B | X | O | X |
      # C |   |   | O |

      moves = [:A1, :B2, :B1, :C3, :B3]
      moves.each do |move|
        game.make_move(move)
      end
      expect(p2.solutions_calculator.minimax_recommendation).to eq :C1
    end

    it 'recommends best move' do
      # given a game state like this
      #   | 1 | 2 | 3 |
      # ---------------
      # A | X |   |   |
      # B | X | O |   |
      # C |   |   |   |

      moves = [:A1, :B2, :B1]
      moves.each do |move|
        game.make_move(move)
      end
      expect(p2.solutions_calculator.minimax_recommendation).to eq :C1
    end

    it 'recommends best move' do
      # given a game state like this
      #   | 1 | 2 | 3 |
      # ---------------
      # A | X |   |   |
      # B |   | O |   |
      # C | X |   |   |

      moves = [:A1, :B2, :C1]
      moves.each do |move|
        game.make_move(move)
      end
      expect(p2.solutions_calculator.minimax_recommendation).to eq :B1
    end

    it 'recommends best move' do
      # given a game state like this
      #   | 1 | 2 | 3 |
      # ---------------
      # A | O |   |   |
      # B |   | X |   |
      # C |   | O | X |

      moves = [:B2, :A1, :C3, :C2]
      moves.each do |move|
        game.make_move(move)
      end
      expect(p1.solutions_calculator.minimax_recommendation).to eq :A3
    end
  end
end
