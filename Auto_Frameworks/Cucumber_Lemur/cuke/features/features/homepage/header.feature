@homepage_header
Feature: Publisher Portal Homepage Header Validation

@homepage_header_links_before_login
Scenario: Before Login, verify header links
  Given I am on the homepage
  Then I should see "Help"
  And I should see "Register"
  And I should see "Sign In"

@homepage_header_help
Scenario: Homepage must have Help link active 
  Given I am on the homepage
  When I click on the link "Help"
  Then I should see the browser title
  And I should see "Help" page with the expected url

@homepage_header_register
Scenario: Homepage must have Register link active
  Given I am on the homepage
  When I click on the link "Register"
  Then I should see the browser title
  And I should see "Register" page with the expected url
    
@homepage_header_sign_in
Scenario: Homepage must have Sign In active
  Given I am on the homepage
  When I click on the link "Sign In"
  Then I should see "Sign In" page with the expected url
  And I should see the browser title
