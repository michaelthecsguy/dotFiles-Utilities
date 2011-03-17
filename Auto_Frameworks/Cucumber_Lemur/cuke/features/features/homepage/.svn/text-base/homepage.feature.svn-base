@homepage
Feature: Publisher Portal Homepage Validation

@homepage_browser_title_before_login
Scenario: Homepage must have the browser title
  Given I am on the home page
  Then I should see the browser title

@homepage_header_before_login
Scenario: Homepage must have the header at the top of the page
  Given I am on the homepage
  When I wait "3" seconds
  Then I should see "header" nav

@homepage_branding_placeholder
Scenario: Homepage must have branding placeholder
  Given I am on the homepage
  When I click on the publisher branding logo
  Then I should see the browser title

@homepage_content_links_before_login
Scenario: Homepage must have content links
  Given I am on the homepage
  When I wait "3" seconds
  Then I should see "Home"
  And I should see "Resource Center"

@homepage_footer_before_login
Scenario: Homepage must have the footer at the bottom of the page
  Given I am on the homepage
  When I wait "3" seconds
  Then I should see "footer" nav
