module Recommendation
  MIDDLE_LINES_CELLS = {
    A2: [:A1, :A3],
    B1: [:A1, :C1],
    B3: [:A3, :C3],
    C2: [:C1, :C3]
  }
  
  def recommend_winning_solution
    winning_solutions.sample
  end

  def nobody_moved_yet?
    grid.coordinates.all? { |coord| !grid.matrix[coord].has_content? }
  end

  def first_move_recommendation
    return recommend_a_corner if nobody_moved_yet? or enemy_marked_middle?
    return recommend_corner_in_proximity_of(find_which_middle_line) if enemy_took_middle_line?
    recommend_middle
  end

  def enemy_marked_middle?
    !grid.has_middle_free?
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

  def any_middle_line_cell_free?
    grid.middle_line_coordinates.any? { |coord| !grid.matrix[coord].has_content? }
  end

  def middle_is_mine?
    grid.get_content(grid.middle_coordinate).content == marker
  end

   def recommend_a_corner
    coord = grid.corner_coordinates.sample
    until grid.available_cells_coordinates.include?(coord) do
      coord = grid.corner_coordinates.sample
    end
    coord
  end

  def recommend_middle
    grid.middle_coordinate
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

  def recommend_corner_in_proximity_of(coord)
    MIDDLE_LINES_CELLS[coord].sample
  end

  def find_which_middle_line
    grid.middle_line_coordinates.select { |coord| grid.get_content(coord).has_content? }.first
  end

  def enemy_took_middle_line?
    grid.middle_line_coordinates.any? { |coord| grid.get_content(coord).has_content? }
  end
end