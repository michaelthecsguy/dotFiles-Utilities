$: << File.dirname(__FILE__)

require 'setup'

class FooterTest < MiniTest::Unit::TestCase
  include MinitestCommon
  include ChuckwallaHelpers

  def test_help
    start_browser
    @browser.click("link=Help")
    @browser.wait_for_page
    expected_url = CONFIG[:base_url] + "/resource_center"
    assert_match(expected_url, @browser.get_location)
    assert_match(/Resource Center/, @browser.title)
  end

  def test_register
  # To validate the link is still active for publishers to register
    start_browser
    @browser.click("link=Register")
    @browser.wait_for_page
    expected_url = CONFIG[:base_url] + "/registration"
    assert_match(expected_url, @browser.get_location)
    assert_match(/Publisher Registration/, @browser.title)
  end

  def test_sign_in
  # To validate the link is still active for publisher to log in to the account  
    start_browser
    @browser.click("link=Sign In")
    expected_url = CONFIG[:base_url] + "/#"
    assert_match(expected_url, @browser.get_location)
    assert_match(/Account Management/, @browser.title)
  end
 end
