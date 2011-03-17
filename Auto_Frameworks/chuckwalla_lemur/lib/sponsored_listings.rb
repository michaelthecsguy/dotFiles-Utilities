class SponsoredListings
  attr_accessor :featured_businesses,
                :diamonds,
                :platniums
  def initialize(doc)
    @featured_businesses = Nokogiri::HTML(doc).css('div#sponsored-listings li[id^="vcard-topwell-lid-"]')
    @diamonds = Nokogiri::HTML(doc).css('ul.diamond li[id^="rightwell-lid-"]')
    @platniums = Nokogiri::HTML(doc).css('ul.platinum li[id^="rightwell-lid-"]')
  end

  def rightwell_count
    return @diamonds.length + @platinums.length
  end

  def featured_businesses_all
    return results_ary(@featured_businesses)
  end

  private
  def results_ary(sl)
    results = sl.collect.with_index do |el,i|
      {
        #TODO: Do we need to parse Address into Street, City, Region?
        :result_number   => i + 1,
        :business_name   => el.css('h3.title > a').text,
        :listing_address => el.css('span.listing-address').text.strip.gsub(/\n+/, ' '),
        :business_phone  => el.css('span.phone').text.strip,
        :features        => el.css('ul.features li').collect {|el| el.css('a').text.strip},
        :feature_urls    => el.css('ul.features a').collect {|el| el.attr('href')},
        :ad_icon_ext_url => el.css('span.biz_graphic a').attr('href').text,
      }  
    end
    return results
  end
end