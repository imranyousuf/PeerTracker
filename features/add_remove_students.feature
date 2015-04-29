Feature: add/remove students
  As a professor
  I want to add/remove students to the course
  So that I can accurately reflect enrollment

  Background: 
    Given the following users exist:
      | first_name    | last_name       | user_id          | email            | password | created_at  | updated_at  |
      | Armando       | Fox             | 00000001         | kev@berkeley.edu | password | 30-Nov-2014 | 30-Nov-2014 |
      | Masta         | Ruiqi           | 12345678         | rw@carry.com     | password | 25-Nov-1992 | 25-Nov-1992 |
      | Masta         | Phyllis         | 23421232         | pk@carry.com     | password | 30-Nov-2000 | 30-Nov-2000 |
    Given the following roles exist:
      | name          | 
      | professor     |
      | instructor    |
      | student       |
    Given the following users_roles exist:
      | user_id  | role_id |
      | 00000001 | 1       |
      | 12345678 | 3       |
      | 23421232 | 3       |
     Given the following courses exist:
      | course_name | user_id  | 
      | CS 169      | 00000001 |

  Scenario: Add student(s)
    Given I am signed on with uid: 00000001
    And I follow "See all students and instructors"
    And I follow "Add Student or Instructor for CS 169"
    And I fill in "user[user_id]" with "12345678"
    And I press "Add Student or Instructor"
    Then I should see "User was successfully added"
    Then I should see "Masta Ruiqi"

  Scenario: Remove student(s)
    Given I am signed on with uid: 00000001
    And I follow "See all students and instructors"
    And I follow "Add Student or Instructor for CS 169"
    And I fill in "user[user_id]" with "12345678"
    And I press "Add Student or Instructor"
    When I follow "Remove from course CS 169"
    Then I should see "Masta Ruiqi was successfully removed from this course."
    Then I should not see "rw@carry.com"
