require 'sinatra/base'
require 'sinatra/flash'
require_relative './helpers/application_helpers'
require_relative '../loader'

class TicTacToe < Sinatra::Base
  include ApplicationHelpers

  enable :sessions
  register Sinatra::Flash

  grid = Grid.new(size: 3)
  grid.set_content_with(Cell)
  game = Game.new(grid: grid)

  get '/' do
    erb :index
  end

  post '/register' do
    @name  = params[:player_name]
    player = Player.new(name: @name, grid: grid)
    game.add_player(player)
    prepare_player(player, game)
    erb :choose_game
  end

  get '/play/human' do
    erb :second_player
  end

  post '/fight' do
    player = Player.new(name: params[:second_player_name], grid: grid)
    game.add_player(player)
    prepare_player(player, game)
    redirect '/play'
  end

  get '/play' do
    @game = game
    erb :play
  end

  post '/play' do
    coordinate = (params[:letter] + params[:number]).to_sym
    begin
      game.make_move(coordinate)
      computer_makes_his_move(game)
    rescue GameOverError => e
      flash[:notice] = e.message
    rescue DrawGameError => e
      flash[:notice] = e.message
    rescue CellAlreadyMarkedError => e
      flash[:cell_error] = e.message
    end
    redirect '/play'
  end

  get '/play_again' do
    redirect '/play'
  end

  get '/reset' do
    grid.clear!
    grid.set_content_with(Cell)
    game = Game.new(grid: grid)
    erb :index
  end

  get '/play/computer/minimax' do
    ai = Ai.new(grid: grid)
    game.add_player(ai)
    prepare_minimax_ai(ai, game)
    redirect '/play'
  end

  get '/play/computer/rule_based' do
    ai = Ai.new(grid: grid)
    game.add_player(ai)
    prepare_rule_based_ai(ai, game)
    redirect '/play'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
