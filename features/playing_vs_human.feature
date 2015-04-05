Feature: Plying vs human

  Scenario: Second player joins
    Given I am alredy registered
    And I want to play against another human
    Then the second player should be asked to register
