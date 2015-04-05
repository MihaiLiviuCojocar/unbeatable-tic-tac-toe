Feature: Player vs Player

  Background:
    Given there is a game waiting
    And "Mihai" and "Roi" join the game
    And "Mihai"'s marker is "X"
    And "Roi"'s marker is "O"

  Scenario: When there is a winner
    And the grid looks like this:
      |   | 1 | 2 | 3 |
      | A | X | X |   |
      | B |   | O |   |
      | C |   | O |   |
    When "Mihai" places his marker at "A3"
    Then the game should say "Game over! Mihai wins!"

  Scenario: When there is a draw
    And now the grid looks like this:
      |   | 1 | 2 | 3 |
      | A | X | X | O |
      | B | O | O | X |
      | C | X | O |   |
    When current player places his marker at "C3"
    Then the game should say "Draw! Nobody wins! :)"
