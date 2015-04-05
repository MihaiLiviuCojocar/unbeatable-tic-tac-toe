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
  @game.make_move(@game.current_player.solutions_calculator.first_move_recommendation)
  @game.make_move(@game.current_player.solutions_calculator.first_move_recommendation)
  @game.make_move(@game.current_player.solutions_calculator.second_move_recommendation)
  @game.make_move(@game.current_player.solutions_calculator.second_move_recommendation)
  @game.make_move(@game.current_player.solutions_calculator.third_move_recommendation)
  @game.make_move(@game.current_player.solutions_calculator.third_move_recommendation)
  @game.make_move(@game.current_player.solutions_calculator.recommendation)
  @game.make_move(@game.current_player.solutions_calculator.recommendation)
end

Then(/^no one should win$/) do
  coord = @game.current_player.solutions_calculator.recommendation
  expect{ @game.make_move(coord) }.to raise_error(DrawGameError)
end
