require 'sinatra/base'

class TicTacToe < Sinatra::Base
  get '/' do
    erb :index
  end

  post '/register' do
    @name = params[:player_name]
    erb :choose_game
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
