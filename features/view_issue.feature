Feature: issue page
  In order to view a particular post
  users should be able to see complete post detail along with comments
  
  Background:
    Given some data
    
  Scenario: not logged in
    Given I am not logged in
    When I view an issue for "abc@def.com"
    Then I should see "Posted by"
    And I should see "Date"
    And I should see "Comments"
    And I should see "Total comments on this post"
    And I should see "Please Log in to submit comment"
    And I should not see "Logout"

    


  Scenario: logged in user
    Given I am logged in as "abc@def.com" with password "foobar"
    When I view an issue for "abc@def.com"
    Then I should see "Posted by"
    And I should see "Date"
    And I should see "Comments"
    And I should see "Total comments on this post"
    And I should see "Add your Comment"
    And I should see "Logout"




  Scenario: logged in as admin
    Given I am logged in as "superadmin@mahi.com" with password "foobar"
    When I view an issue for "abc@def.com"
    Then I should see "Posted by"
    And I should see "Date"
    And I should see "Comments"
    And I should see "Total comments on this post"
    And I should see "Add your Comment"
    And I should see "Logout"






