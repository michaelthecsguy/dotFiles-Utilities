@add_site @add_site_existing
Feature: Verify the proper functionality when adding a site for a user that already has a site saved

@wip
Scenario: Successful Site Add For Existing
	Given I am logged in as "chansanuwat"
	And I establish a timestamp
	When I click the button "Add a Site/App"
	And I fill in "Your Site/App Name" with "adsvcqa***TIMESTAMP***"
	And I check "WebOS"
	And I fill in "Site/App URL" with "www.yp.com"
	And I fill in "Content Tags" with "adsvcqa,automation"
	And I select "Sports" from "Category"
	And I press "Save & Continue"
	And I get the implementation settings from the Hazel DB
	Then I should see "Sites & Apps"
	And I should see "adsvcqa***TIMESTAMP***"