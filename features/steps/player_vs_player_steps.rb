require './spec/spec_helper'

Given(/^there is a game waiting$/) do
  @game = Game.new
  @grid = Grid.new(size: 3)
  @grid.set_content_with(Cell)
end

Given(/^"([^"]*)" and "([^"]*)" join the game$/) do |player_one_name, player_two_name|
  @game.add_player(Player.new(name: player_one_name, grid: @grid))
  @game.add_player(Player.new(name: player_two_name, grid: @grid))
end

Given(/^"([^"]*)"'s marker is "([^"]*)"$/) do |name, marker|
  @game.find_player_by_name(name).marker = marker
  @game.find_player_by_name(name).solutions_calculator = SolutionsCalculator.new(
    grid:   @game.find_player_by_name(name).grid,
    marker: @game.find_player_by_name(name).marker,
  )
end

Given(/^the grid looks like this:$/) do |table|
  @game.make_move(:A1)
  @game.make_move(:B2)
  @game.make_move(:A2)
  @game.make_move(:C2)
end

Given(/^now the grid looks like this:$/) do |table|
  @game.make_move(:A1)
  @game.make_move(:B1)
  @game.make_move(:C1)
  @game.make_move(:B2)
  @game.make_move(:A2)
  @game.make_move(:A3)
  @game.make_move(:B3)
  @game.make_move(:C2)
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
