Feature: Player vs Computer

  Background:
    Given there is a game waiting
    And player one is a computer
    And "Mihai" joins the game
    And "Mihai"'s marker is "O"

  Scenario: Computer wins when has the opportunity
    And the grid looks like this:
      |   | 1 | 2 | 3 |
      | A | X | X |   |
      | B |   | O |   |
      | C |   | O |   |
    Then the computer should move at "A3"
