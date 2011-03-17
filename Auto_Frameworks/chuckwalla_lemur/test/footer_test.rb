$: << File.dirname(__FILE__)

require 'setup'

class FooterTest < MiniTest::Unit::TestCase
  include MinitestCommon
  include ChuckwallaHelpers

  def test_contact_us
  # To validate the link is still active for publishers to ask questions or make deals with us
    start_browser
    @browser.click("link=Contact Us")
    @browser.wait_for_page
    expected_url = CONFIG[:base_url] + "/resource_center/resource/support-request"
    assert_match(expected_url, @browser.get_location)
    assert_match(/Resource Center/, @browser.title)
  end

  def test_help
    start_browser
    @browser.click("link=Help")
    @browser.wait_for_page
    expected_url = CONFIG[:base_url] + "/resource_center"
    assert_match(expected_url, @browser.get_location)
    assert_match(/Resource Center/, @browser.title)
  end

  def test_terms_of_use
    all_pop_up_names= Array.new
    
    start_browser
    @browser.click("link=Terms of Use")
    expected_url = "https://www.att.com/gen/general?pid=11561"
    all_pop_up_names=@browser.get_all_window_names()
   
    all_pop_up_names.each_index do |i|
      unless (all_pop_up_names[i] =~/\D*\d+/).nil?
        @browser.select_window("name=#{all_pop_up_names[i]}")        
      end
    end

    @browser.window_focus()
    @browser.wait_for_element("css= .logo")
    assert_equal(expected_url, @browser.get_location)
    assert_match(/AT\&T Terms of Use/, @browser.title)
  end

  def test_privacy_policy
    all_pop_up_names= Array.new
    
    start_browser
    @browser.click("link=Privacy Policy")
    expected_url="https://www.att.com/gen/privacy-policy?pid=2506"
    all_pop_up_names=@browser.get_all_window_names()

    all_pop_up_names.each_index do |i|
      unless (all_pop_up_names[i] =~/\D*\d+/).nil?
        @browser.select_window("name=#{all_pop_up_names[i]}")        
      end
    end

    @browser.window_focus()
    @browser.wait_for_element("css= .logo")
    assert_equal(expected_url, @browser.get_location)
    assert_match(/AT\&T Privacy Policy/, @browser.title)
  end
end
