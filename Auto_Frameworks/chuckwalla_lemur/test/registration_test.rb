$: << File.dirname(__FILE__)

require 'setup'

class RegistrationTest < MiniTest::Unit::TestCase
  include MinitestCommon
  include ChuckwallaHelpers

  def test_must_have_a_registration_link
    start_browser
    assert_match(/Register/, @browser.get_text("css=a.track-sign-up"))
  end

  def test_must_have_a_registration_lightbox
    skip("TODO: Fix test. Failing b/c of SSL.")
    start_browser
    assert(@browser.is_element_present("css=a.track-sign-up"),
           "Page must have Sign Up link")

    close_lightbox = ["fancybox-close", "css=a:contains('Cancel')"]

    @browser.click("css=a.track-sign-up")
    @browser.wait_for_element "css=div.auth_container"
    # TODO: Why are we clicking a random selector?
    @browser.click "#{close_lightbox[rand(close_lightbox.length)]}"
  end
end
