Feature:
  As a student
  So that I can accurately reflect my opinions on my teammates
  I want to be able to add a feedback before a given deadline

  Background:
    Given the following users exist:
      | name          | uid          | email            | password | encrypted_password | created_at  | updated_at  |
      | Kevin Casey   | 00000002     | kev@berkeley.edu | password | no_password        | 30-Nov-2014 | 30-Nov-2014 |
      | Masta Ruiqi   | 12345678     | rw@carry.com     | password | no_password        | 25-Nov-1992 | 25-Nov-1992 |
      | Masta Phyllis | 23421232     | pk@carry.com     | password | no_password        | 30-Nov-2000 | 30-Nov-2000 |
    Given the following users_roles exist:
      | user_id | role_id |
      | 1       | 2       |
      | 2       | 3       |
      | 3       | 3       |
    Given the following courses exist:
      | course_name |
      | CS 169      |
    Given the following courses_users exist:
      | uid         | course_id    |
      | 00000002    | 1            |
      | 12345678    | 1            |
      | 23421232    | 1            |
    Given the following teams exist:
      | name       | course_id | instructor_uid |
      | Kevin Dogs | 1         | 00000002       |
    Given the following users_teams exist:
      | student_uid    | team_id |
      | 2              | 1       |
      | 3              | 1       |
    Given the following assignments exist:
      | assignment_name | course_id | deadline    | created_at  | updated_at  |
      | Project 1       | 1         | 11-Apr-2015 | 04-Apr-2015 | 04-Apr-2015 |
      | Project 2       | 1         | 16-Apr-2015 | 13-Apr-2015 | 13-Apr-2015 |
    Given I am signed on with uid: 12345678
    And that today is 15-Apr-2015
    Given I am on view course page for "CS 169"
    And I press "Kevin Dogs"
    
  Scenario: See an option to add a feedback before a deadline
    Then I should see "Add feedback for Project 2"
    Then I should not see "Add feedback for Project 1"
  
  Scenario: Add a new feedback
    Given I am on new feedback page for course "CS 169", team "Kevin Dogs", assignment "Project 2"
    When I fill in "comment_own" with "i tried so hard" 
    And I fill in "comment_1" with "pls try harder"
    And I fill in "rating_1" with "15"
    And I press "Submit"
    Then I should be on view team page for course "CS 169", team "Kevin Dogs"
    Then I should see "Succesfully Recorded Feedback for Project 2"
