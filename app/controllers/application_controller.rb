require './config/environment'

class ApplicationController < Sinatra::Base
  include Helpers
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :welcome
  end

  get '/index' do
    erb :search
  end

  post '/index' do
    binding.pry
  end 

end
