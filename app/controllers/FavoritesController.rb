class FavoritesController < ApplicationController

	get '/favorites' do 
		user = User.find(session[:user_id])
		@favorites = user.dishes
	end

	get '/favorite/:id/delete' do 
		favorite = Dish.find(params[:id])
		favorite.destroy
	end

end