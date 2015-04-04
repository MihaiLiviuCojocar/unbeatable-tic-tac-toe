require './spec/spec_helper'

Given(/^there is a game waiting$/) do
  @game = Game.new
  @grid = Grid.new(size: 3)
  @grid.set_content_with(Cell)
end

Given(/^"([^"]*)" and "([^"]*)" join the game$/) do |player_one_name, player_two_name|
  @player_one = Player.new(name: player_one_name, grid: @grid)
  @player_two = Player.new(name: player_two_name, grid: @grid)
  @game.add_player(@player_one)
  @game.add_player(@player_two)
end

Given(/^"([^"]*)"'s marker is "([^"]*)"$/) do |name, marker|
  @game.find_player_by_name(name).marker = marker
  @game.find_player_by_name(name).solutions_calculator = SolutionsCalculator.new(
    grid:   @game.find_player_by_name(name).grid,
    marker: @game.find_player_by_name(name).marker,
  )
end

Given(/^the grid looks like this:$/) do |table|
  @player_one.place_marker(:A1)
  @player_one.place_marker(:A2)
  @player_two.place_marker(:B2)
  @player_two.place_marker(:C2)
end

When(/^"([^"]*)" places his marker at "([^"]*)"$/) do |name, coordinate|
  @game.find_player_by_name(name).place_marker(coordinate.to_sym)
end

Then(/^the game should say "([^"]*)"$/) do |message|
  expect{ @game.switch_turns }.to raise_error(message)
end
