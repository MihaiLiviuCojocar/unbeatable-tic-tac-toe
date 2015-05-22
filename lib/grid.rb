require_relative 'matrix_builder'

class Grid
  include MatrixBuilder

  DEFAULT_SIZE = 1

  attr_reader :size

  def initialize(size: DEFAULT_SIZE)
    @size   = size
    @matrix = build_matrix(@size)
  end

  def coordinates
    @matrix.keys
  end

  def middle_coordinate
    :B2
  end

  def middle_line_coordinates
    [:A2, :B1, :B3, :C2]
  end

  def corner_coordinates
    [:A1, :A3, :C1, :C3]
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

  def clear!
    @matrix = build_matrix(size)
  end

  def has_middle_free?
    !get_content(middle_coordinate).has_content?
  end

  def available_cells_coordinates
    available_cells.map do |cell|
      get_key_of(cell)
    end
  end

  def dupdup
    cloned_grid = Grid.new(size: size)
    coordinates.each do |coord|
      cloned_grid.set_content(
        at_coordinate: coord,
        content: get_content(coord).dup
      )
    end
    cloned_grid
  end

  private

  def available_cells
    matrix.values.reject { |cell| cell.has_content? }
  end

  def get_key_of(cell)
    matrix.key(cell)
  end
end
