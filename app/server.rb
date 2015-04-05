require 'sinatra/base'

class TicTacToe < Sinatra::Base

  enable :sessions

  get '/' do
    erb :index
  end

  post '/register' do
    @name = params[:player_name]
    erb :choose_game
  end

  get '/play_vs_human' do
    erb :second_player
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
