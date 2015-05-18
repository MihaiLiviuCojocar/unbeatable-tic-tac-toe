module Recommendation
  MIDDLE_LINE_NEIGHBOURS = {
    A2: [:A1, :A3],
    B1: [:A1, :C1],
    B3: [:A3, :C3],
    C2: [:C1, :C3]
  }
  
  def first_move_recommendation
    return recommend_a_corner if nobody_moved_yet? or enemy_marked_middle?
    return recommend_corner_in_proximity_of(find_which_middle_line) if enemy_took_middle_line?
    recommend_middle
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

  def recommend_winning_solution
    winning_solutions.sample
  end

  private
  
  def available_moves
    grid.available_cells_coordinates
  end

  def middle_coordinate
    grid.middle_coordinate
  end

  def middle_line_coordinates
    grid.middle_line_coordinates
  end

  def corner_coordinates
    grid.corner_coordinates
  end

  def nobody_moved_yet?
    grid.coordinates.all? { |coord| !grid.matrix[coord].has_content? }
  end
  
  def enemy_marked_middle?
    !grid.has_middle_free?
  end

  def any_middle_line_cell_free?
    middle_line_coordinates.any? { |coord| !grid.matrix[coord].has_content? }
  end

  def middle_is_mine?
    grid.get_content(middle_coordinate).content == marker
  end

  def recommend_a_corner
    coord = corner_coordinates.sample
    until available_moves.include?(coord) do
      coord = corner_coordinates.sample
    end
    coord
  end

  def recommend_middle
    middle_coordinate
  end

  def recommend_the_middle_of_a_line
    coord = middle_line_coordinates.sample
    until available_moves.include?(coord) do
      coord = middle_line_coordinates.sample
    end
    coord
  end

  def recommend_a_defending_solution
    defending_solutions.first
  end

  def recommend_an_empty_cell
    available_moves.sample
  end

  def recommend_corner_in_proximity_of(coord)
    MIDDLE_LINE_NEIGHBOURS[coord].sample
  end

  def find_which_middle_line
    middle_line_coordinates.select { |coord| grid.get_content(coord).has_content? }.first
  end

  def enemy_took_middle_line?
    middle_line_coordinates.any? { |coord| grid.get_content(coord).has_content? }
  end
end
