Feature: add new teachers
  As a teacher
  I want to add new teachers to the course
  So that I can add new teachers to the staff

  Background: Given the course is set up
    Given I am logged in as a Teacher
    Given I am on the "Add Teacher(s)" page
    Given the following teachers exist:
      | name          | course      |
      | Armando Fox   | CS169       |

  Scenario: Add a teacher
    When I follow "Add Teacher(s)"
    And I fill in "Kevin Casey" for "Teacher(s) to add"
    When I follow "Add"
    Then I should see "Kevin Casey"
    And I should see "Kevin Casey added by teacher@teacher.com"
    And I should see "Armando Fox"