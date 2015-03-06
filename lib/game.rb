require_relative 'exceptions'

class Game
  attr_writer :grid

  def has_grid?
    !@grid.nil?
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
    has_two_players? and has_grid?
  end

  def current_player
    @current_player ||= @player_one
  end

  def switch_turns
    raise GameOverError.new(winner.name) if over?
    @current_player = current_player == @player_one ? @player_two : @player_one
  end

  def over?
     has_two_players? and has_winner?
  end

  def winner
    players.select{ |player| player.winner? }.first
  end

  private

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
