require './spec/spec_helper'

Given(/^there is a game waiting$/) do
  prepare_a_new_game
end

Given(/^"([^"]*)" and "([^"]*)" join the game$/) do |player_one_name, player_two_name|
  @game.add_player(Player.new(name: player_one_name, grid: @grid))
  @game.add_player(Player.new(name: player_two_name, grid: @grid))
end

Given(/^"([^"]*)"'s marker is "([^"]*)"$/) do |name, marker|
  player = @game.find_player_by_name(name)
  player.marker = marker
  player.solutions_calculator = SolutionsCalculator.new(
    grid:   player.grid,
    marker: player.marker,
  )
end

Given(/^the grid looks like this:$/) do |table|
  coordinates = [:A1, :B2, :A2, :C2]
  coordinates.each { |at_coordinate| @game.make_move(at_coordinate)  }
end

Given(/^now the grid looks like this:$/) do |table|
  coordinates = [:A1, :B1, :C1, :B2, :A2, :A3, :B3, :C2]
  coordinates.each { |at_coordinate| @game.make_move(at_coordinate)  }
end

When(/^"([^"]*)" places his marker at "([^"]*)"$/) do |name, coordinate|
  @game.find_player_by_name(name).place_marker(coordinate.to_sym)
end

When(/^current player places his marker at "([^"]*)"$/) do |at_coordinate|
  begin
    @game.make_move(at_coordinate.to_sym)
  rescue DrawGameError => e
  end
end

Then(/^the game should say "([^"]*)"$/) do |message|
  expect{ @game.switch_turns }.to raise_error(message)
end
