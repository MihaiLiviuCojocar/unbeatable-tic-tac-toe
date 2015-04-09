class SolutionsCalculator
  attr_reader :grid, :marker

  MIDDLE_LINES_CELLS = {
    A2: [:A1, :A3],
    B1: [:A1, :C1],
    B3: [:A3, :C3],
    C2: [:C1, :C3]
  }
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

  def recommend_winning_solution
    winning_solutions.sample
  end

  def first_move_recommendation
    return reccomend_corner_in_proximity_of(find_which_middle_line) if enemy_took_middle_line?
    recommend_middle or recommend_a_corner
  end

  def second_move_recommendation
    return recommend_a_defending_solution if need_to_defend?
    return recommend_middle if grid.has_middle_free?
    return recommend_the_middle_of_a_line if middle_is_mine?
    recommend_a_corner
  end

  def third_move_recommendation
    return recommend_winning_solution if any_opportunity_to_win?
    return recommend_a_defending_solution if need_to_defend?
    return recommend_the_middle_of_a_line if any_middle_line_cell_free?
    recommend_an_empty_cell
  end

  def recommendation
    return recommend_winning_solution if any_opportunity_to_win?
    return recommend_a_defending_solution if need_to_defend?
    recommend_an_empty_cell
  end

  def need_to_defend?
    defending_solutions.any?
  end

  def any_opportunity_to_win?
    winning_solutions.any?
  end

  private

  def any_middle_line_cell_free?
    grid.middle_line_coordinates.any? { |coord| !grid.matrix[coord].has_content? }
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
    defending_solutions.first
  end

  def recommend_an_empty_cell
    grid.available_cells_coordinates.sample
  end

  def reccomend_corner_in_proximity_of(coord)
    MIDDLE_LINES_CELLS[coord].sample
  end

  def find_which_middle_line
    grid.middle_line_coordinates.select { |coord| grid.get_content(coord).has_content? }.first
  end

  def enemy_took_middle_line?
    grid.middle_line_coordinates.any? { |coord| grid.get_content(coord).has_content? }
  end
end
