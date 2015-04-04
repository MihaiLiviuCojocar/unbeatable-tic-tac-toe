class Row
  EMPTY_CELLS = Proc.new { |cell| cell.content.nil? }

  attr_reader :cells, :marker

  def initialize(opt = {})
    @cells  = opt.fetch(:cells)
    @marker = opt.fetch(:marker)
  end

  def has_available_cell_for_marking?
    cells.any?(&EMPTY_CELLS)
  end

  def has_only_my_marker?
    cells.reject(&EMPTY_CELLS).all? { |cell| cell.content == marker }
  end

  def has_an_opportunity_to_win?
    has_only_my_marker? and has_available_cell_for_marking?
  end
end
