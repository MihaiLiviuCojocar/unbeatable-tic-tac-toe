Feature: Joining a game
  In order to have some fun
  As a bored web surfer
  I want to join a game

  Scenario: Visiting the homepage
    Given I am on the homepage
    Then I should see "Welcome to Tic Tac Toe"

  Scenario: Joining a game
    Given I am on the homepage
    When I register
    Then I should see a welcome message
    And I should be asked what kind of a game I want to play
