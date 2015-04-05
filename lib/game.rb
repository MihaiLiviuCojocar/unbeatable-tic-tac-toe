require_relative 'exceptions'

class Game
  WINNER = Proc.new{ |player| player.winner? }

  attr_reader :moves_count

  def initialize
    @moves_count = 0
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
    raise GameOverError.new(winner.name) if over?
    raise DrawGameError if draw?
    @current_player = current_player == @player_one ? @player_two : @player_one
  end

  def over?
     has_two_players? and has_winner?
  end

  def draw?
    moves_count == 9 and !has_winner?
  end

  def winner
    players.select(&WINNER).first
  end

  def find_player_by_name(name)
    players.select { |player| player.name == name }.first
  end

  def make_move(at_coordinate)
    current_player.place_marker(at_coordinate)
    increase_moves_count_by_one
    switch_turns
  end

  private

  def increase_moves_count_by_one
    @moves_count += 1
  end

  def add_player_one(player)
    @player_one = player
  end

  def add_player_two(player)
    @player_two = player
  end

  def players
    [@player_one, @player_two]
  end

  def has_winner?
    !winner.nil?
  end
end
