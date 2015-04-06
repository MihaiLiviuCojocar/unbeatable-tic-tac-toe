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
