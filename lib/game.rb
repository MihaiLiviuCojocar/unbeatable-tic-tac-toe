require_relative 'exceptions'

class Game
  WINNER = Proc.new{ |player| player.winner? }

  attr_reader :player_one, :player_two, :grid
  attr_writer :grid

  def initialize(opt = {})
    @grid = opt.fetch(:grid)
  end

  def has_two_players?
    has_player_one? and has_player_two?
  end

  def add_player(player)
    raise GameFullError if has_two_players?
    has_player_one? ? add_player_two(player) : add_player_one(player)
  end

  def has_player_one?
    !@player_one.nil?
  end

  def has_player_two?
    !@player_two.nil?
  end

  def ready_to_start?
    has_two_players?
  end

  def current_player
    @current_player ||= @player_one
  end

  def switch_turns
    raise GameOverError.new(winner.name) if has_winner?
    raise DrawGameError if draw?
    @current_player = current_player == @player_one ? @player_two : @player_one
  end

  def over?
     (has_two_players? and has_winner?) or draw?
  end

  def winner
    players.select(&WINNER).first
  end

  def find_player_by_name(name)
    players.select { |player| player.name == name }.first
  end

  def make_move(at_coordinate)
    current_player.place_marker(at_coordinate)
    switch_turns
  end

  def has_winner?
    !winner.nil? and has_two_players?
  end

  def available_moves
    grid.available_cells_coordinates
  end

  def final_move?
    available_moves_count == 1
  end

  def draw?
     all_moves_done? and !has_winner?
  end
  private

  def add_player_one(player)
    @player_one = player
  end

  def add_player_two(player)
    @player_two = player
  end

  def players
    [player_one, player_two]
  end

  def all_moves_done?
    available_moves_count == 0
  end

  def available_moves_count
    available_moves.count
  end
end
