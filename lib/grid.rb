class Grid
  DEFAULT_SIZE = 1

  def initialize(size: DEFAULT_SIZE)
    @matrix = matrix_builder(size)
  end

  def coordinates
    @matrix.keys
  end

  private

  def matrix_builder(size)
    [*'A'..equivalent_letter_for(size)].map{ |letter| [*1..size].map { |number| {"#{letter}#{number}".to_sym => nil  } } }.flatten.reduce(:merge)
  end

  def equivalent_letter_for(number)
    (number + 64).chr
  end

end
