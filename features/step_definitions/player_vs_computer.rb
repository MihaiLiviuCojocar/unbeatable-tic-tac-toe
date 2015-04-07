Given(/^"([^"]*)" joins the game$/) do |name|
  @game.add_player(Player.new(name: name, grid: @grid))
end

Given(/^player one is a computer$/) do
  add_computer_as_player_one
end

Then(/^the computer should move at "([^"]*)"$/) do |coordinate|
  expect(@game.current_player.solutions_calculator.recommendation).to eq coordinate.to_sym
end
