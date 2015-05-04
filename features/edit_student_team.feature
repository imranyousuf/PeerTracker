Feature: change students on teams
  As an instructor,
  I want to change students to the teams
  So that I can correctly oversee their work in a team

  Background: 
    Given the following users exist:
      | first_name    | last_name      | user_id          | email            | password | created_at  | updated_at  |
      | Kevin         | Casey          | 00000002         | kev@berkeley.edu | password | 30-Nov-2014 | 30-Nov-2014 |
      | Masta         | Ruiqi          | 12345678         | rw@carry.com     | password | 25-Nov-1992 | 25-Nov-1992 |
      | Masta         | Phyllis        | 23421232         | pk@carry.com     | password | 30-Nov-2000 | 30-Nov-2000 |
      | Masta         | Phylly         | 23421233         | p2@carry.com     | password | 30-Nov-2000 | 30-Nov-2000 |
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
      | 23421233 | 3       |
    Given the following courses exist:
      | course_name | user_id  | 
      | CS 169      | 00000002 |
    Given the following courses_users exist:
      | user_id     | course_id    |
      | 00000002    | 1            |
      | 12345678    | 1            |
      | 23421232    | 1            |
      | 23421233    | 1            |
  
  Scenario: Edit a student to a team
    Given I am signed on with uid: 00000002
    And I am on view teams page for course "CS 169"
    And I follow "New Team"
    When I fill in "team[name]" with "Team Best"
    And I fill in "student_sid_1" with "12345678"
    And I fill in "student_sid_2" with "23421232"
    And I vague click "save_team" 
    When I am on edit team page for course "CS 169", team "Team Best"
    When I fill in "team[name]" with "Kevin Cats"
    And I fill in "student_sid_1" with "23421233"
    And I vague click "save_team"
    Then I should be on view teams page for course "CS 169"
    Then I should see "Team was successfully updated."
    Then I should not see "Team Best "
    Then I should see "Kevin Cats"
    Then I should not see "Masta Ruiqi"
    Then I should see "Masta Phyllis"
    Then I should see "Masta Phylly"
    
