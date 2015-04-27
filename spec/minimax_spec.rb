describe 'Minimax algorithm' do
  context 'scoring each final game state' do
    it 'scores with 1 a win' do
      marker = :X
      winner = double :player, marker: marker
      game   = double :game,   winner: winner, has_winner?: true
      solutions_calculator = SolutionsCalculator.new(
        game:   game,
        marker: marker
      ).extend(MinimaxRecommendation)

      expect(solutions_calculator.score(game, 0)).to eq 10
    end

    it 'scores with -1 a loss' do
      marker         = :X
      another_marker = :O
      winner         = double :player, marker: marker
      game           = double :game,   winner: winner, has_winner?: true
      solutions_calculator = SolutionsCalculator.new(
        game:   game,
        marker: another_marker
      ).extend(MinimaxRecommendation)

      expect(solutions_calculator.score(game, 0)).to eq -10
    end

    it 'scores with 0 a draw' do
      marker         = :X
      another_marker = :O
      winner         = double :player, marker:      marker
      game           = double :game,   has_winner?: false
      solutions_calculator = SolutionsCalculator.new(
        game:   game,
        marker: another_marker
      ).extend(MinimaxRecommendation)

      expect(solutions_calculator.score(game, 0)).to eq 0
    end
  end

  context 'game tree' do
    it 'calculates score' do
      # given a game state like this
      #   | 1 | 2 | 3 |
      # ---------------
      # A | X | O | X |
      # B | X | O | O |
      # C | O |   | X |
      grid = Grid.new(size: 3)
      grid.set_content_with(Cell)
      game = Game.new(grid: grid)
      p1 = Player.new(name: 'Mihai', grid: grid)
      p2 = Ai.new(grid: grid)
      game.add_player(p1)
      game.add_player(p2)
      p1.marker = :X
      p2.marker = :O
      p1.solutions_calculator = SolutionsCalculator.new(
          game: game,
          marker: :X
        ).extend(MinimaxRecommendation)
      p2.solutions_calculator = SolutionsCalculator.new(
          game: game,
          marker: :O
        ).extend(MinimaxRecommendation)
      moves = [:A1, :A2, :A3, :B2, :B1, :B3, :C3, :C1]
      moves.each do |move|
        game.make_move(move)
      end
      # p game.grid.matrix.values.map { |cell| cell.content }.each_slice(3).to_a.each{|r| p r}
      p1.solutions_calculator.recommendation
      expect(p1.solutions_calculator.scores).to eq([0])
      expect(p1.solutions_calculator.moves).to eq([[:C2]])
    end

    it 'calculates score' do
      # given a game state like this
      #   | 1 | 2 | 3 |
      # ---------------
      # A | X | O | X |
      # B | X | O | O |
      # C |   |   | X |
      grid = Grid.new(size: 3)
      grid.set_content_with(Cell)
      game = Game.new(grid: grid)
      p1 = Player.new(name: 'Mihai', grid: grid)
      p2 = Ai.new(grid: grid)
      game.add_player(p1)
      game.add_player(p2)
      p1.marker = :X
      p2.marker = :O
      p1.solutions_calculator = SolutionsCalculator.new(
          game: game,
          marker: :X
        ).extend(MinimaxRecommendation)
      p2.solutions_calculator = SolutionsCalculator.new(
          game: game,
          marker: :O
        ).extend(MinimaxRecommendation)
      moves = [:A1, :A2, :A3, :B2, :B1, :B3, :C3]
      moves.each do |move|
        game.make_move(move)
      end
      # p game.grid.matrix.values.map { |cell| cell.content }.each_slice(3).to_a.each{|r| p r}
      p2.solutions_calculator.recommendation
      expect(p2.solutions_calculator.scores).to eq([0, 9])
      expect(p2.solutions_calculator.moves).to eq([
          [:C1, :C2],
          [:C2]
        ])
      # expect(p2.solutions_calculator.best_move).to eq(:C2)
    end

    it 'calculates score' do
      # given a game state like this
      #   | 1 | 2 | 3 |
      # ---------------
      # A | X | O | X |
      # B | X | O | O |
      # C |   |   |   |
      grid = Grid.new(size: 3)
      grid.set_content_with(Cell)
      game = Game.new(grid: grid)
      p1 = Player.new(name: 'Mihai', grid: grid)
      p2 = Ai.new(grid: grid)
      game.add_player(p1)
      game.add_player(p2)
      p1.marker = :X
      p2.marker = :O
      p1.solutions_calculator = SolutionsCalculator.new(
          game: game,
          marker: :X
        ).extend(MinimaxRecommendation)
      p2.solutions_calculator = SolutionsCalculator.new(
          game: game,
          marker: :O
        ).extend(MinimaxRecommendation)
      moves = [:A1, :A2, :A3, :B2, :B1, :B3]
      moves.each do |move|
        game.make_move(move)
      end
      # p game.grid.matrix.values.map { |cell| cell.content }.each_slice(3).to_a.each{|r| p r}
      p1.solutions_calculator.recommendation
      p p1.solutions_calculator.moves
      expect(p1.solutions_calculator.scores).to eq([9, 0, 7, 0, -12])
      expect(p1.solutions_calculator.moves).to eq([
          [:C1],
          [:C2, :C1, :C3],
          [:C2, :C3, :C1],
          [:C3, :C1, :C2],
          [:C3, :C2]
        ])
      # expect(p2.solutions_calculator.best_move).to eq(:C1)
    end
  end
end
