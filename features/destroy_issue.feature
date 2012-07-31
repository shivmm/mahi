Feature: destroy issue
  In order to destroy issue 
  As a creator of an issue
  I should be able to destroy my issue


  Background:
    Given some data
    

  Scenario: not logged in 
    Given I am not logged in
    When I should see "Destroy"
    And I click on "Destroy"
    Then I should see "sorry you are not authorised to do this operation without login"
    And I should see "Sign in"
    


