class Grid
  DEFAULT_SIZE = 1

  attr_reader :size

  def initialize(size: DEFAULT_SIZE)
    @size   = size
    @matrix = matrix_builder(@size)
  end

  def coordinates
    @matrix.keys
  end

  def get_content(at_coordinate)
    @matrix[at_coordinate]
  end

  def set_content(at_coordinate: :A1, content: nil)
    @matrix[at_coordinate] = content
  end

  def set_content_with(class_name)
    coordinates.each do |coordinate|
      set_content(at_coordinate: coordinate, content: class_name.new)
    end
  end

  def place_marker(at_coordinate, marker)
    get_content(at_coordinate).content = marker
  end

  def matrix
    @matrix.dup
  end

  def rows
    matrix.values.map { |cell| cell.content }.each_slice(size).to_a
  end

  private

  def matrix_builder(size)
    [*'A'..equivalent_letter_for(size)].map do |letter|
      [*1..size].map do |number|
        { "#{letter}#{number}".to_sym => nil }
      end
    end.flatten.reduce(:merge)
  end

  def equivalent_letter_for(number)
    (number + 64).chr
  end
end
