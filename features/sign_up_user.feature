Feature: Sign up as a student, instructor, or professor
  As a member of Berkeley,
  So that I can use the app PeerTracker
  I want to be able to sign up

Scenario: Sign up as student 
	Given I am on the sign up page
	When I fill in "user[first_name]" with "Phil"
	And I fill in "user[last_name]" with "Kwon"
	And I fill in "user[user_id]" with "23499325"
	And I select "I am a student" from "user[role]"
	And I fill in "user[email]" with "testing@gmail.com"
	And I fill in "user[password]" with "test1please"
	And I fill in "user[password_confirmation]" with "test1please"
	And I press "Sign up"
	Then I should see "Student Account"

Scenario: Fail Sign up as student
	Given the following users exist:
	| first_name    | last_name       | user_id          | email            | password | created_at  | updated_at  |
	| Masta         | Ruiqi          | 12345678         | rw@carry.com     | password | 25-Nov-1992 | 25-Nov-1992 |
	Given I am on the sign up page
	When I fill in "user[first_name]" with "Phil"
	And I fill in "user[last_name]" with "Kwon"
	And I fill in "user[user_id]" with "12345678"
	And I select "I am a student" from "user[role]"
	And I fill in "user[email]" with "testing@gmail.com"
	And I fill in "user[password]" with "test1please"
	And I fill in "user[password_confirmation]" with "test1please"
	And I press "Sign up"
	Then I should see "Login"
	Then I should see "An account with this Student ID/Employee ID already exists!"

Scenario: Sign up as instructor 
	Given I am on the sign up page
	When I fill in "user[first_name]" with "Instructor"
	And I fill in "user[last_name]" with "Kwon"
	And I fill in "user[user_id]" with "234993251"
	And I select "I am an instructor" from "user[role]"
	And I fill in "user[email]" with "testing1@gmail.com"
	And I fill in "user[password]" with "test1please"
	And I fill in "user[password_confirmation]" with "test1please"
	And I press "Sign up"
	Then I should see "Instructor Account"

