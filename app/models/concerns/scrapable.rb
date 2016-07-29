require 'pry'
require 'nokogiri'
require 'open-uri'

def get_restaurant_urls(url)

  restuarant_urls = []
  search = Nokogiri::HTML(open("http://www.menupages.com/restaurants/soho-trbca-findist/all-neighborhoods/all-cuisines/"))
  search.css("table#my-search-results .link").each do |item|
    puts item.attribute("href").value
  end
end

def get_menu_items(item)
  items = [] 
  $menu_page = Nokogiri::HTML(open("http://www.menupages.com/restaurants/Acqua-at-peck-slip/menu")).css("div#restaurant-menu table") 
  $menu_page.css("tr").each do |item|
    my_item = {}
    my_item[:name] = item.css("th cite").text
    my_item[:ingredients] = item.css("th").text.gsub(my_item[:name], "")[1..-1]
    price = item.css("td").text.delete "\n" "\r" " " " "
    my_item[:price] = price[-5..-1]
    my_item[:restaurant] = "restaurant name"
    items << my_item
  end
  items
end

def parse_search_url(search_term)
  ##likely this method should be paired with something that sanitizes/compares against the search terms raycent has compiled
  url = "http://http://www.menupages.com/restaurants/soho-trbca-findist/all-neighborhoods/#{search_term}"
end
menu_items = get_menu_items($menu_page)

