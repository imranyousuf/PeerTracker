Feature: Add a new course
	As a professor
	So that I can keep track of the course I am teaching
	I want to be able to create a new course

Background:
	Given the following users exist:
	| first_name    | last_name       | user_id          | email            | password | created_at  | updated_at  |
	| Armando       | Fox             | 00000001         | kev@berkeley.edu | password | 30-Nov-2014 | 30-Nov-2014 |
	Given the following roles exist:
     | name          | 
     | professor     |
    Given the following users_roles exist:
      | user_id  | role_id |
      | 00000001 | 1       |

Scenario: create a new course
	Given I am signed on with uid: 00000001
	And I follow "New Course"
	When I fill in "course[course_name]" with "CS 170"
	And I press "Create Course"
	Then I should see "Successfully added course CS 170"

Scenario: try to create a course with existing name
	Given I am signed on with uid: 00000001
	And I follow "New Course"
	When I fill in "course[course_name]" with "CS 170"
	And I press "Create Course"
	And I am on the home page
	And I follow "New Course"
	When I fill in "course[course_name]" with "CS 170"
	And I press "Create Course"
	Then I should see "Course name exists"

Scenario: Edit/Destroy an existing course
	Given I am signed on with uid: 00000001
	And I follow "New Course"
	When I fill in "course[course_name]" with "CS 170"
	And I press "Create Course"
	And I am on the home page
	And I follow "New Course"
	When I fill in "course[course_name]" with "CS 170"
	And I press "Create Course"
	Then I should see "Course name exists"
	And I am on the home page
	And I follow "Delete"
	Then I should see "Course was successfully removed."


