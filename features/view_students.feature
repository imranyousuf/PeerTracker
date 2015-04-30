Feature:
  As an Instructor
  So that I can see who is in one of my teams
  I want to be able see all of my students across my sections

  Background:
    Given the following users exist:
      | first_name    | last_name       | user_id          | email            | password | created_at  | updated_at  |
      | Masta         | Casey           | 00000001         | kev@berkel2y.edu | password | 30-Nov-2014 | 30-Nov-2014 |
      | Kevin         | Casey           | 00000002         | kev@berkeley.edu | password | 30-Nov-2014 | 30-Nov-2014 |
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
      | 00000002 | 2       |
      | 12345678 | 3       |
      | 23421232 | 3       |
    Given the following courses exist:
      | course_name | user_id  | 
      | CS 162      | 00000001 |
    Given the following courses_users exist:
      | user_id     | course_id    |
      | 00000002    | 1            |
      | 12345678    | 1            |
      | 23421232    | 1            |
    Given the following teams exist:
      | name       | course_id |
      | Kevin Dogs | 1         |
      | Kevin Cats | 1         |
    Given the following users_teams exist:
      | user_id    | team_id |
      | 12345678   | 1       |
      | 23421232   | 2       |
      | 00000002   | 1       |
      | 00000002   | 2       |
 
 Scenario: View students
    Given I am signed on with uid: 00000002
    And I am on view users page
    Then I should see "Masta Ruiqi"
    Then I should see "Masta Phyllis"

  

