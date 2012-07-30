Feature: edit issue
  In order to update information or correct any mistake
  As a creator of an issue
  I should be able to update my issue as long as it has no comments

  Scenario: not logged in 
    Given an issue for user "test@test.com" with password "abcdef"
    And I am not logged in
    When I try to edit that issue
    Then I should see "Sign in"
  
  Scenario: logged in and owner
    Given an empty database
    And an issue for user "test@test.com" with password "abcds"
    And I am logged in as "test@test.com" with password "abcds"
    When I try to edit that issue
    Then I should see "Editing issue"


    
    
