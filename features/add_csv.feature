Feature: add/remove students to teams with csv upload
  As an instructor,
  I want to add/remove students to the teams from a csv file
  So that I can easily upload large numbers of students

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

  Scenario: Upload a csv file with students
    Given I am signed on with uid: 00000002
    And I am on create new team page for course "CS 169"
    When I upload the file "test_upload.csv"
    Then I should see "Dogs Who Code"
    Then I should see "Masta Ruiqi"
    Then I should see "Masta Phyllis"
  







