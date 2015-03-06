class Game
  attr_writer :grid

  def has_grid?
    !@grid.nil?
  end

  def has_two_players?
  end

  def add_player(player)
    has_player_one? ? @player_two = player : @player_one = player
  end

  def has_player_one?
    !@player_one.nil?
  end

  def has_player_two?
    !@player_two.nil?
  end
end
