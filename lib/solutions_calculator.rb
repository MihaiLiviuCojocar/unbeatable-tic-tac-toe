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

  def need_to_defend?
    defending_solutions.any?
  end

  def second_move_recommandation
    recommend_a_defending_solution or recommend_the_middle_of_a_line
  end

  def any_opportunity_to_win?
    winning_solutions.any?
  end

  def recommend_winning_solution
    winning_solutions.sample if any_opportunity_to_win?
  end

  def recommandation
    recommend_winning_solution or recommend_a_defending_solution or recommend_an_empty_cell
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

  def recommend_the_middle_of_a_line
    grid.middle_line_coordinates.sample
  end

  def recommend_a_defending_solution
    defending_solutions.first if need_to_defend?
  end

  def recommend_an_empty_cell
    grid.available_cells_coordinates.sample
  end
end
