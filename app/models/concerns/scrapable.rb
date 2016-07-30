require 'pry'
require 'nokogiri'
require 'open-uri'
# require 'activesupport/inflector'

def get_restaurants(url)
  restaurants = []
  search = Nokogiri::HTML(open(url))
  search.css("table#my-search-results .link").each do |item|
    restaurant = Restaurant.find_or_create_by(url: "http://www.menupages.com#{item.attribute("href").value}menu")
    restaurants << restaurant
  end
  restaurants
end

def get_category_items(restaurant, category)
  menu_page = Nokogiri::HTML(open(restaurant.url))
  menu_page.css("tr").each do |item|
    if item.css("th").include?(category[0..-2])
      dish = Dish.find_or_create_by(name: item.css("th cite").text)
      dish.ingredients = item.css("th").text.gsub(dish[:name], "")[1..-1]
      price = item.css("td").text.delete "\n" "\r" " " " "
      dish.price = price[-5..-1]
      dish.restaurant_id = restaurant.id
      dish.search = category
      dish.save
    end
  end
end

def scrape_search_url(params)
  populate_dishes(params[:category]) if params[:category]
  populate_dishes_cuisine(params[:cuisine]) if params[:cuisine]
  binding.pry
end

def populate_dishes(sub_hash)
  sub_hash.each do |category|
    category = category.gsub("-", " ").downcase
    category_restaurants = get_restaurants("http://www.menupages.com/restaurants/soho-trbca-findist/all-neighborhoods/#{category}")
    category_restaurants[0..2].each do |restaurant|
      begin
      get_category_items(restaurant, category)
      rescue
        next
      end
    end
  end
end

def populate_dishes_cuisine(sub_hash)
  sub_hash.each do |cuisine|
    cuisine = cuisine.gsub("-", " ").downcase
    cuisine_restaurants = get_restaurants("http://www.menupages.com/restaurants/soho-trbca-findist/all-neighborhoods/#{cuisine}")
    cuisine_restaurants.each do |restaurant|
      begin
      get_cuisine_items(restaurant, cuisine)
      rescue
        next
      end
    end
  end
end

def get_cuisine_items(restaurant, cuisine)
  menu_page = Nokogiri::HTML(open(restaurant.url))
  menu_page.css("tr").each do |item|
      dish = Dish.find_or_create_by(name: item.css("th cite").text)
      dish.ingredients = item.css("th").text.gsub(dish[:name], "")[1..-1]
      price = item.css("td").text.delete "\n" "\r" " " " "
      dish.price = price[-5..-1]
      dish.restaurant_id = restaurant.id
      dish.search = cuisine
      dish.save
  end
end
