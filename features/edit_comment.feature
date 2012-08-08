Feature: issue page
  In order to correct mistakes in Post comment
  users should be able to update comment on a post


  Background:
    Given some data

  Scenario: not logged in
    Given I am not logged in
    When I view an issue for "abc@def.com"
    And I should not see "Edit Comment"

#@selenium
  Scenario: Logged in user and edit own comment
    Given I am logged in as "abc@def.com" with password "foobar"
    And a comment on an issue for user "abc@def.com" 
    When I view an issue for "abc@def.com"
    Then I should see "Edit Comment"
    When I click on "Edit Comment"
    Then I should see "Editing comment"
    And I should have 1 ".save" selector
    When I fill in "comment_body_comments" with "testing 123"
    And  I fill in "comment_location" with "abc"
    And I click on "Save"
    Then I should see "Comment was successfully updated."



  Scenario: Logged in user and edit other comment
    Given I am logged in as "abc@def.com" with password "foobar"
    And a comment on an issue for user "other@mahi.com"
    When I view an issue for "abc@def.com"
    Then I should not see "Edit Comment"
  


    

  Scenario: Logged in as admin
    Given I am logged in as "superadmin@mahi.com" with password "foobar"
    And a comment on an issue for user "abc@def.com"
    When I view an issue for "abc@def.com"
    Then I should see "Edit Comment"
    When I click on "Edit Comment"
    Then I should see "Editing comment"
    And I should have 1 ".save" selector
    When I fill in "comment_body_comments" with "testing 123"
    And  I fill in "comment_location" with "abc"
    And I click on "Save"
    Then I should see "Comment was successfully updated."



  
 

  




