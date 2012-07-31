Feature: edit issue
  In order to update information or correct any mistake
  As a creator of an issue
  I should be able to update my issue as long as it has no comments

  Background:
    Given an empty database
    And a user with email "abc@def.com" and password "foobar"
    And an issue for user "abc@def.com"

  Scenario: not logged in 
    Given I am not logged in
    When I try to edit an issue for "abc@def.com"
    Then I should see "Sign in"

  Scenario: logged in and owner
    Given I am logged in as "abc@def.com" with password "foobar"
    When I try to edit an issue for "abc@def.com"
    Then I should see "Editing issue"
    When I fill in "issue_title" with "foo foo foo"
    And I click on "Update Issue"
    Then I should see "Issue was successfully updated"
    And I should see "foo foo foo"

  Scenario: logged in and not owner
    Given I am logged in as "abc@def.com" with password "foobar"
    When I try to edit an issue for "other@mahi.com"
    Then I should see "sorry you are not authorised to edit this issue"

    
    
