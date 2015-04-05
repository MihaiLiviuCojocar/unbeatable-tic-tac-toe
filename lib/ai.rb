require_relative 'player'

class Ai < Player
  def initialize(opt = {})
    super(name: 'Computer', grid: opt[:grid])
  end
end
