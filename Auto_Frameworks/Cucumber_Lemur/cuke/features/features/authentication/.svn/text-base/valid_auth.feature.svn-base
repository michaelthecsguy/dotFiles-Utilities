@authentication @positive
Feature: Verify that authenticating with valid credential displays

@generic_login_success
Scenario: Regular Login
  Given I am on the home page
  And I am logged in as "lemuruser@gmail.com"
  Then I should see "Welcome"
  And I should see "Help"
  And I should see "Feedback"
  And I should see "Sign Out"
  And I should see "Sites & Apps"
  And I should see "Account Info"
  And I should see "Resource Center"
  And I click on the link "Sign Out"

@initial_login_screen
Scenario: login success with no list of sites and apps
  Given I am on the home page
  When I am logged in as "lemuruser@gmail.com"
  Then I click on the link "Sign Out"
