Feature:
  As an Instructor
  So that I can display correct information about an assignment
  I want to be edit an assignment

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
    Given the following users_teams exist:
      | user_id    | team_id |
      | 12345678   | 1       |
      | 23421232   | 1       |
      | 00000002   | 1       |
    
 
 Scenario: Edit an assignment
    Given I am signed on with uid: 00000002
    Given the following assignments exist:
      | assignment_name | course_id | deadline    | created_at  | updated_at  |
      | Project 1       | 1         | 11-Apr-2020 | 04-Apr-2015 | 04-Apr-2015 |
    And I follow "Go to All Assignments"
    And I follow "Edit"
    When I fill in "assignment[assignment_name]" with "Never"
    And I press "Update Assignment"
    Then I should see "All Assignments for CS 162"
    Then I should see "Assignment was successfully updated."  
    Then I should not see "HOORAH"
    Then I should see "Never"

 Scenario: Try to remove name from assignment
    Given I am signed on with uid: 00000002
    Given the following assignments exist:
      | assignment_name | course_id | deadline    | created_at  | updated_at  |
      | Project 1       | 1         | 11-Apr-2020 | 04-Apr-2015 | 04-Apr-2015 |
    And I follow "Go to All Assignments"
    And I follow "Edit"
    When I fill in "assignment[assignment_name]" with ""    
    And I press "Update Assignment"
    Then I should see "Assignment must have a name"
 


  Scenario: Try to edit an old assignment
    Given I am signed on with uid: 00000002
    Given the following assignments exist:
      | assignment_name | course_id | deadline    | created_at  | updated_at  |
      | Project 1       | 1         | 19-Apr-2012 | 04-Apr-2015 | 04-Apr-2015 |
    And I follow "Go to All Assignments"
    Then I should not see "Edit this assignment"
    Then I should see "Project 1"
  
  Scenario: View assignment as student
    Given I am signed on with uid: 12345678
    Given the following assignments exist:
      | assignment_name | course_id | deadline    | created_at  | updated_at  |
      | Project 1       | 1         | 19-Apr-2020 | 04-Apr-2015 | 04-Apr-2015 |
    And I am on view assignments page for course "CS 162", team "Kevin Dogs"
    Then I should see "Assignments for CS 162"


