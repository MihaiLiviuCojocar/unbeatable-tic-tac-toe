Given(/^there is a game with two computers$/) do
  steps %{ Given there is a game waiting }
  add_computer_as_player_one
  add_computer_as_player_two
end

When(/^they play against eachother$/) do
  8.times do
    coord = @game.current_player.ask_for_recommendation
    @game.make_move(coord)
   end
end

Then(/^no one should win$/) do
  expect{ @game.make_move(@game.current_player.ask_for_recommendation) }.to raise_error(DrawGameError)
end
