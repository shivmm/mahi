Feature: new issue
  In order to report an issue
  As a user
  I should be able to create new issue
  

  Scenario: not logged in
    Given I am not logged in
    When I visit the new issue page
    Then I should see "Sign in"
    

  Scenario: logged in
    Given a logged in user
    When I visit the new issue page
    And I fill in "issue_title" with "issue1" 
    And I fill in "issue_issue_content" with "testing"
    And I click on "Create Issue"
    Then I should see "Issue was successfully created"

