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
    end.compact
  end

  def defending_solutions
    possible_combinations.map do |row|
      get_key_of(row.defending_cell)
    end.compact
  end

  def first_move_recommendation
    recommend_middle or recommend_a_corner
  end

  def need_to_defend?
    defending_solutions.any?
  end

  def second_move_recommendation
    if middle_is_mine?
      recommend_a_defending_solution or recommend_the_middle_of_a_line
    else
      recommend_a_defending_solution or recommend_a_corner
    end
  end

  def any_opportunity_to_win?
    winning_solutions.any?
  end

  def recommend_winning_solution
    winning_solutions.sample if any_opportunity_to_win?
  end

  def third_move_recommendation
    recommend_winning_solution if any_opportunity_to_win?
    recommend_a_defending_solution if need_to_defend?
    recommend_the_middle_of_a_line if any_middle_line_cell_free?
    recommend_an_empty_cell
  end

  def recommendation
    recommend_winning_solution or recommend_a_defending_solution or recommend_an_empty_cell
  end

  private

  def any_middle_line_cell_free?
    grid.middle_line_coordinates.all? { |coord| !grid.matrix[coord].has_content? }
  end

  def middle_is_mine?
    grid.get_content(grid.middle_coordinate).content == marker
  end

  def get_key_of(cell)
    grid.matrix.key(cell)
  end

  def recommend_a_corner
    coord = grid.corner_coordinates.sample
    until grid.available_cells_coordinates.include?(coord) do
      coord = grid.corner_coordinates.sample
    end
    coord
  end

  def recommend_middle
    grid.middle_coordinate if grid.has_middle_free?
  end

  def recommend_the_middle_of_a_line
    coord = grid.middle_line_coordinates.sample
    until grid.available_cells_coordinates.include?(coord) do
      coord = grid.middle_line_coordinates.sample
    end
    coord
  end

  def recommend_a_defending_solution
    defending_solutions.first if need_to_defend?
  end

  def recommend_an_empty_cell
    grid.available_cells_coordinates.sample
  end
end
