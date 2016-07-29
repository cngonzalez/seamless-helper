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

  post '/search' do
    parse_search_url(params)
    binding.pry
  end

  get '/results' do
    File.open("something" "w")
  end

end
