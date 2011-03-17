require 'rubygems'
require 'net/http'
require 'json/pure'
require 'webrat'
require 'webrat/selenium'
require 'test/unit/assertions'
require 'dbi'

include Webrat::Methods
include Webrat::Selenium::Methods
include Webrat::Selenium::Matchers

# TestLink Data
# REPORTING = true
ENV['report'] == 'true' ? REPORTING = true : REPORTING = false
TestProject = 'Lemur'
TestPlan = ENV['testplan'] || 'Regression'
TestBuild = ENV['build'] || 'CI Regression'

FE_HOST = ENV['astro_host'] || 'qa-adsvc-fe1.np.wc1.yellowpages.com:8888'
#PW = ENV['hook']
#if PW.nil? then
#  puts 'Sorry, you must enter the password!'
#  exit
#end

# Loading config files
config_root_dir = "#{File.dirname(__FILE__)}/../../config/" 
Elements = YAML::load(File.read(config_root_dir + "elements.yaml"))
Users = YAML::load(File.read(config_root_dir + "users.yaml"))
SeleniumConfig =  YAML::load(File.read(config_root_dir + "selenium_config.yaml"))
$DEFAULTS = YAML::load(File.read(config_root_dir + "defaults.yaml"))

$scenario_counter = 0

#Set it up to overwrite Webrat
BROWSER = ENV['browser'] || 'local'
TARGET = ENV['target'] || 'qa1'
BROWSERCONFIGS = SeleniumConfig[:browsers][BROWSER.to_sym]
TARGETCONFIGS = SeleniumConfig[:targets][TARGET.to_sym]

#for Code Use
BASE_URL = TARGETCONFIGS[:application_address] + ":" + TARGETCONFIGS[:application_port].to_s

Webrat.configure do |config|
  config.mode = BROWSERCONFIGS[:mode].to_sym if BROWSERCONFIGS[:mode]
  config.selenium_server_address = BROWSERCONFIGS[:selenium_server_address] if BROWSERCONFIGS[:selenium_server_address]
  config.selenium_server_port = BROWSERCONFIGS[:selenium_server_port].to_s if BROWSERCONFIGS[:selenium_server_port]
  config.selenium_browser_key = BROWSERCONFIGS[:selenium_browser_key] if BROWSERCONFIGS[:selenium_browser_key]
  config.application_framework = TARGETCONFIGS[:application_framework].to_sym if TARGETCONFIGS[:application_framework]
  config.application_address = TARGETCONFIGS[:application_address] if TARGETCONFIGS[:application_address]
  config.application_port = TARGETCONFIGS[:application_port].to_s if TARGETCONFIGS[:application_port]
  config.selenium_browser_startup_timeout = BROWSERCONFIGS[:selenium_browser_startup_timeout] if BROWSERCONFIGS[:selenium_browser_startup_timeout]
end

World(Test::Unit::Assertions)
