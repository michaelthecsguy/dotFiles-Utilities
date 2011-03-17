class SponsoredWebResults
  attr_accessor :sponsored_web_results

  def initialize(doc)
    @sponsored_web_results = Nokogiri::HTML(doc).css('div#yahoo_ss li[class^="tp_listing"]')
  end
end