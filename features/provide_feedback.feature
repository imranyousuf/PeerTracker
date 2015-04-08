Feature: provide feedback for teammates
  As a Student
  So that I can provide feedback about my teammates
  I want to provide a numerical score and written comments about my team

Background:
  Given the following students exist:
  | name          | team        | teacher         | course
  | Aladdin       | Brown       | Lion King       | Math
  | Monkey        | Brown       | Lion King       | Math
  | Jasmine       | Brown       | Lion King       | Math
  Given I am logged in as "Jasmine"

Scenario: give feedback for one student
  Given I click on "Give Feedback"
  And I click on "Aladdin"
  And I fill in "rating" with "30"
  And I fill in "content" with "did not participate"
  And I click on "Submit"
  Then I click on "Submitted Feedbacks"
  And I clikc on "Aladdin"
  Then I should see "30"
  Then I should see "did not participate"
