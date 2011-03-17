class SearchResults

  def initialize(doc)
    @doc = doc
    @search_results = Nokogiri::HTML(@doc).css('div#search-results div[id^="lid-"]')
    @catexp_results = Nokogiri::HTML(@doc).css('div#catexp-results div[id^="lid-"]')
  end

  # Organic search results.
  def organic
    results_ary(@search_results, :organic)
  end

  # Category Expansion results.
  def catexp
    results_ary(@catexp_results, :catexp)
  end

  # All search results.
  def all
    organic() + catexp()
  end

  # Results with coupons feature.
  def feature(fe)
    self.organic.collect { |el| el if el[:features].any? {|f| f =~ /#{fe}/i} }.compact
  end

  # Total results count.
  def length
    (@search_results + @catexp_results).length
  end

  # Results summary.
  def summary
    @summary = Nokogiri::HTML(@doc).css('h2.results-summary')
    summary_text = @summary.text.gsub(/\n{2,}?/, ' ').strip
    match_data = summary_text.match(/^(.*):\s(\d+)-(\d+)\s+of\s+(\d+)$/)
    {
      :text  => summary_text,
      :from  => match_data[2].to_i,
      :to    => match_data[3].to_i,
      :total => match_data[4].to_i,
    }
  end

  # Return SRP page count given total number of results.
  def page_count
    (self.summary[:total] / SRP_RESULTS_PER_PAGE).ceil
  end

  private

  def results_ary(ns, type=nil)
    results = ns.collect.with_index do |el,i|
      listing_href = el.css('h3.business-name > a').attr('href').value
      h = {
        :type                     => type, # included for dumping/ debugging results
        :listing_href             => listing_href,
        :ypid                     => listing_href.split("?")[0].scan(/-(\d+)$/).join,
        :lid                      => listing_href.scan(/lid=(\d+)/).join,
        :business_name            => el.css('h3.business-name > a').text,
        :listing_address          => el.css('span.listing-address').text.strip.gsub(/\n+/, ' '),
        :business_phone           => el.css('span.business-phone').text.strip,
        :average_rating           => el.css('span.average-rating').text.strip.to_f,
        :review_count             => el.css('span.review-count a span').text.to_i,
        :distance                 => el.css('div.distance').text.strip,
        :features                 => el.css('ul.features li').collect {|el| el.css('a').text.strip},
        :business_neighborhoods   => el.css('ul.business-neighborhoods li').collect { |el| el.text.strip},
        :business_catgories       => el.css('ul.business-categories li').collect { |el| el.text.strip},
      }  
      if type == :organic
        h.merge!(
          {
            :social_share_hrefs      => el.css('div.social-share-box a').collect { |el| el.attr('href')},
            :relevance_feedback_href => el.css('span.inaccuracy a').attr('href').value,
          }
        )
      end
      h
    end
    return results
  end
end
