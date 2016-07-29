require 'pry'
require 'nokogiri'
require 'open-uri'
# require 'activesupport/inflector'

def get_restaurants(url)
  restaurants = []
  search = Nokogiri::HTML(open(url))
  search.css("table#my-search-results .link").each do |item|
    restaurant = Restaurant.create(url: "http://www.menupages.com#{item.attribute("href").value}menu")
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
    dish.save
    dishes << dish
  end
  dishes
end

def parse_search_url(params)
  all_dishes = []
  params[:category].each do |category|
    category = category.gsub("-", " ").downcase
    category_restaurants = get_restaurants("http://www.menupages.com/restaurants/soho-trbca-findist/all-neighborhoods/#{category}")
    category_restaurants.each do |restaurant|
      begin
        dishes = get_menu_items(restaurant)
        dishes.each do |dish|
        unless dish.name.nil? || dish.ingredients.nil?
          if dish.ingredients.include?(category) || dish.name.include?(category)
            all_dishes << dish
          end
        end
        end
      rescue
        next
      end
    end
  end
  all_dishes
end
