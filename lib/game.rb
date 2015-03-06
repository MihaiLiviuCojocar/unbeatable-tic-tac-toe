class Game
  attr_writer :grid

  def has_grid?
    !@grid.nil?
  end

  def has_two_players?
    has_player_one? and has_player_two?
  end

  def add_player(player)
    has_player_one? ? add_player_two(player) : add_player_one(player)
  end

  def has_player_one?
    !@player_one.nil?
  end

  def has_player_two?
    !@player_two.nil?
  end

  def ready_to_start?
  end

  private

  def add_player_one(player)
    @player_one = player
  end

  def add_player_two(player)
    @player_two = player
  end
end
