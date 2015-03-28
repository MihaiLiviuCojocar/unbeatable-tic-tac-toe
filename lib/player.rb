class Player
  attr_reader   :name, :grid
  attr_accessor :marker

  def initialize(options = {})
    @name = options.fetch(:name)
    @grid = options.fetch(:grid)
  end

  def winner?
  end
end
