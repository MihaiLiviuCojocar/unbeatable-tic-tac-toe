require 'sinatra/base'
require 'sinatra/flash'
require_relative '../loader'

class TicTacToe < Sinatra::Base

  enable :sessions
  register Sinatra::Flash

  grid = Grid.new(size: 3)
  grid.set_content_with(Cell)
  game = Game.new(grid: grid)

  get '/' do
    erb :index
  end

  post '/register' do
    @name         = params[:player_name]
    player        = Player.new(name: @name, grid: grid)
    player.marker = :X
    player.solutions_calculator = SolutionsCalculator.new(game: game, marker: :X)
    game.add_player(player)
    erb :choose_game
  end

  get '/play_vs_human' do
    erb :second_player
  end

  post '/fight' do
    player        = Player.new(name: params[:second_player_name], grid: grid)
    player.marker = :O
    player.solutions_calculator = SolutionsCalculator.new(game: game, marker: :O)
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
      game.make_move(game.current_player.ask_for_recommendation) if game.current_player.is_a?(Ai)
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

  get '/play_vs_computer' do
    ai = Ai.new(grid: grid)
    game.add_player(ai)
    ai.marker = :O
    ai.solutions_calculator = SolutionsCalculator.new(game: game, marker: ai.marker)
    redirect '/play'
  end

  get '/mark_second' do
    game.switch_turns
    game.make_move(game.current_player.ask_for_recommendation)
    redirect '/play'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
