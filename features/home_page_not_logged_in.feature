Feature: home page
  In order to engage the user
  users should be able to see most popular issues
  
  Scenario: not logged in
    Given there are no issues
    And I add 2 issues with 1 comments and title "Least Popular 1, Least Popular 2"
    And I add 1 issues with 2 comments and title "More Popular"
    And I add 1 issues with 3 comments and title "Most Popular"
    When i visit the home page
    Then i should see the following issues:
      | issue name      |
      | Most Popular    |
      | More Popular    |
      | Least Popular 2 |
      | Least Popular 1 |
	 
