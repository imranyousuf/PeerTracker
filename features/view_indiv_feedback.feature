Feature: view feedback for individual student
 
  As a Teacher
  So that I can evaluate a student’s contributions
  I want to view all the feedback for an individual student

Background: Given I have a student with multiple feedbacks
  Given I am logged in as a Teacher
  Given the following students exist:
  | name          | team        | teacher         | course |
  | Aladdin       | Brown       | Lion King       | Math   |
  | Monkey        | Brown       | Lion King       | Math   |
  | Jasmine       | Brown       | Lion King       | Math   |
  Given the following feedbacks exist:
  | writer        | recipient   | rating          | content        |
  | Aladdin       | Jasmine     | 30              | "OH so pretty" |
  | Monkey        | Jasmine     | 2               | "OH so ugly"   |

Scenario: view feedback for one student
  Given I click on "All Students"
  And I follow "Jasmine"
  Then I should see "OH so pretty"
  And I should see "OH so ugly"
