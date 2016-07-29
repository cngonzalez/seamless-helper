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

def get_menu_items(restaurant)
  items = []
  menu_page = Nokogiri::HTML(open("http://www.menupages.com/restaurants/Acqua-at-peck-slip/menu")).css("div#restaurant-menu table")
  menu_page.css("tr").each do |item|
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

def parse_search_url(params)
  params[:category].each do |category|
  category_restaurants = get_restaurant_urls("http://www.menupages.com/restaurants/soho-trbca-findist/all-neighborhoods/#{category}")
  category_restaurants.each do |restaurant|
    items = get_menu_items(restuarant)
end
