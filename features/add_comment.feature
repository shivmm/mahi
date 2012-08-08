Feature: issue page
  In order to add comments on a particular post
  users should be able to comment on a post

  
  Background:
    Given some data
    
  Scenario: not logged in
    Given I am not logged in
    When I view an issue for "abc@def.com"
    And I should see "Please Log in to submit comment"
    And I should not see "Logout"


  Scenario: Logged in user
    Given I am logged in as "abc@def.com" with password "foobar"
    When I view an issue for "abc@def.com"
    Then I should see "Add your Comment"
    When I fill in "comment_body_comments" with "foo foo foo"
    And I fill in "comment_location" with "XYZ"
    And I click on "Add Comment"
    Then I should see "Comment was successfully created"
    And I should see "foo foo foo"
    And I should see "Logout"



  Scenario: Logged in as admin
    Given I am logged in as "superadmin@mahi.com" with password "foobar"
    When I view an issue for "abc@def.com"
    Then I should see "Add your Comment"
    When I fill in "comment_body_comments" with "foo foo foo"
    And I fill in "comment_location" with "XYZ"
    And I click on "Add Comment"
    Then I should see "Comment was successfully created"
    And I should see "foo foo foo"
    And I should see "Logout"

    
