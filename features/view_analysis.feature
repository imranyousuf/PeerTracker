Feature:
  As an instructor
  So that I can accurately collect data about a team's progress
  I want to be able to see an analysis of teams.

Background:
   Given the following users exist:
      | first_name    | last_name      | user_id          | email            | password | created_at  | updated_at  |
      | Armando       | Fox            |  00000001        | kev1@berkeley.edu| password | 30-Nov-2014 | 30-Nov-2014 |
      | Kevin         | Casey          |  00000002        | kev@berkeley.edu | password | 30-Nov-2014 | 30-Nov-2014 |
      | Masta         | Ruiqi          | 12345678         | rw@carry.com     | password | 25-Nov-1992 | 25-Nov-1992 |
      | Masta         | Phyllis        | 23421232         | pk@carry.com     | password | 30-Nov-2000 | 30-Nov-2000 |
      | Masta         | Conrad         | 23421233         | pk2@carry.com    | password | 30-Nov-2000 | 30-Nov-2000 |
      | Masta         | Grace          | 23421235         | pk4@carry.com    | password | 30-Nov-2000 | 30-Nov-2000 |
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
      | 23421233 | 3       |
      | 23421235 | 3       |
    Given the following courses exist:
      | course_name | user_id  | 
      | CS 169      | 00000001 |
    Given the following courses_users exist:
      | user_id     | course_id    |
      | 00000002    | 1            |
      | 12345678    | 1            |
      | 23421232    | 1            |
    Given the following teams exist:
      | name       | course_id |
      | Kevin Dogs | 1         |
      | Lol Cats   | 1         |
    Given the following users_teams exist:
      | user_id    | team_id |
      | 12345678   | 1       |
      | 23421232   | 1       |
      | 00000002   | 1       |
      | 00000002   | 2       |
      | 23421233   | 2       |
      | 23421235   | 2       |

    Given the following assignments exist:
      | assignment_name | course_id | deadline    | created_at  | updated_at  |
      | Project 1       | 1         | 11-Jun-2015 | 04-Apr-2015 | 04-Apr-2015 |
      | Project 2       | 1         | 16-Jun-2300 | 13-Apr-2015 | 13-Apr-2015 |
    Given the following feedbacks exist:
      | comments         | rating | giver_id   | receiver_id | team_id | assignment_id |
      | you suck         | 14     | 12345678   | 23421232    | 1       | 2             |
      | I did well       | 26     | 12345678   | 12345678    | 1       | 2             |
      | you were good    | 22     | 23421232   | 12345678    | 1       | 2             |
      | I had no time    | 18     | 23421232   | 23421232    | 1       | 2             |
      | you suck         | 10     | 23421235   | 23421233    | 2       | 2             |
      | I did well       | 30     | 23421235   | 23421235    | 2       | 2             |
      | you were bad     | 13     | 23421233   | 23421233    | 2       | 2             |
      | I had good       | 27     | 23421233   | 23421235    | 2       | 2             |

  Scenario: See average ratings an assignment
    Given I am signed on with uid: 00000002
    Given I am on view assignment page for course "CS 169", assignment "2"
    Then I should see "Masta Ruiqi: 24"
    Then I should see "Masta Phyllis: 16"

  Scenario: Sort by team name
    Given I am signed on with uid: 00000002
    Given I am on view assignment page for course "CS 169", assignment "2"
    And I follow "team name"
    Then I should see "Masta Ruiqi: 24"
    Then I should see "Masta Conrad: 11"
    Then I see "Masta Ruiqi" before "Masta Conrad"

  Scenario: Sort by team name
    Given I am signed on with uid: 00000002
    Given I am on view assignment page for course "CS 169", assignment "2"
    And I follow "minimum score"
    Then I see "Masta Conrad" before "Masta Ruiqi" 
