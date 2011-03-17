Given /^I am on the home page$/ do
  visit '/'
  sleep 1
end

Given /^I am on the homepage$/ do
  visit '/'
  sleep 1
end

Given /^I am logged in as "([^"]+)"$/ do |user|
  visit '/'
  When %{I fill in "Username" with "#{Users['lemuruser']['username']}"}
  When %{I fill in "Password" with "#{Users['lemuruser']['password']}"}
  When %{I press "Go"}
  sleep 1
end

Given /^I establish a timestamp$/ do
  @timestamp = Time.now.strftime("%Y%m%d%H%M%S")
end
