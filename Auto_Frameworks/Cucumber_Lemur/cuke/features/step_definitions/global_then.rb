Then /^I should see the browser title$/ do
  assert_match(/[Account Management]|[Resource Center]|[Publisher Registration]|[Terms of Use]|[Privacy Policy]/, selenium.title)
end

Then /^I should see "([^"]*)" nav$/ do |element|
  assert(selenium.is_element_present("css=##{element.downcase}Nav"), "Page must have #{element}")
end

Then  /^I should see "([^"]*)" page with the expected url$/ do |page|
  case page.downcase
  when "contact us"
    expected_url = BASE_URL + "/resource_center/resource/support-request"
    assert_match(/#{expected_url}/, selenium.get_location)

  when "help"
    expected_url = BASE_URL + "/resource_center"
    assert_match(/#{expected_url}/, selenium.get_location)

  when "privacy policy"
    expected_url = "https://www.att.com/gen/privacy-policy?pid=2506"
    all_pop_up_names=selenium.get_all_window_names()
   
    all_pop_up_names.each_index do |i|
      unless (all_pop_up_names[i] =~/\D*\d+/).nil?
        selenium.select_window("name=#{all_pop_up_names[i]}")        
      end
    end

    selenium.window_focus()
    selenium.wait_for_element("css= .logo")
    assert_equal(expected_url, selenium.get_location)

  when "terms of use"
    expected_url = "https://www.att.com/gen/general?pid=11561"
    all_pop_up_names=selenium.get_all_window_names()
   
    all_pop_up_names.each_index do |i|
      unless (all_pop_up_names[i] =~/\D*\d+/).nil?
        selenium.select_window("name=#{all_pop_up_names[i]}")        
      end
    end

    selenium.window_focus()
    selenium.wait_for_element("css= .logo")
    assert_equal(expected_url, selenium.get_location)

  when "register"
    expected_url = BASE_URL + "/registration"
    assert_match(/#{expected_url}/, selenium.get_location)

  when "sign in"
    expected_url = BASE_URL + "/#"
    assert_match(/#{expected_url}/, selenium.get_location)

  else
   pp "***AUTOMATION*** Need the expected url for the #{page} page!!!"
   pp "the current URL is #{selenium.get_location}" 
  end 
end
