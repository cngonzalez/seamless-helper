require 'pry'
require 'nokogiri'
require 'open-uri'

def get_restaurant_urls(url)
  [] = restuarant_urls
  search = Nokogiri::HTML(open("http://www.menupages.com/restaurants/soho-trbca-findist/all-neighborhoods/all-cuisines/"))
  search.css("table#my-search-results .link").each do |item|
    puts item.attribute("href").value
  end
end

  # search.css(".sresult").each do |item|
  #   sukajan = Sukajan.new(item.css(".gvtitle h3").text.delete "\n" "\r" "\t")
  #   sukajan.profile_url = item.css(".gvtitle h3 a").attribute("href").value
  #   sukajan.calculate_shipping(sukajan, item)
  #   sukajan.bin_or_auction(sukajan, item)
  #   all << sukajan

get_menu_items(menu_page)
[] = menu_items
menu
