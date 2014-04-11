Feature: destroy issue
  In order to destroy issue 
  As a creator of an issue
  I should be able to destroy my issue

  Scenario: not logged in 
    Given some data
    And I am not logged in
    When I visit the home page
    Then I should not see "Destroy"
    
#@selenium    
  Scenario: logged in for destroy own issue 
    Given some data
    And I am logged in as "abc@def.com" with password "foobar"
    When I visit the home page
    Then I should have 1 ".delete" selector
    When I click on "Destroy"
    Then I should see "Issue was successfully deleted"
    


  Scenario: logged in for destroy other issue 
    Given some data
    And I am logged in as "def@def.com" with password "foobar"
    When I visit the home page
    Then I should not see "Destroy"



  Scenario: logged in as admin for destroy any issue 
    Given some data
    And I am logged in as "superadmin@mahi.com" with password "foobar"
    When I visit the home page
    Then I should have 2 ".delete" selector
#    Then I should see "Destroy"
    When I click on "Destroy"
    Then I should see "Issue was successfully deleted"


