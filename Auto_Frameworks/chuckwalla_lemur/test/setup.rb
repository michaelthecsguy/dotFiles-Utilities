$: << File.join(File.dirname(__FILE__), '..', 'support')

require 'minitest/autorun'
require 'selenium/client'
require 'nokogiri'
require 'yaml'
require 'json'
require 'faker'

require 'config'
require 'minitest_common'
require 'chuckwalla_helpers'

begin
  require 'ap'
rescue LoadError
  # not installed
end
