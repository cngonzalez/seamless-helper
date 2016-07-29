require 'pry'
require 'nokogiri'
require 'open-uri'

def get_restaurant_urls(url)
  restaurant_urls = []
  search = Nokogiri::HTML(open(url))
  search.css("table#my-search-results .link").each do |item|
    url = "http://www.menupages.com#{item.attribute("href").value}menu"
    restaurant_urls << url
  end
end

  # search.css(".sresult").each do |item|
  #   sukajan = Sukajan.new(item.css(".gvtitle h3").text.delete "\n" "\r" "\t")
  #   sukajan.profile_url = item.css(".gvtitle h3 a").attribute("href").value
  #   sukajan.calculate_shipping(sukajan, item)
  #   sukajan.bin_or_auction(sukajan, item)
  #   all << sukajan

def get_menu_items(restaurant_url)
  
end
