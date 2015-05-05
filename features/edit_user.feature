Feature: Edit account as a student, instructor, or professor
  As a member of Berkeley,
  So that I can correctly view correction information about self,
  I want to be edit my account

Scenario: Change my name as a student
	Given I am on the sign up page
	When I fill in "user[first_name]" with "Phil"
	And I fill in "user[last_name]" with "Kwon"
	And I fill in "user[user_id]" with "23499325"
	And I select "I am a student" from "user[role]"
	And I fill in "user[email]" with "testing@gmail.com"
	And I fill in "user[password]" with "test1please"
	And I fill in "user[password_confirmation]" with "test1please"
	And I press "Sign up"
	When I follow "Phil Kwon | Student"
	And I fill in "user[first_name]" with "Changed this"
	And I fill in "user[current_password]" with "test1please"
	And I press "Update"
	Then I should see "Changed this"
	Then I should not see "Phil"
