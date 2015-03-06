class Game
  attr_writer :grid

  def has_grid?
    !@grid.nil?
  end
end
