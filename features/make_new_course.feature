Feature: make new course
	As a Teacher
	I want to make a new course
	So that multiple courses can use peertracker at the same time

Background:
	Given the following admins exist:
		| name          |
		| Armando Fox   |
	Given I am logged in as "Armando"

Scenario: create a new course
	Given I am on the "Dashboard"
	And I press "Create New Course"
	Then I should be on Create New Course
	When I fill in "Course Name" with "CS169"
	And I press "Create Course"
	Then I should be on Dashboard
	And I should see "New Course CS169 Created"
