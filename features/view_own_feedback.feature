Feature: view own feedback as a student

  As a Student
  So that I can better myself as a teammate
  I want to be able to view anonymous, randomized comments addressed to me and to the team

Background: Given I have a student with multiple feedbacks
  Given the following students exist:
  | name          | team        | teacher         | course
  | Aladdin       | Brown       | Lion King       | Math
  | Monkey        | Brown       | Lion King       | Math
  | Jasmine       | Brown       | Lion King       | Math
  Given the following feedbacks for individuals exist:
  | writer        | recipient   | rating          | content
  | Aladdin       | Jasmine     | 30              | "OH so pretty"
  | Monkey        | Jasmine     | 2               | "OH so ugly"
  Given the following feedbacks for teams exist:
  | writer        | recipient   | rating          | content
  | Aladdin       | Brown       | 0               | "this group sucks"
  Given I am logged in as "Jasmine"


Scenario: Student can view teammate's feedback
    Given I click on "My Feedbacks"
    I should see "OH so pretty"
    I should see "OH so ugly"

Scenario: Student can view teamm's feedback
    Given I click on "My Team's Feedbacks"
    I should see "this group sucks"


