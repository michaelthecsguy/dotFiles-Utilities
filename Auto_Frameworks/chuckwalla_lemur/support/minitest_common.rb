module MinitestCommon
  def setup
    @verification_errors = []
    @browser = case SELENIUM
      when "ondemand"
        Selenium::Client::Driver.new(
          :host => "saucelabs.com",
          :port => 4444,
          :browser => {
            "username"        => ONDEMAND[:username],
            "access-key"      => ONDEMAND[:api_key],
            "os"              => BROWSER['os'],
            "browser"         => BROWSER['selenium_name'],
            "browser-version" => BROWSER['short_version'],
            "job-name"        => "WEBYP #{GIT_COMMIT}"
          }.to_json,
          :url                => CONFIG[:base_url],
          :timeout_in_second  => 90
        )
      when "ypgrid"
        Selenium::Client::Driver.new(
          :host     => "ypgrid.np.wc1.yellowpages.com",
          :port     => 4444,
          :browser  => "#{BROWSER['long_name']} #{BROWSER['short_version']}",
          :url      => CONFIG[:base_url],
          :timeout_in_second  => 60
        )
      when "localhost"
        Selenium::Client::Driver.new(
          :host     => "localhost",
          :port     => 4444,
          :browser  => "*chrome",
          :url      => CONFIG[:base_url],
          :timeout_in_second => 60
        )
    end
  end

  def teardown
    @browser.close_current_browser_session
    #assert_equal [], @verification_errors
  end
end
