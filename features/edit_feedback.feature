Feature:
  As a student
  I want to be able to edit my feedback before a given deadline
  So that I can update my feedback to accurately reflect my opinions

  Background:
    Given the following students exist:
      | name          | team        | teacher         | course      |
      | Abby          | USA         | Obama           | IR          |
      | Briana        | USA         | Obama           | IR          |
    Given the following feedback exists:
      | writer        | recipient   | rating          | content     |
      | Abby          | Briana      | 1               | "u suck"    |
    Given I am logged in as Abby

  Scenario:
    Given I am on the edit page for the feedback to "Briana"
    And I fill in "content" with "u rok"
    And I fill in "rating" with "9"
    And I click "Submit"
    And I am on the view page for the feedback to "Briana"
    Then I should see "u rok"
    And I should not see "u suck"
    And I should see "9"
    And I should not see "1" 