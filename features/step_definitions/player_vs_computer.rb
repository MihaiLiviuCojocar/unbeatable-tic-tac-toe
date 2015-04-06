Given(/^there is a game with two computers$/) do
  steps %{ Given there is a game waiting }
  @game.add_player(Ai.new(grid: @grid))
  @game.add_player(Ai.new(grid: @grid))
  @game.player_one.marker = :X
  @game.player_two.marker = :O
  @game.player_one.solutions_calculator = SolutionsCalculator.new(
    grid:   @grid,
    marker: @game.player_one.marker
  )
  @game.player_two.solutions_calculator = SolutionsCalculator.new(
    grid:   @grid,
    marker: @game.player_two.marker
  )
end

Given(/^"([^"]*)" joins the game$/) do |name|
  @game.add_player(Player.new(name: name, grid: @grid))
end

Given(/^player one is a computer$/) do
  @game.add_player(Ai.new(grid: @grid))
end

Then(/^the computer should move at "([^"]*)"$/) do |coordinate|
  expect(@game.current_player.solutions_calculator.recommendation).to eq coordinate.to_sym
end

When(/^they play against eachother$/) do
  8.times { @game.make_move(@game.current_player.ask_for_recommendation) }
end

Then(/^no one should win$/) do
  expect{ @game.make_move(@game.current_player.ask_for_recommendation) }.to raise_error(DrawGameError)
end
