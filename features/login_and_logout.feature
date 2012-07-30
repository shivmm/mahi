Feature: login
  As a user with an existing email and password
  In order to create or manage Issues and comments 
  I should be able to login

  Scenario: not logged in
    Given a user with email "test@test.com" and password "test"
    And I am not logged in
    When I visit the login page
    And I fill in "user_email" with "test@test.com"
    And I fill in "user_password" with "test"
    And I click on "Sign in"
    Then I should see "Signed in successfully"
    
  
  Scenario: Logged In
    Given a logged in user
    When I visit any page
    And I click on "Logout"
    Then I should see "Signed out successfully" 
  
