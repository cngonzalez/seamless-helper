require './config/environment'

@@search = ""

class ApplicationController < Sinatra::Base
  include Helpers
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions
    set :session_secret, "!@$%^&QWERasdf"
    use Rack::Flash
  end

  ['/'].each do |path|
    before path do
      if session[:user_id].nil? || User.find_by(id:session[:user_id]).nil?
        flash[:message] = "Please log in first."
        session[:user_id] = nil
        redirect '/login'
      end
    end
  end

  get "/" do
    erb :welcome
  end

  post '/search' do
    scrape_search_url(params)
    redirect '/results'
  end

  get '/results' do
    @dishes = Dish.all
    erb :results
  end

end
