class Row
  EMPTY_CELLS  = Proc.new { |cell| cell.content.nil? }
  CELL_CONTENT = Proc.new { |cell| cell.content }
  ONE_CELL     = 1

  attr_reader :cells, :marker

  def initialize(opt = {})
    @cells  = opt.fetch(:cells)
    @marker = opt.fetch(:marker)
  end

  def has_one_available_cell_for_marking?
    cells.count(&EMPTY_CELLS) == ONE_CELL
  end

  def has_only_my_marker?
    cells.reject(&EMPTY_CELLS).all? { |cell| cell.content == marker }
  end

  def has_an_opportunity_to_win?
    has_only_my_marker? and has_one_available_cell_for_marking?
  end

  def winning_cell
    empty_cell if has_an_opportunity_to_win?
  end

  def has_to_defend?
    has_one_available_cell_for_marking? and has_only_two_enemy_markers?
  end

  def has_only_two_enemy_markers?
    has_only_enemy_marker? and has_only_one_type_of_marker?
  end

  def defending_cell
    empty_cell if has_to_defend?
  end

  private

  def empty_cell
    cells.select(&EMPTY_CELLS).first
  end

  def has_only_enemy_marker?
    cells.map(&CELL_CONTENT).compact.uniq.first != marker
  end

  def has_only_one_type_of_marker?
    cells.map(&CELL_CONTENT).compact.uniq.count == 1
  end
end
