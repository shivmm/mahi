Feature: issue page
  In order to view a particular post
  users should be able to see complete post detail along with comments
  
  Background:
    Given some data
    
  Scenario: not logged in
    Given I am not logged in
    When I view an issue for "abc@def.com"
    Then I should see "Issue Title"
    And I should see "Issue Content"
    And I should see "Created Date"
    And I should see "Comments"
    And I should not see "Add Comment"    

