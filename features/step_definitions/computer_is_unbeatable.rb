Given(/^there is a game with two computers$/) do
  steps %{ Given there is a game waiting }
  add_computer_as_player_one
  add_computer_as_player_two
end

When(/^they play against eachother$/) do
  8.times { @game.make_move(@game.current_player.ask_for_recommendation) }
end

Then(/^no one should win$/) do
  expect{ @game.make_move(@game.current_player.ask_for_recommendation) }.to raise_error(DrawGameError)
end

def add_computer_as_player_one
  @game.add_player(Ai.new(grid: @grid))
  @game.player_one.marker = :X
  @game.player_one.solutions_calculator = SolutionsCalculator.new(
    grid:   @grid,
    marker: @game.player_one.marker
  )
end

def add_computer_as_player_two
  @game.add_player(Ai.new(grid: @grid))
  @game.player_two.marker = :O
  @game.player_two.solutions_calculator = SolutionsCalculator.new(
    grid:   @grid,
    marker: @game.player_two.marker
  )
end

def prepare_a_new_game
  @game = Game.new
  @grid = Grid.new(size: 3)
  @grid.set_content_with(Cell)
end
