class MoreInfo
  #TODO: attr_reader :more_info
  def initialize(doc)
    @doc = doc
    @more_info = Nokogiri::HTML(@doc)
  end

  def business_name
    @more_info.css('div#basic-info > h1 > span').text.strip
  end

  def rating
    @more_info.css('div.basic-info-rating span.average-rating').text.to_f
  end

  def review_count
    @more_info.css('div.basic-info-rating span.review-count a:first').text.to_i
  end

  def address
    @more_info.css('div#basic-info span.listing-address').text.strip.
      sub(/\n{2}/, ', ').
      gsub(/\n/, ' ')
  end

  def neighborhoods
    @more_info.css('dd.neighborhood-links a').collect { |el| el.text }
  end

  def categories
    @more_info.css('dd.category-links span a').collect { |el| el.text }
  end
  
  def phone
    @more_info.css('p.phone').text
  end

  def recent_reviews
    recent_reviews = @more_info.css('div#business-reviews li[id^="review-"]')
    reviews_ary(recent_reviews)
  end

  def social_share_lightbox_links
    lightbox_link = @more_info.css('div.save-and-share ul[class$="_listing"]')
    social_share_lightbox_link_ary(lightbox_link)
  end

  private
  def reviews_ary(ns)
    reviews = ns.collect do |el|
      {
        :title    => el.css('h4').text,
        :byline   => el.css('p.recent-review-byline').text.strip.gsub(/\n/, ' '),
        :author   => el.css('p.recent-review-byline span a').text.strip,
        :provider => el.css('span.review-provider span').text.strip,
        :text     => el.css('div.review-text').text,
      }  
    end
    return reviews
  end

  def social_share_lightbox_link_ary(mi)
    lightbox_links = mi.collect do |el|
      {
        #TODO: collect_with_index??
        :link_title  => el.css('li > a').attr('title').text,
        :link_url    => el.css('li > a').attr('href').text
      }
    end
    return lightbox_links
  end
end
