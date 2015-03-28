class Player
  attr_reader   :name
  attr_accessor :marker, :grid

  def initialize(options = {})
    @name = options.fetch(:name)
  end

  def winner?
  end
end
