$: << File.dirname(__FILE__)

require 'setup'

class LoginTest < MiniTest::Unit::TestCase
  include MinitestCommon
  include ChuckwallaHelpers

  def test_login_must_have_a_link
  # Homepage must have a login link
    start_browser
    assert_match(/Sign In/, @browser.get_text("css=div#headerNav"))
  end

  def test_simple_login
    start_browser
  # assert_match 
  end

  def test_login_success_to_the_landing_page_1st_time
  # No Sites/apps attached to the publisher account

  end
end
