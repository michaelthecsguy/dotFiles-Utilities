@homepage_footer
Feature: Publisher Portal Homepage Footer Validation

@homepage_footer_links_before_login
Scenario: Before Login, verify footer links
  Given I am on the homepage
  Then I should see "Privacy Policy"
  And I should see "Terms of Use"
  And I should see "Help"
  And I should see "Contact Us"

@homepage_footer_contact_us
Scenario: Homepage must have Contact Us link active 
  Given I am on the homepage
  When I click on the link "Contact Us"
  Then I should see the browser title
  And I should see "Contact Us" page with the expected url

@homepage_footer_help
Scenario: Homepage must have Help link active
  Given I am on the homepage
  When I click on the link "Help"
  Then I should see the browser title
  And I should see "Help" page with the expected url
    
@homepage_footer_privacy_policy
Scenario: Homepage must have Privacy Policy active
  Given I am on the homepage
  When I click on the link "Privacy Policy"
  Then I should see "Privacy Policy" page with the expected url
  And I should see the browser title

@homepage_footer_terms
Scenario: Homepage must have Terms of Use active
  Given I am on the homepage
  When I click on the link "Terms of Use"
  Then I should see "Terms of Use" page with the expected url
  And I should see the browser title

