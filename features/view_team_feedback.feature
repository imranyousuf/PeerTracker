Feature: view all feedback for team
 
  As a Teacher
  So that I can better understand how the team interacts
  I want to view all the feedback all members in a team has received

Background: Given I have a team with feedback
  Given I am logged in as a Teacher
  Given the following students exist:
  | name          | team        | teacher         | course
  | Aladdin       | Brown       | Lion King       | Math
  | Monkey        | Brown       | Lion King       | Math

  Given the following feedbacks exist:
  | writer        | recipient   | rating          | content
  | Aladdin       | Aladdin     | 30              | "I'm the best"
  | Aladdin       | Monkey      | 5               | "Not a human"
  | Monkey        | Monkey      | 40              | "I'm best monkey"
  | Monkey        | Aladdin     | 10              | "ugly human"

Scenario: view feedback for one team
  Given I click on "All Teams"
  And I follow "Brown"
  I should see "I'm the best"
  I should see "Not a human"
  I should see "I'm best monkey"
  I should see "ugly human"
