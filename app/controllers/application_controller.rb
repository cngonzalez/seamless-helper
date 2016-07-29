require './config/environment'

@@results = []

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
    $results = parse_search_url(params)
    redirect '/results'
  end

  get '/results' do
    @dishes = Dish.all
    erb :results
  end

end
