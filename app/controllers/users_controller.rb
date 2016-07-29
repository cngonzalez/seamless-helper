require './config/environment'
require 'rack-flash'

class UsersController < ApplicationController

	get '/login' do 
    	@login_active = true
    
		erb :'/users/login'
	end

	after '/login' do
	    @login_active = false
	end

	post '/login' do 
		user_params = params[:user]

		if user_params[:username].empty? ||
			user_params[:password].empty?

			flash[:message] = "Please fill in all fields."
			redirect '/login'
		else
			user = User.find_by(username: params[:user][:username])
			if user && user.authenticate(params[:user][:password])
				session[:user_id] = user.id
				redirect '/'
			else
				flash[:message] = "No such user. Please sign up a new user."
				redirect '/signup'
			end
		end
	end

	get '/signup' do 
	# unless session[:user_id].nil?
      @signup_active = true
    # end
		erb :'/users/signup'
	end
	after '/signup' do
    @signup_active = false
  end

	post '/signup' do 
		if params[:user].any? { |_, value| value.empty? }
			flash[:message] = "Please fill in all fields."
			redirect '/signup'
		else
			
			user_exist = User.find_by(username: params[:user][:username])
			if user_exist
				# ???????????????????
				flash[:message] = "#{user_exist.username} exists. Please log in."
				redirect '/login'
			else
				user = User.create(params[:user])
				session[:user_id] = user.id
				redirect '/'
			end
		end
	end

	get '/logout' do 
		session[:user_id] = nil
		@logged_in = false
		redirect '/'
	end
end