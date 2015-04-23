def add_computer_as_player_one
  @game.add_player(Ai.new(grid: @grid))
  @game.player_one.marker = :X
  @game.player_one.solutions_calculator = SolutionsCalculator.new(
    game:   @game,
    marker: @game.player_one.marker
  ).extend(Recommendation)
end

def add_computer_as_player_two
  @game.add_player(Ai.new(grid: @grid))
  @game.player_two.marker = :O
  @game.player_two.solutions_calculator = SolutionsCalculator.new(
    game:   @game,
    marker: @game.player_two.marker
  ).extend(Recommendation)
end

def prepare_a_new_game
  @grid = Grid.new(size: 3)
  @grid.set_content_with(Cell)
  @game = Game.new(grid: @grid)
end
