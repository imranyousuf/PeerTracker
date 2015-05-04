Feature: add/remove students to teams
  As an instructor,
  I want to add/remove students to the teams
  So that I can conveniently oversee their work in a team

  Background: 
    Given the following users exist:
      | first_name    | last_name      | user_id          | email            | password | created_at  | updated_at  |
      | Kevin         | Casey          | 00000002         | kev@berkeley.edu | password | 30-Nov-2014 | 30-Nov-2014 |
      | Masta         | Ruiqi          | 12345678         | rw@carry.com     | password | 25-Nov-1992 | 25-Nov-1992 |
      | Masta         | Phyllis        | 23421232         | pk@carry.com     | password | 30-Nov-2000 | 30-Nov-2000 |
    Given the following roles exist:
      | name          | 
      | admin         |
      | instructor    |
      | student       |
    Given the following users_roles exist:
      | user_id  | role_id |
      | 00000002 | 2       |
      | 12345678 | 3       |
      | 23421232 | 3       |
    Given the following courses exist:
      | course_name | user_id  | 
      | CS 169      | 00000002 |
    Given the following courses_users exist:
      | user_id     | course_id    |
      | 00000002    | 1            |
      | 12345678    | 1            |
      | 23421232    | 1            |

  Scenario: Add a student to a team
    Given I am signed on with uid: 00000002
    And I am on view teams page for course "CS 169"
    Then I should see "Your Teams"
    And I follow "New Team"
    When I fill in "team[name]" with "Team Best"
    And I fill in "student_sid_1" with "12345678"
    And I vague click "save_team"
    Then I should be on view teams page for course "CS 169"
    Then I should see "Team was successfully created."
    Then I should see "Team Best"
    Then I should see "Masta Ruiqi"
  
  Scenario: Try to add an unenrolled student to team
    Given I am signed on with uid: 00000002
    And I am on view teams page for course "CS 169"
    Then I should see "Your Teams"
    And I follow "New Team"
    When I fill in "team[name]" with "Team Best"
    And I fill in "student_sid_1" with "12345679"
    And I vague click "save_team"
    Then I should see "Student with SID: 12345679 is not enrolled in this class"

  Scenario: Try to add team with an existing name
    Given I am signed on with uid: 00000002
    And I am on view teams page for course "CS 169"
    Then I should see "Your Teams"
    And I follow "New Team"
    When I fill in "team[name]" with "Team Noob"
    And I vague click "save_team"
    And I am on view teams page for course "CS 169"
    And I follow "New Team"
    When I fill in "team[name]" with "Team Noob"
    And I vague click "save_team"
    Then I should see "Team name exists"

  Scenario: Remove a student from a team
    Given I am signed on with uid: 00000002
    And I am on view teams page for course "CS 169"
    And I follow "New Team"
    When I fill in "team[name]" with "Team Best"
    And I fill in "student_sid_1" with ""
    And I vague click "save_team"
    Then I should not see "Masta Ruiqi"







