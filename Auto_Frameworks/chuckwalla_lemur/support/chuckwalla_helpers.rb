module ChuckwallaHelpers

  def start_browser(opts={})
    {:capture_network_traffic => false}.merge!(opts)
    if opts[:capture_network_traffic]
      @browser.start_new_browser_session(
        :captureNetworkTraffic => true
      )
    else
      @browser.start_new_browser_session
    end
    @browser.open "/"
    @browser.wait_for_page
  end

  def register_user
    {
      :username => 'testuser',
      :password => 'password',
    }
  end

  # Search for category or name.
  def search_for(* search_criteria)
    if (search_criteria.size == 2)
      @browser.type "search-terms", search_criteria[0]

      if (search_criteria[1] == "user_default")
        search_criteria[1] = @browser.get_eval("this.browserbot.getUserWindow().document.getElementById('search-location').value")
      end

      @browser.type "search-location", search_criteria[1]
      @browser.click "search-submit"
      @browser.wait_for_page
      @results = SearchResults.new @browser.get_html_source
    
    elsif (search_criteria.size == 1)
      @browser.click "css=#phone-searchbox-tab"
      @browser.type "phone-search-terms", search_criteria[0]
      @browser.click "phone-search-submit"
      @browser.wait_for_page
      @results = SearchResults.new @browser.get_html_source

    else
     refute true, "Reason of Failing: Invalid # of args provided in search_for method." 
    end
  end

  # Refine search results.
  def refine_search(refinement, value)
    refine_by = case refinement
      when /distance/i
        "Distance"
      when /rating/i
        "Rating"
      when /neighborhood/i
        "Neighborhood"
      when /category/i
        "Category"
      when /feature/i
        "Feature"
      when /a-z/i
        "A-Z"
    end
    @browser.click("link=#{refine_by}")
    @browser.click("css=label:contains(\'#{value}\')")
    @browser.wait_for_page
    @results = SearchResults.new @browser.get_html_source
  end

  # Sort search results.
  def sort_results_by(order)
    sort_by = case order
      when /best match/i
        "Best Match"
      when /distance/i
        "Distance"
      when /name/i
        "Name (A-Z)"
    end
    @browser.select "order", "label=#{sort_by}"
    @browser.wait_for_page
    @results = SearchResults.new @browser.get_html_source
  end

  # Remove query string parameter.
  def reject_query_param(url, param)
    base_url, query = url.split('?')
    new_query = query.split('&').reject {|el| el =~ /#{param}=/}
    [base_url, new_query].join('?')
  end

  # Directly navigate to a specific SRP page number.
  def open_results_page(page_number)
    url = @browser.get_location
    new_url = reject_query_param(url, "page")
    @browser.open "#{new_url}&page=#{page_number}"
    @browser.wait_for_page
    @results = SearchResults.new @browser.get_html_source
  end

  def random_location
    locations = TESTDATA[:locations]
    locations[rand(locations.length)]
  end

  def random_search_term
    search_terms = TESTDATA[:search_terms]
    search_terms[rand(search_terms.length)]
  end

  def random_popular_category
    category = TESTDATA[:popular_categories]
    category[rand(category.length)]
  end

  def search_results
    SearchResults.new @browser.get_html_source
  end

  def more_info
    MoreInfo.new @browser.get_html_source
  end

  def visit(page) 
    @browser.open path_to(page)
  end

  def path_to(page)
    path = case page
      when /homepage/i
        "/"
      when /about/i
        "/about"
      when /contact/i
        "/about/contact-us"
    end
  end
end
