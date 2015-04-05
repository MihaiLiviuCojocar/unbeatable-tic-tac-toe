require 'sinatra/base'
require 'sinatra/flash'
require_relative '../loader'

class TicTacToe < Sinatra::Base

  enable :sessions
  register Sinatra::Flash

  game = Game.new
  grid = Grid.new(size: 3)
  grid.set_content_with(Cell)

  get '/' do
    erb :index
  end

  post '/register' do
    @name         = params[:player_name]
    player        = Player.new(name: @name, grid: grid)
    player.marker = :X
    player.solutions_calculator = SolutionsCalculator.new(grid: grid, marker: :X)
    game.add_player(player)
    erb :choose_game
  end

  get '/play_vs_human' do
    erb :second_player
  end

  post '/fight' do
    player        = Player.new(name: params[:second_player_name], grid: grid)
    player.marker = :O
    player.solutions_calculator = SolutionsCalculator.new(grid: grid, marker: :O)
    game.add_player(player)
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
    rescue GameOverError => e
      flash[:notice] = e.message
    end
    redirect '/play'
  end

  get '/reset' do
    game = Game.new
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
