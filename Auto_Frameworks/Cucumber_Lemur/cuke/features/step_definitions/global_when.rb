When /^I wait "([^"]+)" seconds$/ do |i|
  sleep i.to_i
end

When /^I click on the link "([^"]*)"$/ do |link|
  selenium.click "css=a:contains('#{link}')"
end

When /^I click on the publisher branding logo$/ do
  selenium.wait_for_element("css=#headerTitle")
  selenium.click("css=#headerTitle a")
  selenium.wait_for_element("css=#headerNav")
end

When /^I get the publisher settings from the Hazel DB$/ do
  @publisher_configs = HAZEL_DB.new.get_publisher_configs($DEFAULTS['publishers'][@publisher]['PUBLISHER_ID'])
end

When /^I get the property settings from the Hazel DB$/ do
  @publisher_configs = HAZEL_DB.new.get_property_configs($DEFAULTS['properties'][@property]['PROPERTY_ID'])
end

When /^I get the implementation settings from the Hazel DB$/ do
  @publisher_configs = HAZEL_DB.new.get_implementation_configs($DEFAULTS['implementations'][@name]['IMPLEMENTATION_ID'])
end
