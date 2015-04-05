Given(/^I am on the homepage$/) do
  visit '/'
end

Then(/^I should see "([^"]*)"$/) do |text|
  expect(page).to have_content text
end

When(/^I register$/) do
  fill_in 'player_name', with: 'Mihai'
  click_on 'Register'
end

Then(/^I should see a welcome message$/) do
  expect(page).to have_content "Welcome, Mihai!"
end

Then(/^I should be asked what kind of a game I want to play$/) do
  expect(page).to have_content "Choose between"
  expect(page).to have_link 'Human'
  expect(page).to have_link 'Computer'
end

Given(/^I am alredy registered$/) do
  steps %{
    Given I am on the homepage
    And I register
  }
end

Given(/^I want to play against another human$/) do
  click_link 'Human'
end

Then(/^the second player should be asked to register$/) do
  expect(page).to have_content 'What is the name of the second player?'
end

Given(/^there are two players registered$/) do
  steps %{
    Given I am alredy registered
    And I want to play against another human
  }
  fill_in "second_player_name", with: 'Roi'
  click_on 'Register'
end

Given(/^player one has cross as a marker$/) do
  expect(page).to have_content "Mihai's marker is X"
end

Given(/^player two has a zerro as a marker$/) do
  expect(page).to have_content "Roi's marker is O"
end

Given(/^there is a fresh game$/) do
  visit '/reset'
end

Given(/^we have a grid like this:$/) do |table|
  select('A', from: 'letter')
  select('1', from: 'number')
  click_on 'Move'
  select('B', from: 'letter')
  select('2', from: 'number')
  click_on 'Move'
  select('A', from: 'letter')
  select('2', from: 'number')
  click_on 'Move'
  select('C', from: 'letter')
  select('2', from: 'number')
  click_on 'Move'
end

When(/^player one places his marker at A(\d+)$/) do |coordinate|
  select('A', from: 'letter')
  select('3', from: 'number')
  click_on 'Move'
end

Then(/^player one wins$/) do
  expect(page).to have_content "Mihai wins!"
end

Then(/^I should have the option to reset$/) do
  expect(page).to have_link 'Reset'
end
