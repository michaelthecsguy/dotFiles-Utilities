require 'pp'

# DO NOT CHANGE THE DEFAULT.
# # You can override the default by setting TEST_ENV on the cmd line.
TEST_ENV = ENV["TEST_ENV"] ||= "qa1"

valid_envs = {
  "qa1" => {
    :base_url => "http://qa-lemur1.np.wc1.yellowpages.com:9798",
  },
  "qa2" => {
    :base_url => "http://qa-lemur2.np.wc1.yellowpages.com:9798",
  },
  "qa3" => {
    :base_url => "http://qa-lemur3.np.wc1.yellowpages.com:9798",
  },
  "staging" => {
    :base_url => "http://stage-lemur.prod.wc1.yellowpages.com:9798",
  },
  "wc1" => {
    :base_url => "http://www.wc1.example.com",
  },
  "ev1" => {
    :base_url => "http://www.ev1.example.com",
  },
  "production" => {
    :base_url => "http://publisher.yp.com",
  },
}

unless valid_envs.key?(TEST_ENV)
  puts "Invalid test environment."
  puts "Try one of these:"
  pp valid_envs
  exit
end

CONFIG = valid_envs[TEST_ENV]

SELENIUM = ENV["SELENIUM"] ||= "localhost"

valid_rc = {
  "localhost" => {
    :url => CONFIG[:base_url],
    :browser => "",
  },
  "ondemand"  => {
    :url => CONFIG[:base_url],
    :browser => "",
  },
  "ypgrid"  => {
    :url => CONFIG[:base_url],
    :browser => "",
  },
}

unless valid_rc.key?(SELENIUM)
  puts "Invalid Selenium RC server."
  puts "Try one of these:"
  pp valid_envs
  exit
end

# SauceLabs auth credentials.
if SELENIUM == "ondemand"
  auth_file = File.join(ENV['HOME'], ".ondemand")
  begin
    ONDEMAND = YAML.load_file(auth_file)
  rescue
    puts "Whoops! Missing Sauce OnDemand auth credentials."
    puts "File not found: #{auth_file}"
    puts
    puts File.new("#{File.dirname(__FILE__)}/ondemand_example.yml").readlines
    puts
    exit 1
  end
end

# Supported browsers.
# http://saucelabs.com/rest/v1/info/browsers
TEST_BROWSERS = YAML.load_file(File.dirname(__FILE__) + "/browsers.yml")

BROWSER = TEST_BROWSERS[3] # temp

Dir[File.join(File.dirname(__FILE__), "..", "lib", "*.rb")].each {|file| require file}

testdata, tmp_hsh = {}, {}
Dir[File.join(File.dirname(__FILE__), "..", "testdata", "*.yml")].each do |f|
  k = File.basename(f, ".yml")
  tmp_hsh[k.to_sym] = YAML.load_file(f)
  testdata = testdata.merge!(tmp_hsh)
end

TESTDATA = testdata

SRP_RESULTS_PER_PAGE = 30

#framework_rev = `git rev-parse HEAD`[0..7]

#begin
#  GIT_COMMIT = (Net::HTTP.get_response URI.parse(CONFIG[:base_url])).
#    body.match(/scm_rev:\ (.*)/)[1][0..7]
#rescue => e
#  puts "Site is down."
#  exit
#end

begin
  test_user = register_user
rescue => e
  puts "Register user failed. Login and registration tests will be skipped."
end
TEST_USER = test_user ||= nil

#puts "Chuckwalla (commit #{framework_rev})"
puts Time.now.strftime("%c")
puts "Target: #{TEST_ENV}" #"(commit #{GIT_COMMIT})"
puts CONFIG[:base_url]
puts "Selenium: #{SELENIUM}, #{BROWSER['long_name']} #{BROWSER['short_version']}"
