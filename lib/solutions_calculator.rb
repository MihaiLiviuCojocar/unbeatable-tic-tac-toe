class SolutionsCalculator
  attr_reader :grid, :marker

  POSSIBLE_COMBINATIONS = [
    [:A1, :B1, :C1],
    [:A2, :B2, :C2],
    [:A3, :B3, :C3],
    [:A1, :A2, :A3],
    [:B1, :B2, :B3],
    [:C1, :C2, :C3],
    [:A1, :B2, :C3],
    [:A3, :B2, :C1]
  ]

  def initialize(options = {})
    @grid   = options[:grid]
    @marker = options[:marker]
  end

  def possible_combinations
    POSSIBLE_COMBINATIONS.map do |row|
      Row.new(cells: row.map { |coordinate| grid.matrix[coordinate] }, marker: marker)
    end
  end

  def winning_solutions
    possible_combinations.map do |row|
      get_key_of(row.winning_cell)
    end
  end

  def defending_solutions
    possible_combinations.map do |row|
      get_key_of(row.defending_cell)
    end
  end

  def first_move_recomandation
    recommend_middle or recommend_a_corner
  end

  private

  def get_key_of(cell)
    grid.matrix.key(cell)
  end

  def recommend_a_corner
    grid.corner_coordinates.sample
  end

  def recommend_middle
    grid.middle_coordinate if grid.has_middle_free?
  end
end
