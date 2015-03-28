class Player
  attr_reader   :name, :grid
  attr_accessor :marker

  def initialize(options = {})
    @name = options.fetch(:name)
    @grid = options.fetch(:grid)
  end

  def winner?
  end

  def place_marker(coordinate)
    grid.place_marker(at_coordinate: coordinate, marker: marker)
  end
end
