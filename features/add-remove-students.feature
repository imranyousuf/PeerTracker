Feature: add/remove students
  As a teacher
  I want to add/remove students to the course
  So that I can conveniently add/remove students to accurately reflect enrollment

  Background: Given the course is set up
    Given I am logged in as a Teacher
    Given I am on the dashboard of course "CS169"
    Given the following students exist:
      | name          | team        | teacher         | course      |
      | Douglas Kim   | USA         | Kevin           | CS169       |
      | Jonathan Kim  | USA         | Kevin           | CS169       |
    Given I am on the "Add/Remove Students" page

  Scenario: Add student(s)
    When I follow "Add Student(s)"
    And I fill in "Ruiqi Wang, Phil Kwon" for "Student(s) to add"
    And I follow "Add"
    Then I should see "Ruiqi Wang"
    And I should see "Ruiqi Wang added by teacher@teacher.com"
    And I should see "Phil Kwon"
    And I should see "Phil Kwon added by teacher@teacher.com"

  Scenario: Remove student(s)
    When I follow "Remove Student(s)"
    And I check "Douglas Kim"
    And I check "Jonathan Kim"
    And I follow "Remove"
    Then I should not see "Douglas Kim"
    And I should see "Douglas Kim removed by teacher@teacher.com"
    And I should not see "Jonathan Kim"
    And I should see "Jonathan Kim removed by teacher@teacher.com"
