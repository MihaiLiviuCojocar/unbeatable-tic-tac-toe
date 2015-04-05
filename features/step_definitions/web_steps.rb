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
