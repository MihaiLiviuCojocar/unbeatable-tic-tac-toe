Feature: Playing

  Background:
    Given there is a fresh game
    And there are two players registered
    And player one has cross as a marker
    And player two has a zerro as a marker

  Scenario: First player wins
    And we have a grid like this:
      |   | 1 | 2 | 3 |
      | A | X | X |   |
      | B |   | O |   |
      | C |   | O |   |
    When player one places his marker at A3
    Then player one wins
