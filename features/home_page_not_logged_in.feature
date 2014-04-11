Feature: home page
  In order to engage the user
  users should be able to see most popular issues

  Background:
    Given some data


  Scenario: not logged in
    Given there are no issues
    And I add 2 issues with 1 comments and title "Least Popular 1, Least Popular 2"
    And I add 1 issues with 2 comments and title "More Popular"
    And I add 1 issues with 3 comments and title "Most Popular"
    When I visit the home page  
    Then I should see the following issues:
      | issue name      |
      | Most Popular    |
      | More Popular    |
      | Least Popular 2 |
      | Least Popular 1 |
    And I should not see "Destroy"
    But I should see "Show"
	 

 

  Scenario: logged in User on Home Page
    Given there are no issues
    And I am logged in as "abc@def.com" with password "foobar"
    And I add 2 issues with 1 comments and title "Least Popular 1, Least Popular 2"
    And I add 1 issues with 2 comments and title "More Popular"
    And I add 1 issues with 3 comments and title "Most Popular"
    When I visit the home page
    Then I should see the following issues:
      | issue name      |
      | Most Popular    |
      | More Popular    |
      | Least Popular 2 |
      | Least Popular 1 |
    And I should see "Show"




  Scenario: logged in as admin on Home Page
    Given there are no issues
    And logged in as admin
    And I add 2 issues with 1 comments and title "Least Popular 1, Least Popular 2"
    And I add 1 issues with 2 comments and title "More Popular"
    And I add 1 issues with 3 comments and title "Most Popular"
    When I visit the home page
    Then I should see the following issues:
      | issue name      |
      | Most Popular    |
      | More Popular    |
      | Least Popular 2 |
      | Least Popular 1 |
    And I should see "Show"

