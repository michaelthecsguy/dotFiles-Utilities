@authentication @negative
Feature: Verify that authenticating with invalid credentials displays the correct behavior.

@blank_password
Scenario: Blank Password
	Given I am on the home page
	When I fill in "Username" with "chansanuwat@attinteractive.com"
	And I press "Go"
	Then I should see "Your username or password are incorrect. Please try again."

@invalid_password	
Scenario: Invalid Password
	Given I am on the home page
	When I fill in "Username" with "chansanuwat@attinteractive.com"
	And I fill in "Password" with "aaaaaaaa"
	And I press "Go"
	Then I should see "Your username or password are incorrect. Please try again."

@blank_username	
Scenario: Blank Username
	Given I am on the home page
	And I fill in "Password" with "password"
	And I press "Go"
	Then I should see "Your username or password are incorrect. Please try again."
	
@invalid_username
Scenario: Invalid Username
	Given I am on the home page
	When I fill in "Username" with "aaaaaaaaa@attinteractive.com"
	And I fill in "Password" with "aaaaaaaaaaa"
	And I press "Go"
	Then I should see "Your username or password are incorrect. Please try again."