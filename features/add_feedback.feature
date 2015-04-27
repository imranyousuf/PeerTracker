Feature:
  As a student
  So that I can accurately reflect my opinions on my teammates
  I want to be able to add a feedback before a given deadline

  Background:
    Given the following users exist:
      | first_name    | last_name       | user_id          | email            | password | created_at  | updated_at  |
      | Kevin         | Casey           | 00000002         | kev@berkeley.edu | password | 30-Nov-2014 | 30-Nov-2014 |
      | Masta         | Ruiqi           | 12345678         | rw@carry.com     | password | 25-Nov-1992 | 25-Nov-1992 |
      | Masta         | Phyllis         | 23421232         | pk@carry.com     | password | 30-Nov-2000 | 30-Nov-2000 |
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
    Given the following teams exist:
      | name       | course_id |
      | Kevin Dogs | 1         |
    Given the following users_teams exist:
      | user_id    | team_id |
      | 12345678   | 1       |
      | 23421232   | 1       |
      | 00000002   | 1       |
    Given the following assignments exist:
      | assignment_name | course_id | deadline    | created_at  | updated_at  |
      | Project 1       | 1         | 11-Apr-2015 | 04-Apr-2015 | 04-Apr-2015 |
      | Project 2       | 1         | 16-Apr-2300 | 13-Apr-2015 | 13-Apr-2015 |
    
  Scenario: Add a new feedback
    Given I am signed on with uid: 12345678
    Given I am on all feedbacks page for course "CS 169", team "Kevin Dogs", assignment "Project 2"
    And I vague click "newfeedback"
    When I select "Masta Phyllis" from "user[user_id]"
    And I fill in "comments" with "i tried so hard" 
    And I fill in "rating" with "15"
    And I vague click "submit"
    Then I should be on all feedbacks page for course "CS 169", team "Kevin Dogs", assignment "Project 2"
    Then I should see "Feedback was successfully created"
