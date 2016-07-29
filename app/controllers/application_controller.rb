require './config/environment'

class ApplicationController < Sinatra::Base
  include Helpers
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions
    set :session_secret, "!@$%^&QWERasdf"
    use Rack::Flash
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
