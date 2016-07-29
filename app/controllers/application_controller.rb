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

  post '/search' do
    binding.pry
  end

end
