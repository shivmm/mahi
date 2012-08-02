Feature: destroy issue
  In order to destroy issue 
  As a creator of an issue
  I should be able to destroy my issue


  Background:
    Given some data
    

  Scenario: not logged in 
    Given I am not logged in
    When I visit the home page
    Then I should not see "Destroy"
    And I should see "Show"
    
    


