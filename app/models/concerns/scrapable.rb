require 'pry'
require 'nokogiri'
require 'open-uri'

def get_restaurants(url)
  restaurants = []
  search = Nokogiri::HTML(open(url))
  search.css("table#my-search-results .link").each do |item|
    restaurant = Restaurant.new(url: "http://www.menupages.com#{item.attribute("href").value}menu")
    restaurants << restaurant
  end
  restaurants
end

def get_menu_items(restaurant)
  dishes = []
  menu_page = Nokogiri::HTML(open(restaurant.url))
  menu_page.css("tr").each do |item|
    dish = Dish.new
    dish.name = item.css("th cite").text
    dish.ingredients = item.css("th").text.gsub(dish[:name], "")[1..-1]
    price = item.css("td").text.delete "\n" "\r" " " " "
    dish.price = price[-5..-1]
    dish.restaurant_id = restaurant.id
    dishes << dish
  end
  dishes
end

def parse_search_url(params)
  binding.pry
  all_dishes = []
  params[:category].each do |category|
    category = category.gsub("-", " ").downcase
    category_restaurants = get_restaurants("http://www.menupages.com/restaurants/soho-trbca-findist/all-neighborhoods/#{category}")
    category_restaurants.each do |restaurant|
      dishes = get_menu_items(restuarant)
      dishes.each{|dish| all_dishes << dish if dish.name.include?(category)}
    end
  end
  all_dishes
end
