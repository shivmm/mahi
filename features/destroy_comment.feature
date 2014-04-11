Feature: destroy comment
  In order to destroy comment
  As a creator of an comment
  I should be able to destroy my comment
  

  Background:
    Given some data


  Scenario: not logged in 
    Given I am not logged in
    When I view an issue for "abc@def.com" 
    Then I should not see "Destroy Comment"

  Scenario: logged in for destroy own comment
    Given some data
    And a comment on an issue for user "abc@def.com"
    When I am logged in as "abc@def.com" with password "foobar"
    When I view an issue for "abc@def.com"
    Then I should see "Destroy Comment"
    When I click on "Destroy Comment"
    Then I should see "Comment was successfully deleted."

    
  Scenario: logged in for destroy other comment
    Given some data
    And a comment on an issue for user "other@mahi.com"
    When I am logged in as "abc@def.com" with password "foobar"
    When I view an issue for "abc@def.com"
    Then I should not see "Destroy Comment"


  Scenario: logged in as admin to destroy any comment
    Given I am logged in as "superadmin@mahi.com" with password "foobar"
    And a comment on an issue for user "abc@def.com"
    When I view an issue for "abc@def.com"
    Then I should see "Destroy Comment"
    When I click on "Destroy Comment"
    Then I should see "Comment was successfully deleted."

