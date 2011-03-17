$: << "."
require 'pp'

begin
  require 'minitest/unit'
  include MiniTest::Assertions
rescue LoadError => e
  pp e
end

# Identify duplicate array elements.
module Enumerable
  def dups
    inject({}) {|h,v| h[v]=h[v].to_i+1; h}.reject{|k,v| v==1}.keys
  end
end

# Identify duplicate ids in page.
def dupids(u=nil)
  default = "http://qa-webyp.v.wc1.atti.com"
  url = case u
    when /^(http|https):/
      u
    when /\w+/ # path
      [default, u.sub(/^\//, '')].join('/')
    else
      default
  end
  puts url
  res = Net::HTTP.get_response URI.parse(url)
  ap res.body.scan(/\ id=\"(.+?)"/).flatten.dups
end

# tab completion, cross-session history, history file
# http://snippets.dzone.com/posts/show/2586
require 'irb/completion'
ARGV.concat [ "--readline", "--prompt-mode", "simple" ]

module Readline
  module History
    LOG = "#{ENV['HOME']}/.irb-history"

    def self.write_log(line)
      File.open(LOG, 'ab') {|f| f << "#{line}\n"}
    end

    def self.start_session_log
      write_log("\n# session start: #{Time.now}\n\n")
      at_exit { write_log("\n# session stop: #{Time.now}\n") }
    end
  end

  alias :old_readline :readline
  def readline(*args)
    ln = old_readline(*args)
    begin
      History.write_log(ln)
    rescue
    end
    ln
  end
end

Readline::History.start_session_log

require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"

IRB.conf[:PROMPT_MODE] = :SIMPLE

# awesome print
begin
  require 'ap'
rescue LoadError => e
  pp e
end

# selenium
begin
  require 'selenium/client'
  @browser = Selenium::Client::Driver.new \
    :host => 'localhost',
    :port => 4444,
    :browser => '*firefox',
    :url => 'http://qa-webyp.v.wc1.atti.com/',
    :timeout_in_second => 60
rescue LoadError => e
  pp e
end

if defined? Selenium
  def start_browser
    @browser.start_new_browser_session
    @browser.open "/"
  end

  def close_browser
    begin
      @browser.close_current_browser_session
    rescue
    end
  end
  at_exit { close_browser }

  def search_for(terms, location)
    @search = {
      :terms    => terms,
      :location => location,
    }
    @browser.type "search-terms", terms
    @browser.type "search-location", location
    @browser.click "search-submit"
    @browser.wait_for_page
  end
end

USER_AGENT = {
  :firefox =>
    'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.8) Gecko/20100721  Firefox/3.6.8',
  :ie8 =>
    'Mozilla/5.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; SLCC1; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; .NET CLR 1.1.4322)',
  :ie7 =>
    'Mozilla/4.0 (compatible; MSIE 7.0b; Windows NT 5.1; FDM; .NET CLR 1.1.4322)',
  :ie6 =>
    'Mozilla/4.0 (compatible; MSIE 6.1; Windows XP; .NET CLR 1.1.4322; .NET CLR 2.0.50727)',
  :safari =>
    'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_4; en-us) AppleWebKit/533.18.1 (KHTML, like Gecko) Version/5.0.2 Safari/533.18.5',
  :chrome =>
    'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_4; en-US) AppleWebKit/534.3 (KHTML, like Gecko) Chrome/6.0.472.63 Safari/534.3',
  :googlebot =>
    'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)',
  :slurp =>
    'Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)',
}

def ls
  %x{ls}.split("\n")
end

#require 'vendetta'
#print "Using Vendetta " + Vendetta::VERSION + "\n"
#Vendetta.config = {:host => "svc-qa2.wc1.yellowpages.com", :port=>"7000" }
#ap Vendetta.config
