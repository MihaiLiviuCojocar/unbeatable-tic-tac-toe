describe 'Minimax algorithm' do
  context 'scoring each final game state' do
    it 'scores with 1 a win' do
      # given there is a won game
      # the score should be 1
      marker = :X
      winner = double :player, marker: marker
      game   = double :game,   winner: winner
      solutions_calculator = SolutionsCalculator.new(
        game:   game,
        marker: :X
      ).extend(MinimaxRecommendation)
      
      expect(solutions_calculator.score).to eq 1
    end
  end
end
