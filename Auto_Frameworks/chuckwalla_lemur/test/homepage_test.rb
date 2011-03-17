$: << File.dirname(__FILE__)

require 'setup'

class HomepageTest < MiniTest::Unit::TestCase
  include MinitestCommon
  include ChuckwallaHelpers

  def test_homepage_must_have_title
    start_browser
    assert_match(/[Account Management|AT\&T Interactive]/, @browser.title)
  end

  def test_homepage_must_have_header
    start_browser
    assert(@browser.is_element_present("css=#headerNav"),
           "Homepage must have global header ")
  end

  def test_homepage_must_have_branding_placeholder
    start_browser
    # TODO: Why is this in a conditional block?
    if @browser.is_element_present("css=#headerTitle")
      @browser.click("css=#headerTitle a")
      @browser.wait_for_element("css=#headerNav")
      assert_match(/[Account Management] - AT&T Interactive/,
                   @browser.title)
    else
      assert_block("Branding Placeholder has been modified or dismissed in Homepage")
    end
  end

  def test_homepage_must_have_content
    start_browser
    assert(@browser.is_element_present("css=#body"),
           "Homepage must have content")
    assert(@browser.is_visible("link=Home"),
           "Homepage must have Home tab")
    assert(@browser.is_visible("link=Resource Center"),
           "Homepage must have Resource Center tab")
  end

  def test_homepage_must_have_footer
    start_browser
    assert(@browser.is_element_present("css=#footerNav"),
           "Homepage must have global footer")
  end
end
