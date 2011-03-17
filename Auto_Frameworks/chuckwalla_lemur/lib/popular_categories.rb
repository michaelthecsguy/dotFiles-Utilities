class PopularCategories
  attr_accessor :category_names

  def initialize(doc)
    @category_names = Nokogiri::HTML(doc).css('div.drawer-content div.category-group ul li')
  end

  def popular_categories_all
    return names_ary(@category_names)
  end

  def names_ary(pc)
    pc_names = pc.collect.with_index do |el, i|
      {
        :number => i + 1,
        :category_name => el.css('a').text.strip
      }
    end
    return pc_names
  end
end
