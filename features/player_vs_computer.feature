Feature: Player vs Computer

  Background:
    Given there is a game waiting
    And player one is a computer
    And "Mihai" joins the game
    And "Computer"'s marker is "X"
    And "Mihai"'s marker is "O"

  Scenario: Computer wins when has the opportunity
    And the grid looks like this:
      |   | 1 | 2 | 3 |
      | A | X | X |   |
      | B |   | O |   |
      | C |   | O |   |
    Then the computer should move at "A3"

  @AndIwillwalk500miles
  Scenario: Computer is unbeatable
    Given there is a game waiting
    And "Computer 1" joins the game
    And "Computer 2" joins the game
    And "Computer 1"'s marker is "X"
    And "Computer 2"'s marker is "O"
    When they play against eachother
    Then no one should win
